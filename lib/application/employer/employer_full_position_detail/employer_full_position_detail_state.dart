part of 'employer_full_position_detail_bloc.dart';

@freezed
class EmployerFullPositionDetailState with _$EmployerFullPositionDetailState {
  const factory EmployerFullPositionDetailState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    EmployerLongTermSuccessDto? employerLongTermSuccessDto,
  }) = _EmployerFullPositionDetailState;

  factory EmployerFullPositionDetailState.initial() => EmployerFullPositionDetailState(
    isNoDataFound: false,
    isErrorInAPI: false,
    isLoading: false,
    postDataLoading: false,
  );}
