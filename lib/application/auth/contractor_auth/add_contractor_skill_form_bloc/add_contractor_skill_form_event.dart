part of 'add_contractor_skill_form_bloc.dart';

@freezed
class AddContractorSkillFormEvent with _$AddContractorSkillFormEvent {
  const factory AddContractorSkillFormEvent.getProfileDetail() =
      GetProfileDetail;

  const factory AddContractorSkillFormEvent.getAllDropDownList(
      {bool? isUpdate}) = GetAllDropDownList;

  const factory AddContractorSkillFormEvent.addRoleTypeChips(
          String roleType, List<String> roleList, {bool? isOtherValue}) =
      AddRoleTypeChips;

  const factory AddContractorSkillFormEvent.removeRoleTypeChips(
      String roleType) = RemoveRoleTypeChips;

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
      String selectedValue) = RemoveRequiredSpecialitichips;
  const factory AddContractorSkillFormEvent.addPreferedSoftwareSkillchips(
      String selectedValue,
      {bool? isOtherValue}) = AddPreferedSoftwareSkillchips;
  const factory AddContractorSkillFormEvent.removePreferedSoftwareSkillchips(
      String selectedValue) = RemovePreferedSoftwareSkillchips;
  const factory AddContractorSkillFormEvent.continueBtnPressed() =
      ContinueBtnPressed;

  const factory AddContractorSkillFormEvent.confirmRoleList(
      List<String> roleList, List<String> otherRoleList) = ConfirmRoleList;
  const factory AddContractorSkillFormEvent.confirmSoftwareSkill(
          List<String> skillList, List<String> otherSkillList) =
      ConfirmSoftwareSkill;
  const factory AddContractorSkillFormEvent.confirmSpecialityList(
          List<String> specialityList, List<String> otherSpecialityList) =
      ConfirmSpecialityList;
  const factory AddContractorSkillFormEvent.confirmLanguageList(
          List<String> languageList, List<String> otherLanguageList) =
      ConfirmLanguageList;
}
