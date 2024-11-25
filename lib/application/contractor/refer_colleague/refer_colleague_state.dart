part of 'refer_colleague_bloc.dart';

@freezed
class ReferColleagueState with _$ReferColleagueState {
  const factory ReferColleagueState({
    @Default(false) bool loading,
    @Default(false) bool error,
    @Default(false) bool noDataFound,
    @Default([]) List<dynamic> referredColleagueList,
  }) = _ReferColleagueState;
}
