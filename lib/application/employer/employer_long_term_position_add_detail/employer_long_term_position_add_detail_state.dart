part of 'employer_long_term_position_add_detail_bloc.dart';

@freezed
class EmployerLongTermPositionAddDetailState with _$EmployerLongTermPositionAddDetailState {
  const factory EmployerLongTermPositionAddDetailState({
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? applicationDeadlineDate,
    TimeOfDay? estimatedWeeklyHours,
    String? documentPath,
    final CommonDropdownModel? selectedShiftSchedule,
  }) = _EmployerLongTermPositionAddDetailState;

  factory EmployerLongTermPositionAddDetailState.initial() => EmployerLongTermPositionAddDetailState(
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        postDataLoading: false,
      );
}
