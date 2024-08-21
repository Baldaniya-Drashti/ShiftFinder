part of 'employer_long_term_bloc.dart';

@freezed
class EmployerLongTermState with _$EmployerLongTermState {
  const factory EmployerLongTermState({
    required bool openPostionLoading,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    required bool fillPositionLoading,
    required bool fillPositionNoDataFound,
    required bool fillPositionErrorInAPI,
    required List<EmployerLongFullTermDashboardDto> openPositionList,
    required List<EmployerLongFullTermDashboardDto> filledPositionList,
    required int selectedTab,
  }) = _EmployerLongTermState;

  factory EmployerLongTermState.initial() => EmployerLongTermState(
        isLoading: false,
        filledPositionList: [],
        openPositionList: [],
        isNoDataFound: false,
        isErrorInAPI: false,
        openPostionLoading: false,
        postDataLoading: false,
        fillPositionErrorInAPI: false,
        fillPositionLoading: false,
        fillPositionNoDataFound: false,
        selectedTab: 0,
      );
}
