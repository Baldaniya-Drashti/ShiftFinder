part of 'legal_screening_bloc.dart';

@freezed
class LegalScreeningState with _$LegalScreeningState {
  const factory LegalScreeningState({
    required List<QuestionModel> questionList,
    required bool isCheck,
    required bool showErrorMessages,
    required bool isAllAnswered,
    required bool isSubmitting,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _LegalScreeningState;
  factory LegalScreeningState.initial() => LegalScreeningState(
        questionList: [],
        showErrorMessages: false,
        isAllAnswered: false,
        isSubmitting: false,
        isCheck: false,
        authFailureOrSuccessOption: none(),
      );
}
