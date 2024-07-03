import 'package:auto_route/auto_route.dart';
import 'package:shift/application/auth/login_form/login_form_bloc.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/auth/login/login_form.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'loginPage')
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.scaffoldColor,
      body: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: BlocProvider(
          create: (context) => getIt<LoginFormBloc>(),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
