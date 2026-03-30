part of 'onboarding_bloc.dart';

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.submitOnboarding1(int selectedUser) =
      SubmitOnboarding1;
  const factory OnboardingEvent.submitOnboarding2(
      int selectedIndustry, BuildContext context) = SubmitOnboarding2;
  const factory OnboardingEvent.submitOnboarding3() = SubmitOnboarding3;
}
