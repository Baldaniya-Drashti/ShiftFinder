import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
part 'employer_full_posting_confirm_event.dart';
part 'employer_full_posting_confirm_state.dart';
part 'employer_full_posting_confirm_bloc.freezed.dart';

@injectable
class EmployerFullPostingConfirmBloc extends Bloc<
    EmployerFullPostingConfirmEvent, EmployerFullPostingConfirmState> {
  final IMainFacade _iMainFacade;

  EmployerFullPostingConfirmBloc(this._iMainFacade)
      : super(EmployerFullPostingConfirmState.initial()) {
    on<EmployerFullPostingConfirmEvent>((event, emit) async {
      await event.map(
        checkIsMoreVancancy: (e) {
          emit(
            state.copyWith(
              isMoreVacancy: e.isMoreVacancy,
              selectedVacancy: Vacancy(""),
              showErrorMessage: false,
              employerFullPosting: state.employerFullPosting.copyWith(
                vacancie_type: e.isMoreVacancy ? 1 : 0,
                number_of_vacancie: null,
              ),
            ),
          );
        },
        addVacancyChanged: (e) {
          print("selectedValnnn---> ${e.vacancy}");
          emit(
            state.copyWith(
              selectedVacancy: Vacancy(e.vacancy),
            ),
          );
        },
        onApplicationDeadlineChanged: (value) {
          emit(
            state.copyWith(
              deadLineDate: InputEmptyOrNot(value.selectedDateTime.toString()),
              employerFullPosting: state.employerFullPosting.copyWith(
                application_deadline: value.selectedDateTime,
              ),
            ),
          );
        },
        onIncludeOnCallChanged: (value) {
          emit(
            state.copyWith(
              isIncludeOnCall: value.value,
              employerFullPosting: state.employerFullPosting.copyWith(
                on_call_included: value.value ? 1 : 0,
              ),
            ),
          );
        },
        onFuturePostingChanged: (value) {
          emit(
            state.copyWith(
              isSaveAsTemplate: value.value,
              employerFullPosting: state.employerFullPosting
                  .copyWith(save_template_status: value.value ? 1 : 0),
            ),
          );
        },
        onMoreVacancyChanged: (value) {
          emit(
            state.copyWith(
              isMoreVacancy: value.value,
              employerFullPosting: state.employerFullPosting
                  .copyWith(vacancie_type: value.value ? 1 : 0),
            ),
          );
        },
        onTermsAndConditionChanged: (value) {
          emit(
            state.copyWith(
              isTermsCheck: value.value,
              employerFullPosting: state.employerFullPosting
                  .copyWith(employer_payment_confirmation: value.value ? 1 : 0),
            ),
          );
        },
        onCreate: (OnCreate value) {
          emit(state.copyWith(
            employerFullPosting: value.employerLongTermSuccessDto,
            deadLineDate: InputEmptyOrNot(
                (value.employerLongTermSuccessDto.application_deadline ?? "")
                    .toString()),
            isMoreVacancy: value.employerLongTermSuccessDto.vacancie_type == 1,
            isSaveAsTemplate:
                value.employerLongTermSuccessDto.save_template_status == 1,
            isIncludeOnCall:
                value.employerLongTermSuccessDto.on_call_included == 1,
            selectedVacancy: Vacancy(
                (value.employerLongTermSuccessDto.number_of_vacancie != null)
                    ? "${value.employerLongTermSuccessDto.number_of_vacancie}"
                    : ""),
            postId: value.post,
          ));
        },
        onContinue: (OnContinue value) async {
          Either<MainFailure, CommonResponse<dynamic>> result;

          final isDateValid = state.deadLineDate.isValid();
          final isTermsValid = state.isTermsCheck;
          final isVacancyValid = isMoreVacancyValid(
              isMoreVacancy: state.isMoreVacancy,
              vacancyValue: state.selectedVacancy);

          if (isDateValid && isVacancyValid && isTermsValid) {
            final data = state.employerFullPosting.copyWith(
              number_of_vacancie:
                  int.tryParse(state.selectedVacancy.getValue()),
              employer_payment_confirmation: state.isTermsCheck ? 1 : 0,
              save_template_status:
                  (state.isSaveAsTemplate && !value.fromTemplate) ? 1 : 0,
              on_call_included: state.isIncludeOnCall ? 1 : 0,
            );

            emit(state.copyWith(postDataLoading: true));

            if (state.postId != null &&
                state.postId != -1 &&
                ((value.fromTemplate && value.fromReview) ||
                    !value.fromTemplate)) {
              result = await _iMainFacade.updateLongFullTermPost(data: {
                ...data.toJson(),
                // "update_status": 0,
                "update_status": 1,
                'isSendNotification': 0,
              });
            } else {
              result = await _iMainFacade.createLongFullTermPost(
                  data: data.toJson());
            }

            emit(state.copyWith(postDataLoading: false));
            result.fold(
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
                print(
                    "Full porititit---> ${state.employerFullPosting.number_of_vacancie}");
                final response = EmployerLongTermSuccessDto.fromJson(r.data);
                value.context.router.navigate(
                  PageRouteInfo(
                    EmployerFullPostingReviewView.name,
                    args: EmployerFullPostingReviewViewArgs(
                      response: response,
                      postId: state.postId,
                      data: data,
                      fromReview: value.fromReview,
                      fromTemplate: value.fromTemplate,
                      isCreate: value.isCreate,
                    ),
                  ),
                );
              },
            );
          } else {
            print("Some details are missing or invalid!!!");
          }

          emit(state.copyWith(showErrorMessage: true));
        },
      );
    });
  }

  static bool isMoreVacancyValid({
    required bool isMoreVacancy,
    required Vacancy vacancyValue,
  }) {
    if (isMoreVacancy && vacancyValue.isValid()) {
      return true;
    } else if (!isMoreVacancy) {
      return true;
    } else {
      return false;
    }
  }
}
