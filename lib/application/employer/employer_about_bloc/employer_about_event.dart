part of 'employer_about_bloc.dart';

@freezed
class EmployerAboutEvent with _$EmployerAboutEvent {
  const factory EmployerAboutEvent.toggleExpansionEvent(int index) =
      ToggleExpansionEvent;
}
