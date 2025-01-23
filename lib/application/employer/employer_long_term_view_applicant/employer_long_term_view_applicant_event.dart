part of 'employer_long_term_view_applicant_bloc.dart';

@freezed
class EmployerLongTermViewApplicantEvent with _$EmployerLongTermViewApplicantEvent {
  const factory EmployerLongTermViewApplicantEvent.getApplicants({
    required BuildContext context,
    required int id,
    required bool refresh,
  }) = _GetApplicants;
  const factory EmployerLongTermViewApplicantEvent.onRejectApplicant({
    required BuildContext context,
    required int id,
  }) = _OnRejectApplicant;

}
