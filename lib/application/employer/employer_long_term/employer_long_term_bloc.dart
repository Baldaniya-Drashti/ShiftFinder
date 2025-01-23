import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_long_term_open_position/employer_long_term_open_position_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'employer_long_term_event.dart';

part 'employer_long_term_state.dart';

part 'employer_long_term_bloc.freezed.dart';

@injectable
class EmployerLongTermBloc extends Bloc<EmployerLongTermEvent, EmployerLongTermState> {
  final IMainFacade _iMainFacade;

  int currentPage = 1;
  int lastPage = 1;

  final RefreshController openPositionController = RefreshController();
  final RefreshController filledPositionController = RefreshController();

  EmployerLongTermBloc(this._iMainFacade) : super(EmployerLongTermState.initial()) {
    on<EmployerLongTermEvent>((event, emit) async {
      await event.map(
        getEmployerFilledPosition: (value) async {
          if (value.refresh) {
            currentPage = 1;
            emit(state.copyWith(openPositionList: [], isLoading: value.refresh));
            openPositionController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              openPositionController.loadNoData();
              return;
            }
          }
          final response = await _iMainFacade.employerLongTermDashboard(
            positionsType: 2,
            page: 2,
          );
        },
        getEmployerLongTermOpenPosition: (value) async {
          if (value.refresh) {
            currentPage = 1;
            emit(state.copyWith(openPositionList: [], isLoading: value.refresh));
            openPositionController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              openPositionController.loadNoData();
              return;
            }
          }
          final response = await _iMainFacade.employerLongTermDashboard(positionsType: 1, page: currentPage);
          currentPage++;

          response.fold(
            (l) => emit(
              state.copyWith(isErrorInAPI: true, isLoading: false, openPositionList: []),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.openPositionList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                  isNoDataFound: (r.data as List<dynamic>).map((e) => EmployerLongTermOpenPositionDto.fromJson(e)).toList().isEmpty,
                  openPositionList: List.from(state.openPositionList)
                    ..addAll(
                      (r.data as List<dynamic>).map((e) => EmployerLongTermOpenPositionDto.fromJson(e)).toList(),
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
                  networkError: (value) => 'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) {
              showSuccess(message: r.dioMessage ?? "").show(value.context);
              add(EmployerLongTermEvent.getEmployerLongTermOpenPosition(context: value.context, refresh: true));
            },
          );
        },
      );
    });
  }
}
