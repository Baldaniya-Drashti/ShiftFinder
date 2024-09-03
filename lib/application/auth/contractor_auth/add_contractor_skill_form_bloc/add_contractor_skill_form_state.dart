// ignore_for_file: prefer_const_literals_to_create_immutables

part of 'add_contractor_skill_form_bloc.dart';

@freezed
class AddContractorSkillFormState with _$AddContractorSkillFormState {
  const factory AddContractorSkillFormState({
    /// SPECIALITY
    required ListInputEmptyOrNot requiredSpecialityChipList,
    required String requiredSpecialityChip,

    /// SPECIALITY
    // required ListInputEmptyOrNot<SpecialityDTO> requiredSpecialityChipList,
    required List<SpecialityDTO> specialityList,
    // required String requiredSpecialityChip,
    required List<String> specialityOther,

    /// Add EXPERIENCE OF SELECTED SPECIALITY
    required ListInputEmptyOrNot selectedSpecialityExperienceList,
    required String selectedSpecialityExperience,
    required List<SkillDTO> experienceList,

    /// ROLE TYPE
    required List<SkillDTO> roleList,
    required ListInputEmptyOrNot roleTypeChipList,
    required String roleTypeChip,

    /// SOFTWARE SKILL
    required List<SkillDTO> softwareList,
    required List<String> softwareSkillOther,
    required String requiredSoftwareSkillChip,
    required ListInputEmptyOrNot requiredSoftwareSkillChipList,

    /// LANGUAGE
    required String languageChip,
    required List<String> languageOther,
    required ListInputEmptyOrNot languageChipList,
    required List<SkillDTO> languageList,

    /// SUBMIT
    required bool isSubmitting,
    required bool isLoading,
    required bool showErrorMessages,
    required bool showLanguageError,
    required bool showSoftwareSkillError,
    required bool showSpecialityError,
    required bool showRoleTypeError,
    required bool showSpeExperienceError,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _AddContractorSkillFormState;
  factory AddContractorSkillFormState.initial() => AddContractorSkillFormState(
        requiredSpecialityChipList: ListInputEmptyOrNot([]),
        requiredSpecialityChip: "",
        selectedSpecialityExperienceList: ListInputEmptyOrNot([]),
        selectedSpecialityExperience: "",
        languageChip: "",
        languageChipList: ListInputEmptyOrNot(["English"]),
        roleList: [],
        specialityList: [],
        experienceList: [],
        softwareList: [],
        languageList: [],
        languageOther: [],
        softwareSkillOther: [],
        specialityOther: [],
        roleTypeChip: "",
        roleTypeChipList: ListInputEmptyOrNot([]),
        requiredSoftwareSkillChipList: ListInputEmptyOrNot([]),
        requiredSoftwareSkillChip: "",
        isSubmitting: false,
        isLoading: false,
        showErrorMessages: false,
        showRoleTypeError: false,
        showSpecialityError: false,
        showSoftwareSkillError: false,
        showLanguageError: false,
        showSpeExperienceError: false,
        authFailureOrSuccessOption: none(),
      );
}
