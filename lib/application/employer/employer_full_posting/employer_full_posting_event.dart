part of 'employer_full_posting_bloc.dart';

@freezed
class EmployerFullPostingEvent with _$EmployerFullPostingEvent {
  const factory EmployerFullPostingEvent.getEmployerFullPosition({
    required BuildContext context,
    required bool refresh,
  }) = _EmployerFullPostingEvent;

  const factory EmployerFullPostingEvent.deletePost({
    required BuildContext context,
    required int id,
  }) = _DeletePost;
}
