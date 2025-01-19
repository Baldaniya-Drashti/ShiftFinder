part of 'employer_long_term_position_add_detail_bloc.dart';

@freezed
class EmployerLongTermPositionAddDetailState with _$EmployerLongTermPositionAddDetailState {
  const factory EmployerLongTermPositionAddDetailState({
    @Default(false) bool isLoading,
    @Default(false) bool isNoDataFound,
    @Default(false) bool isErrorInAPI,
    @Default(false) bool postDataLoading,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? applicationDeadlineDate,
    TimeOfDay? estimatedWeeklyHours,
    String? documentPath,
    final CommonDropdownModel? selectedShiftSchedule,
    @Default(false) final bool hasMoreVacancy,
    @Default(EmployerLongTermAddDetailDto()) EmployerLongTermAddDetailDto employerLongTermAddDetailDto,
    @Default(PostShiftDTO()) PostShiftDTO postShiftDto,
  }) = _EmployerLongTermPositionAddDetailState;

  factory EmployerLongTermPositionAddDetailState.initial() => EmployerLongTermPositionAddDetailState();
}
