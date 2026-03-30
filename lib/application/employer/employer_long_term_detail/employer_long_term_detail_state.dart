part of 'employer_long_term_detail_bloc.dart';

@freezed
class EmployerLongTermDetailState with _$EmployerLongTermDetailState {
  const factory EmployerLongTermDetailState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
     EmployerLongTermSuccessDto? employerLongTermSuccessDto,
  }) = _EmployerLongTermDetailState;

  factory EmployerLongTermDetailState.initial() => EmployerLongTermDetailState(
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        postDataLoading: false,
      );
}
