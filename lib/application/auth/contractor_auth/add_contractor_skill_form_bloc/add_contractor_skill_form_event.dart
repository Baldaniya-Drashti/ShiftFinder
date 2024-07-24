part of 'add_contractor_skill_form_bloc.dart';

@freezed
class AddContractorSkillFormEvent with _$AddContractorSkillFormEvent {
  const factory AddContractorSkillFormEvent.getAllDropDownList() =
      GetAllDropDownList;

  const factory AddContractorSkillFormEvent.addRoleTypeChips(String roleType,
      {bool? isOtherValue}) = AddRoleTypeChips;
  const factory AddContractorSkillFormEvent.removeRoleTypeChips(
      String roleType) = RemoveRoleTypeChips;

  // const factory AddContractorSkillFormEvent.selectedLanguageChanged(
  //     String language) = SelectedLanguageChanged;

  const factory AddContractorSkillFormEvent.addLanguageChips(
      String selectedLanguage,
      {bool? isOtherValue}) = AddLanguageChips;
  const factory AddContractorSkillFormEvent.removeLanguageChips(
      String selectedLanguage) = RemoveLanguageChips;

  const factory AddContractorSkillFormEvent.addRequiredSpecialitichips(
      String selectedValue,
      {bool? isOtherValue}) = AddRequiredSpecialitichips;

  const factory AddContractorSkillFormEvent.addSpecialityExperienceList(
          String selectedValue, int currentIndex, {bool? isOtherValue}) =
      AddSpecialityExperienceList;
  const factory AddContractorSkillFormEvent.removeRequiredSpecialitichips(
      int currentIndex) = RemoveRequiredSpecialitichips;
  const factory AddContractorSkillFormEvent.addPreferedSoftwareSkillchips(
      String selectedValue,
      {bool? isOtherValue}) = AddPreferedSoftwareSkillchips;
  const factory AddContractorSkillFormEvent.removePreferedSoftwareSkillchips(
      String selectedValue) = RemovePreferedSoftwareSkillchips;
  const factory AddContractorSkillFormEvent.continueBtnPressed() =
      ContinueBtnPressed;
}
