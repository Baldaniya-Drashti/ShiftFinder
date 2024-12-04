// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';

late final IAuthFacade authFacade;
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  onTapNotification(
    RemoteMessage(data: jsonDecode(notificationResponse.payload ?? "")),
  );
  // handle action
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    onTapNotification(message);
    // DependencyInjection.readNotification('notificationId');
  }

  print('Handling a background message ${message.messageId}');
}

class PushNotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // final StreamController<String> _fcmTokenController =
  //     StreamController<String>();
  // Stream<String> get fcmTokenStream => _fcmTokenController.stream;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool notificationsEnabled = false;
// It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage(BuildContext context) async {
    await firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      log('getInitialMessage : ${message?.data}');
      if (message != null) {
        onTapNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log('onMessageOpenedApp : ${message.data}');
      onTapNotification(message);
    });
    _isAndroidPermissionGranted();
    _requestPermissions();

    await registerNotificationListeners(context);
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
      print("Android notification permission granted!!! $granted");
      notificationsEnabled = granted;
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted =
          await androidImplementation?.requestNotificationsPermission();
      print(
          "After request Android notification permission granted!!!---> $granted");

      notificationsEnabled = granted ?? false;
    }
  }

  Future<void> registerNotificationListeners(BuildContext context) async {
    final AndroidNotificationChannel channel = androidNotificationChannel();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@drawable/ic_notification');
    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        switch (details.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            log('NotificationResponseType.selectedNotification : ${jsonDecode(details.payload ?? "")}');
            // RemoteMessage(data: jsonDecode(details.payload ?? ""));
            onTapNotification(
              RemoteMessage(data: jsonDecode(details.payload ?? "")),
            );

            break;

          case NotificationResponseType.selectedNotificationAction:
            log('NotificationResponseType.selectedNotificationAction : ${details.payload}');
            onTapNotification(
              RemoteMessage(data: jsonDecode(details.payload ?? "")),
            );

            break;
          default:
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );
// onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      log('onMessage : ${message?.data}');
      // homeController.getHomeData(
      //   withLoading: false,
      // );

      final RemoteNotification? notification = message!.notification;
      final AndroidNotification? android = message.notification?.android;
// If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });
  }

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );
}

onTapNotification(RemoteMessage message) async {
  log('onTapNotification : ${message.data}');
  if (message.data['type'] == '2') {
// context.read<MainTabBloc>().add(MainTabEvent.tabChange(3));
    /* await getIt<AppRouter>().push(
      PageRouteInfo(
        ChatView.name,
        args: ChatViewArgs(
          recieverID: message.data['data_id'],
        ),
      ),
    ); */
    // if (res != null && res == true) {
    //   context
    //       .read<NotificationsBloc>()
    //       .add(NotificationsEvent.getMessageList(true));
    // }
  }
}
