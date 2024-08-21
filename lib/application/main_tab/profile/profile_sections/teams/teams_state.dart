part of 'teams_bloc.dart';

@freezed
class TeamsState with _$TeamsState {
  factory TeamsState({
    required InputEmptyOrNot locationTextField,
    required InputEmptyOrNot teamNameTextField,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, String>> failureOrSuccessOption,
  }) = _TeamsState;
  factory TeamsState.initial() => TeamsState(
        locationTextField: InputEmptyOrNot(''),
        teamNameTextField: InputEmptyOrNot(''),
        showErrorMessages: false,
        isSubmitting: false,
        failureOrSuccessOption: none(),
      );
}
