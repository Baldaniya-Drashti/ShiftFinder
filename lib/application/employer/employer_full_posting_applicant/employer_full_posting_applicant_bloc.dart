import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_long_term_applicant/employer_long_term_applicant_dto.dart';

part 'employer_full_posting_applicant_event.dart';

part 'employer_full_posting_applicant_state.dart';

part 'employer_full_posting_applicant_bloc.freezed.dart';

@injectable
class EmployerFullPostingApplicantBloc
    extends Bloc<EmployerFullPostingApplicantEvent, EmployerFullPostingApplicantState> {
  final IMainFacade _iMainFacade;
  int currentPage = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();

  EmployerFullPostingApplicantBloc(this._iMainFacade) : super(EmployerFullPostingApplicantState.initial()) {
    on<EmployerFullPostingApplicantEvent>((event, emit) async {
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
          final response = await _iMainFacade.getEmployerLongTermPositionApplicants(id: value.id, page: currentPage);
          currentPage++;
          response.fold(
                (l) => emit(
              state.copyWith(isErrorInAPI: true, isLoading: false, applicantsList: []),
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
                  isNoDataFound:
                  (r.data as List<dynamic>).map((e) => EmployerLongTermApplicantDto.fromJson(e)).toList().isEmpty,
                  applicantsList: List.from(state.applicantsList)
                    ..addAll(
                      (r.data as List<dynamic>).map((e) => EmployerLongTermApplicantDto.fromJson(e)).toList(),
                    ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
