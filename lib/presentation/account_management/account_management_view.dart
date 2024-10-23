import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "AccountManagementView")
class AccountManagementView extends StatelessWidget {
  const AccountManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Account Management',
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(SvgImageConstant.accountManagement),
                  Gap(getSize(25)),
                  BaseText(text: "Account Setting", fontFamily: "Aclonica", fontSize: 22, fontWeight: FontWeight.w400),
                  SizedBox(
                    width: MediaQuery
                        .sizeOf(context)
                        .width * 0.8,
                    child: BaseText(
                      text: "Manage your account settings and preferences here.",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Gap(getSize(50)),
            Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(15),
              color: AppColors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ListTile(
                    icon: SvgImageConstant.lock,
                    onPressed: () => context.router.push(PageRouteInfo(ChangePasswordView.name)),
                    label: "Change Password",
                  ),
                  _ListTile(
                    icon: SvgImageConstant.delete,
                    onPressed: () {
                      AppDialog.showDelete(
                        context,
                        title: "Delete Account",
                        infoMessage: "Are you sure you want to delete your account? This action is permanent and cannot be undone.",
                        onCancelClick: () => context.router.maybePop(),
                        onDeleteClick: () {},
                      );
                    },
                    label: "Delete Account",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.icon,
    required this.onPressed,
    required this.label,
  });

  final String icon;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: BaseText(text: label, fontSize: 12, fontWeight: FontWeight.w500),
      leading: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
      ),
      trailing: Icon(Icons.arrow_forward_rounded, size: 18),
    );
  }
}
