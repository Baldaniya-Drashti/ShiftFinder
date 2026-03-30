part of 'employer_full_posting_bloc.dart';

@freezed
class EmployerFullPostingState with _$EmployerFullPostingState {
  const factory EmployerFullPostingState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    required List<EmployerLongFullTermDashboardDto> employerFullPosition,
  }) = _EmployerFullPostingState;

  factory EmployerFullPostingState.initial() => EmployerFullPostingState(
        employerFullPosition: [],
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        postDataLoading: false,
      );
}
