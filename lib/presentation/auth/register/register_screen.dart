import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/register_form/register_form_bloc.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/auth/register/register_form.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';

@RoutePage(name: 'registerPage')
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            AppFocus.unfocus(context);
          },
          child: BlocProvider(
            create: (context) => getIt<RegisterFormBloc>(),
            child: const RegisterForm(),
          ),
        ),
      ),
    );
  }
}
