// ignore_for_file: prefer_const_constructors

import 'package:shift/application/auth/auth_status/auth_status_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_main_bloc.dart';
import 'package:shift/application/main_tab/main_tab_bloc.dart';
import 'package:shift/application/splash/splash_bloc.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/core/app_router.dart';
import 'package:shift/presentation/core/app_theme.dart';
import 'package:shift/presentation/core/widgets/utility/life_cycle_watcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shift/application/profile/account/account_cubit.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthStatusBloc>()
            ..add(const AuthStatusEvent.authCheckRequested()),
        ),
        BlocProvider(
          create: (context) => getIt<ContractorMainTabBloc>()
            ..add(ContractorMainTabEvent.tabChange(0)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<MainTabBloc>()..add(MainTabEvent.tabChange(0)),
        ),
        BlocProvider(
          create: (context) => getIt<SplashBloc>()
            ..add(SplashEvent.initDynamicLink(context))
            ..add(SplashEvent.started()),
        ),
        BlocProvider(
          create: (context) => getIt<AccountCubit>(),
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
          title: StringConstant.shiftFinder,
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.lightTheme,
          routerConfig: appRouter.config(),
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
