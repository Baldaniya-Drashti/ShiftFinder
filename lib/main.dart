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
  await dotenv.load(fileName: '.env');
  configureInjection(Environment.dev);
  String environment = const String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.dev,
  );
  EnvironmentCongig().initConfig(environment);
  await setupHive();

  runApp(const RestartWidget(child: AppWidget()));
}
