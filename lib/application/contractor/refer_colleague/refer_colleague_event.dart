part of 'refer_colleague_bloc.dart';

@freezed
class ReferColleagueEvent with _$ReferColleagueEvent {
  factory ReferColleagueEvent.getReferredColleagueData({
    required bool isRefresh,
  }) = GetCompletedList;
  const factory ReferColleagueEvent.getCollegueProfile({
    required int id,
    required BuildContext context,
  }) = _FetchApplicantProfile;
}
