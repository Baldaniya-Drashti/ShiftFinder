part of 'employer_long_term_add_bloc.dart';

@freezed
class EmployerLongTermAddEvent with _$EmployerLongTermAddEvent {
  const factory EmployerLongTermAddEvent.getAllDropDownList(int postId) = GetAllDropDownList;

  const factory EmployerLongTermAddEvent.roleTypeChanged(String roleType) = RoleTypeChanged;

  const factory EmployerLongTermAddEvent.addLanguageChips(String selectedLanguage, {bool? isOtherValue}) = AddLanguageChips;

  const factory EmployerLongTermAddEvent.removeLanguageChips(String selectedLanguage) = RemoveLanguageChips;

  const factory EmployerLongTermAddEvent.addRequiredSpecialitichips(String selectedValue, {bool? isOtherValue}) = AddRequiredSpecialitichips;

  const factory EmployerLongTermAddEvent.removeRequiredSpecialitichips(String selectedValue) = RemoveRequiredSpecialitichips;

  const factory EmployerLongTermAddEvent.addPreferedSoftwareSkillchips(String selectedValue, {bool? isOtherValue}) =
  AddPreferedSoftwareSkillchips;

  const factory EmployerLongTermAddEvent.removePreferedSoftwareSkillchips(String selectedValue) = RemovePreferedSoftwareSkillchips;

  const factory EmployerLongTermAddEvent.locationChanged(String selectedValue) = LocationChanged;

  const factory EmployerLongTermAddEvent.locationUnitSelectionChanged(String selectedUnit) = LocationUnitSelectionChanged;

  const factory EmployerLongTermAddEvent.rateHourChanged(String rateHour) = RateHourChanged;

  const factory EmployerLongTermAddEvent.continueBtnPressed(BuildContext context, bool fromSaveTemplate) = ContinueBtnPressed;

  const factory EmployerLongTermAddEvent.confirmSoftwareSkill(List<String> skillList, List<String> otherSkillList) = ConfirmSoftwareSkill;

  const factory EmployerLongTermAddEvent.confirmSpecialityList(List<String> specialityList, List<String> otherSpecialityList) =
  ConfirmSpecialityList;

  const factory EmployerLongTermAddEvent.confirmLanguageList(List<String> languageList, List<String> otherLanguageList) = ConfirmLanguageList;
}
