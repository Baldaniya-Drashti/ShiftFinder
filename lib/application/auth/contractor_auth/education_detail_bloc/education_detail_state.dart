part of 'education_detail_bloc.dart';

@freezed
class EducationDetailState with _$EducationDetailState {
  const factory EducationDetailState({
    /// Add Education
    required InputEmptyOrNot selectedProgram,
    required InputEmptyOrNot yearOfCompletion,
    required InputEmptyOrNot selectedGraduation,

    /// SUBMIT
    required bool isSubmitting,
    required bool showAddEducationErrorMessages,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _EducationDetailState;
  factory EducationDetailState.initial() => EducationDetailState(
        selectedGraduation: InputEmptyOrNot(""),
        selectedProgram: InputEmptyOrNot(""),
        yearOfCompletion: InputEmptyOrNot(""),
        isSubmitting: false,
        showAddEducationErrorMessages: false,
        authFailureOrSuccessOption: none(),
      );
}
