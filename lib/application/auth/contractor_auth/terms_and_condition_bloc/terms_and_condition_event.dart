part of 'terms_and_condition_bloc.dart';

@freezed
class TermsAndConditionEvent with _$TermsAndConditionEvent {
  const factory TermsAndConditionEvent.submitTerms() = SubmitTerms;
}
