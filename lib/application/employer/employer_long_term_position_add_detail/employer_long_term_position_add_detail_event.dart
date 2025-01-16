part of 'employer_long_term_position_add_detail_bloc.dart';

@freezed
class EmployerLongTermPositionAddDetailEvent with _$EmployerLongTermPositionAddDetailEvent {
  const factory EmployerLongTermPositionAddDetailEvent.selectStartDate({required DateTime startDate}) = SelectStartDate;

  const factory EmployerLongTermPositionAddDetailEvent.selectEndDate({required DateTime endaDate}) = SelectEndDate;

  const factory EmployerLongTermPositionAddDetailEvent.selectApplicationDeadline({required DateTime deadLine}) = SelectApplicationDeadline;

  const factory EmployerLongTermPositionAddDetailEvent.selectEstimatedHour({required TimeOfDay estimatedHour}) = SelectEstimatedHour;

  const factory EmployerLongTermPositionAddDetailEvent.onShiftScheduleChanged({required CommonDropdownModel value}) =
      OnShiftScheduleChanged;
}
