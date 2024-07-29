part of 'education_detail_bloc.dart';

@freezed
class EducationDetailEvent with _$EducationDetailEvent {
  const factory EducationDetailEvent.getEducationList() = GetEducationList;
  const factory EducationDetailEvent.deleteEducation(int educationId) =
      DeleteEducation;

  const factory EducationDetailEvent.skipEducation() = SkipEducation;
  const factory EducationDetailEvent.addProgramChanged(String program) =
      AddProgramChanged;
  const factory EducationDetailEvent.addCompletionYearChanged(String year) =
      AddCompletionYearChanged;
  const factory EducationDetailEvent.addInstituteChanged(String institute) =
      AddInstituteChanged;
  const factory EducationDetailEvent.onAddBtnPressed() = OnAddBtnPressed;
}
