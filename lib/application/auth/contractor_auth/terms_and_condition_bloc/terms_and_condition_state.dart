part of 'terms_and_condition_bloc.dart';

@freezed
class TermsAndConditionState with _$TermsAndConditionState {
  const factory TermsAndConditionState({
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, Account>> authFailureOrSuccessOption,
  }) = _TermsAndConditionState;
  factory TermsAndConditionState.initial() => TermsAndConditionState(
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );
}
