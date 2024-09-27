import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/auth_status/auth_status_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/profile/widgets/main_profile_view.dart';
import 'package:shift/presentation/main/tabs/profile/widgets/profile_items.dart';

@RoutePage(name: 'ProfileView')
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStatusBloc, AuthStatusState>(
      listener: (BuildContext context, AuthStatusState state) {
        state.map(
          initial: (value) {},
          authenticated: (value) {},
          unauthenticated: (value) =>
              context.router.replaceAll([const PageRouteInfo(LoginPage.name)]),
        );
      },
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: getSize(20)),
          MainProfileView(),
          SizedBox(height: getSize(10)),
          ProfileItems(),
          SizedBox(height: getSize(20)),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Developed by -',
              style: TextStyle(
                color: Colors.black,
                fontSize: getFontSize(14),
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: ' iRoid Solutions',
                  style: TextStyle(color: AppColors.green),
                ),
              ],
            ),
          ),
          SizedBox(height: getSize(50)),
        ],
      ),
    );
  }
}
