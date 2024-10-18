part of 'employer_availability_bloc.dart';

@freezed
class EmployerAvailabilityEvent with _$EmployerAvailabilityEvent {
  const factory EmployerAvailabilityEvent.started() = _Started;
}
