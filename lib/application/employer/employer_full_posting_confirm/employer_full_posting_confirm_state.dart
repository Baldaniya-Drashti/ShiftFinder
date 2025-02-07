part of 'employer_full_posting_confirm_bloc.dart';

@freezed
class EmployerFullPostingConfirmState with _$EmployerFullPostingConfirmState {
  const factory EmployerFullPostingConfirmState({
    required bool postDataLoading,
    required int? postId,
    required EmployerLongTermSuccessDto employerFullPosting,
    required bool isMoreVacancy,
    required Vacancy selectedVacancy,
    required bool isSaveAsTemplate,
    required bool isTermsCheck,
    required bool isIncludeOnCall,
    required InputEmptyOrNot deadLineDate,
    required bool showErrorMessage,
  }) = _EmployerFullPostingConfirmState;

  factory EmployerFullPostingConfirmState.initial() =>
      EmployerFullPostingConfirmState(
        isMoreVacancy: false,
        selectedVacancy: Vacancy(""),
        isSaveAsTemplate: false,
        isTermsCheck: false,
        isIncludeOnCall: false,
        employerFullPosting: EmployerLongTermSuccessDto(),
        postDataLoading: false,
        postId: null,
        deadLineDate: InputEmptyOrNot(""),
        showErrorMessage: false,
      );
}
