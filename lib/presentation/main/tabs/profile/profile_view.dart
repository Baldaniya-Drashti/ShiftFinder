import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/auth_status/auth_status_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/profile/widgets/main_profile_view.dart';
import 'package:shift/presentation/main/tabs/profile/widgets/profile_items.dart';
import 'package:url_launcher/url_launcher.dart';

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
          unauthenticated: (value) {
            print("Logout called!");
            context.router.replaceAll([const PageRouteInfo(LoginPage.name)]);
          },
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
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse('https://iroidsolutions.com/');
              try {
                bool launched =
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                if (!launched) {
                  print("Could not launch the URL");
                }
              } catch (e) {
                print("Catch error: $e");
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: '${StringConstant.developedBy} - ',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                BaseText(
                  text: StringConstant.iRoidSolutions,
                  textColor: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
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
