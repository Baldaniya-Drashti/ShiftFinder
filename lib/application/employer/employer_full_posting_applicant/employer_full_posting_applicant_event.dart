part of 'employer_full_posting_applicant_bloc.dart';

@freezed
class EmployerFullPostingApplicantEvent with _$EmployerFullPostingApplicantEvent {
  const factory EmployerFullPostingApplicantEvent.getApplicants({
    required BuildContext context,
    required int id,
    required bool refresh,
  }) = _GetApplicants;
}
