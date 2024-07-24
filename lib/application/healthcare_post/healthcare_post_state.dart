part of 'healthcare_post_bloc.dart';

@freezed
class HealthcarePostState with _$HealthcarePostState {
  const factory HealthcarePostState({
    required InputEmptyOrNot location,
    required InputEmptyOrNot rateHour,
    required InputEmptyOrNot roleType,
    required InputEmptyOrNot selectedLanguage,
    required String requiredSpecialityChip,
    required String selectedLocationUnit,
    required List<String> requiredSpecialityChipList,

    ///
    required String requiredSoftwareSkillChip,
    required List<String> requiredSoftwareSkillChipList,

    ///
    required bool isSubmitting,
    required bool showErrorMessages,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _HealthcarePostState;
  factory HealthcarePostState.initial() => HealthcarePostState(
        location: InputEmptyOrNot(""),
        rateHour: InputEmptyOrNot(""),
        roleType: InputEmptyOrNot(""),
        selectedLanguage: InputEmptyOrNot(""),
        requiredSpecialityChipList: [],
        requiredSpecialityChip: "",
        requiredSoftwareSkillChipList: [],
        requiredSoftwareSkillChip: "",
        selectedLocationUnit: "",
        isSubmitting: false,
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),
      );
}
