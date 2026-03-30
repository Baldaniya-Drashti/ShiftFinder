part of 'employer_full_posting_applicant_bloc.dart';

@freezed
class EmployerFullPostingApplicantState with _$EmployerFullPostingApplicantState {
  const factory EmployerFullPostingApplicantState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    required List<EmployerLongTermApplicantDto> applicantsList,
  }) = _EmployerFullPostingApplicantState;

  factory EmployerFullPostingApplicantState.initial() => EmployerFullPostingApplicantState(
        applicantsList: [],
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        postDataLoading: false,
      );
}
