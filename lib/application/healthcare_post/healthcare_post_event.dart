part of 'healthcare_post_bloc.dart';

@freezed
class HealthcarePostEvent with _$HealthcarePostEvent {
  const factory HealthcarePostEvent.getAllDropDownList(int postId) =
      GetAllDropDownList;

  const factory HealthcarePostEvent.roleTypeChanged(String roleType) =
      RoleTypeChanged;

  const factory HealthcarePostEvent.addLanguageChips(String selectedLanguage,
      {bool? isOtherValue}) = AddLanguageChips;

  const factory HealthcarePostEvent.removeLanguageChips(
      String selectedLanguage) = RemoveLanguageChips;

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

  const factory HealthcarePostEvent.locationChanged(String selectedValue) =
      LocationChanged;

  const factory HealthcarePostEvent.locationUnitSelectionChanged(
      String selectedUnit) = LocationUnitSelectionChanged;

  const factory HealthcarePostEvent.rateHourChanged(String rateHour) =
      RateHourChanged;

  const factory HealthcarePostEvent.continueBtnPressed(
      BuildContext context, bool fromSaveTemplate,
      {required bool fromReview, required bool isCreate}) = ContinueBtnPressed;

  const factory HealthcarePostEvent.confirmSoftwareSkill(
          List<String> skillList, List<String> otherSkillList) =
      ConfirmSoftwareSkill;

  const factory HealthcarePostEvent.confirmSpecialityList(
          List<String> specialityList, List<String> otherSpecialityList) =
      ConfirmSpecialityList;

  const factory HealthcarePostEvent.confirmLanguageList(
          List<String> languageList, List<String> otherLanguageList) =
      ConfirmLanguageList;
}
