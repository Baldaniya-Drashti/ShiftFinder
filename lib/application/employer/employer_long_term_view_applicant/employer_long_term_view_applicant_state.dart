part of 'employer_long_term_view_applicant_bloc.dart';

@freezed
class EmployerLongTermViewApplicantState with _$EmployerLongTermViewApplicantState {
  const factory EmployerLongTermViewApplicantState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    required List<dynamic> applicantsList,
  }) = _EmployerLongTermViewApplicantState;

  factory EmployerLongTermViewApplicantState.initial() => EmployerLongTermViewApplicantState(
    applicantsList: [],
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        postDataLoading: false,
      );
}
