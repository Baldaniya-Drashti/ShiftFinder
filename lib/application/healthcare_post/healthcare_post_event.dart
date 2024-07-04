part of 'healthcare_post_bloc.dart';

@freezed
class HealthcarePostEvent with _$HealthcarePostEvent {
  const factory HealthcarePostEvent.roleTypeChanged(String roleType) =
      RoleTypeChanged;

  const factory HealthcarePostEvent.selectedLanguageChanged(String language) =
      SelectedLanguageChanged;

  const factory HealthcarePostEvent.locationChanged(String location) =
      LocationChanged;
  const factory HealthcarePostEvent.locationUnitSelectionChanged(
      String selectedUnit) = LocationUnitSelectionChanged;
  const factory HealthcarePostEvent.rateHourChanged(String rateHour) =
      RateHourChanged;

  const factory HealthcarePostEvent.addRequiredSpecialitichips(
      String selectedValue,
      {bool? isOtherValue}) = AddRequiredSpecialitichips;
  const factory HealthcarePostEvent.removeRequiredSpecialitichips(
      String selectedValue) = RemoveRequiredSpecialitichips;
  const factory HealthcarePostEvent.addPreferedSoftwareSkillchips(
      String selectedValue,
      {bool? isOtherValue}) = AddPreferedSoftwareSkillchips;
  const factory HealthcarePostEvent.removePreferedSoftwareSkillchips(
      String selectedValue) = RemovePreferedSoftwareSkillchips;
  const factory HealthcarePostEvent.continueBtnPressed() = ContinueBtnPressed;
}
