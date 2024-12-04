// import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shift/domain/core/environment/environment.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/core/app_router.dart';
import 'package:shift/presentation/core/app_widget.dart';
import 'package:shift/presentation/core/restart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/setup_hive.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );
      await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );
      getIt.registerSingleton<AppRouter>(AppRouter());
      await Firebase.initializeApp(
        options: Platform.isIOS
            ? null
            : const FirebaseOptions(
                apiKey: 'AIzaSyATJRoEmXnOO3MTBkxI96a33UGpUNY06gE',
                appId: '1:742221353179:android:f63ec600a9b2085984fcfe',
                messagingSenderId: '742221353179',
                projectId: 'shiftfinder-199a2',
              ),
      ).catchError((e) {
        print(e);
        return e;
      }).then((v) async {
        await _initializeCrashlytics();

        await dotenv.load(fileName: '.env');
        configureInjection(Environment.dev);
        String environment = const String.fromEnvironment(
          'ENVIRONMENT',
          defaultValue: Environment.dev,
        );
        EnvironmentCongig().initConfig(environment);
        await setupHive();

        Stripe.publishableKey = dotenv.get("STRIPE_TEST_PUBLISH_KEY");
        print("Stripe publish key after---> ${Stripe.publishableKey}");
        runApp(const RestartWidget(child: AppWidget()));
      });
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}

Future<void> _initializeCrashlytics() async {
  if (!kIsWeb) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
}
