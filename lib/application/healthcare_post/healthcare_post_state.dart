// ignore_for_file: prefer_const_literals_to_create_immutables

part of 'healthcare_post_bloc.dart';

// @freezed
// class HealthcarePostState with _$HealthcarePostState {
//   const factory HealthcarePostState({
//     required InputEmptyOrNot location,
//     required InputEmptyOrNot rateHour,
//     required InputEmptyOrNot roleType,
//     required InputEmptyOrNot selectedLanguage,
//     required String selectedLocationUnit,
//     // required List<String> requiredSpecialityChipList,
//     // required String requiredSpecialityChip,

//     /// SPECIALITY
//     required ListInputEmptyOrNot<SpecialityDTO> requiredSpecialityChipList,
//     required List<SpecialityDTO> specialityList,
//     required String requiredSpecialityChip,

//     ///
//     required String requiredSoftwareSkillChip,
//     required List<String> requiredSoftwareSkillChipList,

//     ///
//     required bool isSubmitting,
//     required bool showErrorMessages,
//     required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
//   }) = _HealthcarePostState;
//   factory HealthcarePostState.initial() => HealthcarePostState(
//         location: InputEmptyOrNot(""),
//         rateHour: InputEmptyOrNot(""),
//         roleType: InputEmptyOrNot(""),
//         selectedLanguage: InputEmptyOrNot(""),
//         requiredSpecialityChipList: ListInputEmptyOrNot([]),
//         requiredSpecialityChip: "",
//         requiredSoftwareSkillChipList: [],
//         requiredSoftwareSkillChip: "",
//         selectedLocationUnit: "",
//         isSubmitting: false,
//         showErrorMessages: false,
//         authFailureOrSuccessOption: none(),
//       );
// }

@freezed
class HealthcarePostState with _$HealthcarePostState {
  const factory HealthcarePostState({
    required HealthcarePostDTO updatePost,

    /// SPECIALITY
    // required ListInputEmptyOrNot requiredSpecialityChipList,
    // required String requiredSpecialityChip,

    /// SPECIALITY

    required List<SpecialityDTO> specialityList,
    required List<String> specialityOther,
    required String requiredSpecialityChip,
    required ListInputEmptyOrNot requiredSpecialityChipList,

    /// ROLE TYPE
    required List<SkillDTO> roleList,
    // required ListInputEmptyOrNot roleTypeChipList,
    // required String roleTypeChip,
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
    required Option<Either<MainFailure, HealthcarePostDTO>>
        authFailureOrSuccessOption,
  }) = _HealthcarePostState;
  factory HealthcarePostState.initial() => HealthcarePostState(
        updatePost: HealthcarePostDTO(),
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
