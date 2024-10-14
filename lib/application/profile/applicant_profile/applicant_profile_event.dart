part of 'applicant_profile_bloc.dart';

@freezed
class ApplicantProfileEvent with _$ApplicantProfileEvent {
  const factory ApplicantProfileEvent.fetchApplicantProfile() = _FetchApplicantProfile;
}
