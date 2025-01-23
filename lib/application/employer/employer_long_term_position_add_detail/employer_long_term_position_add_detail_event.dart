part of 'employer_long_term_position_add_detail_bloc.dart';

@freezed
class EmployerLongTermPositionAddDetailEvent with _$EmployerLongTermPositionAddDetailEvent {
  const factory EmployerLongTermPositionAddDetailEvent.selectStartDate({required DateTime startDate}) = SelectStartDate;

  const factory EmployerLongTermPositionAddDetailEvent.selectEndDate({required DateTime endaDate}) = SelectEndDate;

  const factory EmployerLongTermPositionAddDetailEvent.selectApplicationDeadline({required DateTime deadLine}) = SelectApplicationDeadline;

  const factory EmployerLongTermPositionAddDetailEvent.selectEstimatedHour({required TimeOfDay estimatedHour}) = SelectEstimatedHour;

  const factory EmployerLongTermPositionAddDetailEvent.onShiftScheduleChanged({required CommonDropdownModel value}) =
      OnShiftScheduleChanged;

  const factory EmployerLongTermPositionAddDetailEvent.selectDocument({required String path}) = SelectDocument;

  const factory EmployerLongTermPositionAddDetailEvent.addMoreVacancy(int value) = AddMoreVacancy;

  const factory EmployerLongTermPositionAddDetailEvent.onCreate(PostShiftDTO postShitDto,EmployerLongTermSuccessDto? employer) = OnCreate;

  const factory EmployerLongTermPositionAddDetailEvent.removeDocument() = RemoveDocument;
  const factory EmployerLongTermPositionAddDetailEvent.onChangeContractIncludeCall(int value) = OnChangeContractIncludeCall;
  const factory EmployerLongTermPositionAddDetailEvent.removeShiftSchedule(String selectedValue) = RemoveShiftSchedule;
  const factory EmployerLongTermPositionAddDetailEvent.confirmShiftSchedule(List<String> skillList) = ConfirmSoftwareSkill;

  const factory EmployerLongTermPositionAddDetailEvent.onContinue({
    required BuildContext context,
    required String jobDescription,
    required String requirements,
    required String responsibilities,
    required String qualification,
    required String licences,
    required String onboarding,
    String? terms,
    String? numberOfVacancy,
  }) = OnContinue;
}
