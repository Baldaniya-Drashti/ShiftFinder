import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/auth_status/auth_status_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/profile/widgets/contractor_main_profile_view.dart';
import 'package:shift/presentation/main/tabs/profile/widgets/profile_items.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage(name: 'ContractorProfileView')
class ContractorProfileView extends StatelessWidget {
  const ContractorProfileView({super.key});

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
          ContractorMainProfileView(),
          SizedBox(height: getSize(10)),
          ContractorProfileItems(),
          SizedBox(height: getSize(20)),
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse('https://iroidsolutions.com/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${StringConstant.developedBy} -',
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
          ),
          SizedBox(height: getSize(50)),
        ],
      ),
    );
  }
}
