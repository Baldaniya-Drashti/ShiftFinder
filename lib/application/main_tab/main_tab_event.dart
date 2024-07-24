part of 'main_tab_bloc.dart';

@freezed
class MainTabEvent with _$MainTabEvent {
  factory MainTabEvent.tabChange(int tabIndex) = TabChange;
  // factory MainTabEvent.registerForPush(String fcmToken) = RegisterForPush;

  // factory MainTabEvent.pushNotificationInitialize(BuildContext context) =
  //     PushNotificationInitialize;
  // factory MainTabEvent.initDynamicLink(BuildContext context) = InitDynamicLink;
}
