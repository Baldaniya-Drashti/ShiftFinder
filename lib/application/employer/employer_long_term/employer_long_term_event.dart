part of 'employer_long_term_bloc.dart';

@freezed
class EmployerLongTermEvent with _$EmployerLongTermEvent {
  const factory EmployerLongTermEvent.changeTab(
      BuildContext context, int tabIndex) = ChangeTab;

  const factory EmployerLongTermEvent.getEmployerLongTermOpenPosition({
    required BuildContext context,
    required bool refresh,
  }) = _GetEmployerLongTermOpenPosition;

  const factory EmployerLongTermEvent.getEmployerFilledPosition({
    required BuildContext context,
    required bool refresh,
  }) = _getEmployerFilledPosition;

  const factory EmployerLongTermEvent.deletePost({
    required BuildContext context,
    required int id,
  }) = _DeletePost;
}
