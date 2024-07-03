// ignore_for_file: prefer_const_constructors

import 'package:shift/application/splash/splash_bloc.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/core/app_router.dart';
import 'package:shift/presentation/core/app_theme.dart';
import 'package:shift/presentation/core/widgets/utility/life_cycle_watcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return bloc.MultiBlocProvider(
      providers: [
        // bloc.BlocProvider(
        //   create: (context) => getIt<AuthStatusBloc>()
        //     ..add(
        //       const AuthStatusEvent.authCheckRequested(),
        //     ),
        // ),
        bloc.BlocProvider(
          create: (context) => getIt<SplashBloc>()..add(SplashEvent.started()),
        ),
      ],
      child: _App(),
    );
  }
}

class _App extends StatefulWidget {
  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  final appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return LifecycleWatcher(
      child: ScreenUtilInit(
        ensureScreenSize: true,
        child: MaterialApp.router(
          title: 'Complete Feng Shui',
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.lightTheme,
          routerConfig: appRouter.config(),
          // locale: state1.locale,
          // supportedLocales: AppLocalizations.supportedLocales,
          // localizationsDelegates: [
          //   CountryLocalizations.delegate,
          //   ...AppLocalizations.localizationsDelegates,
          // ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (final supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }

            return supportedLocales.first;
          },
        ),
      ),
    );
  }
}
