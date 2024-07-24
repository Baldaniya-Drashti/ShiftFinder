part of 'onboarding_bloc.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    required int selectedUser,
    required int selectedIndustry,
    required bool showErrorMessages,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _OnboardingState;

  factory OnboardingState.initial() => OnboardingState(
        selectedUser: 1,
        selectedIndustry: 1,
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),
      );
}
