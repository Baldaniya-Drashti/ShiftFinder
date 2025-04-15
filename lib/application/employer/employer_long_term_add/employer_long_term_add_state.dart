part of 'employer_long_term_add_bloc.dart';

@freezed
class EmployerLongTermAddState with _$EmployerLongTermAddState {
  const factory EmployerLongTermAddState({
    required EmployerLongTermSuccessDto updatePost,

    /// SPECIALITY

    required List<SpecialityDTO> specialityList,
    required List<String> specialityOther,
    required String requiredSpecialityChip,
    required ListInputEmptyOrNot requiredSpecialityChipList,

    /// ROLE TYPE
    required List<SkillDTO> roleList,
    required InputEmptyOrNot roleType,

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

    /// LOCATION
    required List<LocationDTO> locationList,
    required List<UnitDTO> unitList,
    required InputEmptyOrNot location,
    required LocationDTO locationObj,
    required String selectedLocationUnit,

    /// RATE/ HOUR
    required Rate rateHour,

    /// SUBMIT
    required bool isSubmitting,
    required bool isLoading,
    required bool showErrorMessages,
    required bool showLanguageError,
    required bool showSoftwareSkillError,
    required bool showSpecialityError,
    required bool showRoleTypeError,
    required bool showSpeExperienceError,
    required bool showLocationError,
    int? postId,
    required Option<Either<MainFailure, HealthcarePostDTO>>
        authFailureOrSuccessOption,
  }) = _EmployerLongTermAddState;

  factory EmployerLongTermAddState.initial() => EmployerLongTermAddState(
        updatePost: EmployerLongTermSuccessDto(),
        rateHour: Rate(""),
        location: InputEmptyOrNot(""),
        locationObj: LocationDTO(),
        locationList: [],
        unitList: [],
        selectedLocationUnit: "",
        requiredSpecialityChipList: ListInputEmptyOrNot([]),
        requiredSpecialityChip: "",
        languageChip: "",
        languageChipList: ListInputEmptyOrNot(["English"]),
        specialityList: [],
        softwareList: [],
        languageList: [],
        languageOther: [],
        roleList: [],
        softwareSkillOther: [],
        specialityOther: [],
        roleType: InputEmptyOrNot(""),
        requiredSoftwareSkillChipList: ListInputEmptyOrNot([]),
        requiredSoftwareSkillChip: "",
        isSubmitting: false,
        isLoading: false,
        showErrorMessages: false,
        showRoleTypeError: false,
        showSpecialityError: false,
        showSoftwareSkillError: false,
        showLanguageError: false,
        showLocationError: false,
        showSpeExperienceError: false,
        authFailureOrSuccessOption: none(),
      );
}
