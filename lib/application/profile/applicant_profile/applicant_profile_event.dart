part of 'applicant_profile_bloc.dart';

@freezed
class ApplicantProfileEvent with _$ApplicantProfileEvent {
  const factory ApplicantProfileEvent.fetchApplicantProfile({
    required int id,
    required int postId,
     int? isLongOrFull,
    required BuildContext context,
  }) = _FetchApplicantProfile;
}
