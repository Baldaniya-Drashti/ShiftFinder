import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_long_term_applicant/employer_long_term_applicant_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'employer_long_term_view_applicant_event.dart';
part 'employer_long_term_view_applicant_state.dart';
part 'employer_long_term_view_applicant_bloc.freezed.dart';

@injectable
class EmployerLongTermViewApplicantBloc extends Bloc<
    EmployerLongTermViewApplicantEvent, EmployerLongTermViewApplicantState> {
  final IMainFacade _iMainFacade;
  int currentPage = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();

  EmployerLongTermViewApplicantBloc(this._iMainFacade)
      : super(EmployerLongTermViewApplicantState.initial()) {
    on<EmployerLongTermViewApplicantEvent>((event, emit) async {
      await event.map(
        getApplicants: (value) async {
          print("getApplicants => ");
          if (value.refresh) {
            currentPage = 1;
            emit(state.copyWith(applicantsList: [], isLoading: value.refresh));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          final response =
              await _iMainFacade.getEmployerLongTermPositionApplicants(
                  id: value.id, page: currentPage);
          currentPage++;
          response.fold(
            (l) => emit(
              state.copyWith(
                  isErrorInAPI: true, isLoading: false, applicantsList: []),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.applicantsList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                  isNoDataFound: (r.data as List<dynamic>)
                      .map((e) => EmployerLongTermApplicantDto.fromJson(e))
                      .toList()
                      .isEmpty,
                  applicantsList: List.from(state.applicantsList)
                    ..addAll(
                      (r.data as List<dynamic>)
                          .map((e) => EmployerLongTermApplicantDto.fromJson(e))
                          .toList(),
                    ),
                  isCardAdded: r.additional_data?.is_card_added ?? false,
                ),
              );
            },
          );
        },
        onRejectApplicant: (value) async {
          emit(state.copyWith(postDataLoading: true));
          final response =
              await _iMainFacade.employerApplicantsReject(id: value.id);
          emit(state.copyWith(postDataLoading: false));
          response.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Something went wrong!",
                ),
              ).show(value.context);
            },
            (r) {
              showSuccess(message: "Applicant reject successfully")
                  .show(value.context)
                  .then(
                (_) {
                  add(EmployerLongTermViewApplicantEvent.getApplicants(
                      context: value.context, id: value.postId, refresh: true));
                },
              );
            },
          );
        },
      );
    });
  }
}
