part of 'refer_colleague_bloc.dart';

@freezed
class ReferColleagueState with _$ReferColleagueState {
  factory ReferColleagueState({
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
    required List<ReferColleagueDTO> collegueList,
    required ApplicantDto account,
    required bool showErrorMessages,
  }) = _ReferColleagueState;
  factory ReferColleagueState.initial() => ReferColleagueState(
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
        collegueList: [],
        account: ApplicantDto(),
        showErrorMessages: false,
      );
}
