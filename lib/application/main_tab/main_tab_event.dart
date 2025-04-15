part of 'main_tab_bloc.dart';

@freezed
class MainTabEvent with _$MainTabEvent {
  factory MainTabEvent.tabChange(int tabIndex) = TabChange;
  const factory MainTabEvent.checkTeamAvailableEvent(BuildContext context,
      {int? index}) = CheckTeamAvailableEvent;

  const factory MainTabEvent.dontShowAgain(BuildContext context,
      {@Default(false) bool isCheck}) = DontShowAgain;

  factory MainTabEvent.registerForPush() = RegisterForPush;
}
