part of 'legal_screening_bloc.dart';

@freezed
class LegalScreeningState with _$LegalScreeningState {
  const factory LegalScreeningState({
    required List<LegalScreeningDTO> questionList,
    required bool isCheck,
    required bool showErrorMessages,
    required bool isAllAnswered,
    required bool isSubmitting,
    required Option<Either<AccountFailure, List<LegalScreeningDTO>>>
        authFailureOrSuccessOption,
    required Option<Either<AccountFailure, Account>>
        submitFailureOrSuccessOption,
  }) = _LegalScreeningState;
  factory LegalScreeningState.initial() => LegalScreeningState(
        questionList: [],
        showErrorMessages: false,
        isAllAnswered: false,
        isSubmitting: false,
        isCheck: false,
        authFailureOrSuccessOption: none(),
        submitFailureOrSuccessOption: none(),
      );
}
