import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_long_full_term_dashboard/employer_long_full_term_dashboard_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'employer_full_posting_event.dart';
part 'employer_full_posting_state.dart';
part 'employer_full_posting_bloc.freezed.dart';

@injectable
class EmployerFullPostingBloc
    extends Bloc<EmployerFullPostingEvent, EmployerFullPostingState> {
  final IMainFacade _iMainFacade;

  int currentPage = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();

  EmployerFullPostingBloc(this._iMainFacade)
      : super(EmployerFullPostingState.initial()) {
    on<EmployerFullPostingEvent>((event, emit) async {
      await event.map(
        getEmployerFullPosition: (value) async {
          if (value.refresh) {
            currentPage = 1;
            emit(state
                .copyWith(employerFullPosition: [], isLoading: value.refresh));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          final response =
              await _iMainFacade.getEmployerFullPosition(page: currentPage);
          currentPage++;

          response.fold(
            (l) => emit(
              state.copyWith(
                  isErrorInAPI: true,
                  isLoading: false,
                  employerFullPosition: []),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.employerFullPosition).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                  isNoDataFound: (r.data as List<dynamic>)
                      .map((e) => EmployerLongFullTermDashboardDto.fromJson(e))
                      .toList()
                      .isEmpty,
                  employerFullPosition: List.from(state.employerFullPosition)
                    ..addAll(
                      (r.data as List<dynamic>)
                          .map((e) =>
                              EmployerLongFullTermDashboardDto.fromJson(e))
                          .toList(),
                    ),
                ),
              );
            },
          );
        },
        deletePost: (value) async {
          emit(state.copyWith(postDataLoading: true));
          final response = await _iMainFacade.deleteLongTermPost(
            id: value.id,
          );
          emit(state.copyWith(postDataLoading: false));

          response.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) {
              showSuccess(message: r.dioMessage ?? "").show(value.context);
              add(EmployerFullPostingEvent.getEmployerFullPosition(
                  context: value.context, refresh: true));
            },
          );
        },
      );
    });
  }
}
