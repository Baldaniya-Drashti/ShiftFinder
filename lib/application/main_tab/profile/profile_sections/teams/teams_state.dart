part of 'teams_bloc.dart';

@freezed
class TeamsState with _$TeamsState {
  factory TeamsState({
    required InputEmptyOrNot locationTextField,
    required InputEmptyOrNot teamNameTextField,
    required bool showErrorMessages,
    required bool isSubmitting,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required Option<Either<AuthFailure, String>> failureOrSuccessOption,
    required List<GetTeamsListDTO> getTeamList,
  }) = _TeamsState;
  factory TeamsState.initial() => TeamsState(
        locationTextField: InputEmptyOrNot(''),
        teamNameTextField: InputEmptyOrNot(''),
        showErrorMessages: false,
        isSubmitting: false,
        failureOrSuccessOption: none(),
        getTeamList: [],
        isLoading: false,
        isNoDataFound: false,
        isErrorInAPI: false,
      );
}
