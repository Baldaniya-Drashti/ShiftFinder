part of 'speciality_experience_bloc.dart';

@freezed
class SpecialityExperienceState with _$SpecialityExperienceState {
  const factory SpecialityExperienceState({
    required List<ExperienceDTO> records,

    /// SUBMIT
    required bool isSubmitting,
    required bool isLoading,
    required bool showErrorMessages,
    required bool showYearError,
    required bool showMonthError,
    required Option<Either<AccountFailure, Account>> authFailureOrSuccessOption,
  }) = _SpecialityExperienceState;

  factory SpecialityExperienceState.initial() => SpecialityExperienceState(
        records: [],
        isSubmitting: false,
        isLoading: false,
        showErrorMessages: false,
        showMonthError: false,
        showYearError: false,
        authFailureOrSuccessOption: none(),
      );
}
