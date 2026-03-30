part of 'splash_bloc.dart';

@freezed
class SplashEvent with _$SplashEvent {
  const factory SplashEvent.started() = _Started;

  factory SplashEvent.registerForPush(String fcmToken) = RegisterForPush;

  factory SplashEvent.pushNotificationInitialize(BuildContext context) =
      PushNotificationInitialize;
  factory SplashEvent.initDynamicLink(BuildContext context) = InitDynamicLink;
}
