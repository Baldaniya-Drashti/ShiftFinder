part of 'employer_long_term_bloc.dart';

@freezed
class EmployerLongTermState with _$EmployerLongTermState {
  const factory EmployerLongTermState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    required bool fillPositionLoading,
    required bool fillPositionNoDataFound,
    required bool fillPositionErrorInAPI,
    required List<EmployerLongFullTermDashboardDto> openPositionList,
    required List<EmployerLongFullTermDashboardDto> filledPositionList,
  }) = _EmployerLongTermState;

  factory EmployerLongTermState.initial() => EmployerLongTermState(
        filledPositionList: [],
        openPositionList: [],
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        postDataLoading: false,
        fillPositionErrorInAPI: false,
        fillPositionLoading: false,
        fillPositionNoDataFound: false,
      );
}
