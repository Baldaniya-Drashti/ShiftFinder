part of 'experience_bloc.dart';

@freezed
class ExperienceState with _$ExperienceState {
  const factory ExperienceState({
    required List<ExperienceDTO> records,

    /// SUBMIT
    required bool isSubmitting,
    required bool isLoading,
    required bool showErrorMessages,
    required bool showYearError,
    required bool showMonthError,
    required Option<Either<AccountFailure, Account>> authFailureOrSuccessOption,
  }) = _ExperienceState;

  factory ExperienceState.initial() => ExperienceState(
        records: [],
        isSubmitting: false,
        isLoading: false,
        showErrorMessages: false,
        showMonthError: false,
        showYearError: false,
        authFailureOrSuccessOption: none(),
      );
}
