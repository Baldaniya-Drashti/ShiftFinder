part of 'employer_long_term_bloc.dart';

@freezed
class EmployerLongTermState with _$EmployerLongTermState {
  const factory EmployerLongTermState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    required List<dynamic> locationList,
  }) = _EmployerLongTermState;

  factory EmployerLongTermState.initial() => EmployerLongTermState(
    locationList: [],
    isNoDataFound: false,
    isErrorInAPI: false,
    isLoading: false,
    postDataLoading: false,
  );
}
