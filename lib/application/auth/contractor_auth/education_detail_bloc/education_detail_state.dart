part of 'education_detail_bloc.dart';

@freezed
class EducationDetailState with _$EducationDetailState {
  const factory EducationDetailState({
    /// Add Education
    required InputEmptyOrNot selectedProgram,
    required InputEmptyOrNot yearOfCompletion,
    required InputEmptyOrNot selectedGraduation,
    required List<EducationDTO> educationList,

    /// SUBMIT
    required bool isSubmitting,
    required bool showAddEducationErrorMessages,
    required bool showErrorMessages,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
    required Option<Either<AccountFailure, String>> failureOrSuccessOption,
    required Option<Either<AccountFailure, Account>> listFailureOrSuccessOption,
  }) = _EducationDetailState;
  factory EducationDetailState.initial() => EducationDetailState(
        selectedGraduation: InputEmptyOrNot(""),
        selectedProgram: InputEmptyOrNot(""),
        yearOfCompletion: InputEmptyOrNot(""),
        educationList: [],
        isSubmitting: false,
        showAddEducationErrorMessages: false,
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),
        failureOrSuccessOption: none(),
        listFailureOrSuccessOption: none(),
      );
}
