part of 'employer_long_term_bloc.dart';

@freezed
class EmployerLongTermState with _$EmployerLongTermState {
  const factory EmployerLongTermState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    required List<EmployerLongFullTermDashboardDto> openPositionList,
    required List<dynamic> filledPositionList,
  }) = _EmployerLongTermState;

  factory EmployerLongTermState.initial() => EmployerLongTermState(
    filledPositionList: [],
    openPositionList: [],
    isNoDataFound: false,
    isErrorInAPI: false,
    isLoading: false,
    postDataLoading: false,
  );
}
