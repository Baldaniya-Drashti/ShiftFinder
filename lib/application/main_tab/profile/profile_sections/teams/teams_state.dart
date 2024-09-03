part of 'teams_bloc.dart';

@freezed
class TeamsState with _$TeamsState {
  factory TeamsState({
    required InputEmptyOrNot teamNameTextField,
    required bool showErrorMessages,
    required bool isSubmitting,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required String teamIDForUpdate,
    required Option<Either<MainFailure, String>> failureOrSuccessOption,
    required SingleValueDropDownController singleValueDropDownController,
    required List<GetTeamsListDTO> getTeamList,
    required bool isEdit,
    required List<DropDownValueModel> locationList,
  }) = _TeamsState;
  factory TeamsState.initial() => TeamsState(
        teamNameTextField: InputEmptyOrNot(''),
        showErrorMessages: false,
        isSubmitting: false,
        failureOrSuccessOption: none(),
        getTeamList: [],
        isLoading: false,
        isNoDataFound: false,
        isErrorInAPI: false,
        locationList: [],
        isEdit: false,
        singleValueDropDownController: SingleValueDropDownController(),
        teamIDForUpdate: '',
      );
}
