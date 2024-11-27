part of 'employer_about_bloc.dart';

@freezed
class EmployerAboutState with _$EmployerAboutState {
  const factory EmployerAboutState({
    required List<bool> expandedStates,
  }) = _EmployerAboutState;

  factory EmployerAboutState.initial() => EmployerAboutState(
        expandedStates: [],
      );
}
