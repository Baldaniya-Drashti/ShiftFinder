part of 'refer_colleague_bloc.dart';

@freezed
class ReferColleagueState with _$ReferColleagueState {
  factory ReferColleagueState({
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
    required List<ReferColleagueDTO> collegueList,
    required Account account,
  }) = _ReferColleagueState;
  factory ReferColleagueState.initial() => ReferColleagueState(
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
        collegueList: [],
        account: Account(),
      );
}
