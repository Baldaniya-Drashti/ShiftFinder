part of 'onboarding_bloc.dart';

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.submitOnboarding1(int selectedUser) =
      SubmitOnboarding1;
}
