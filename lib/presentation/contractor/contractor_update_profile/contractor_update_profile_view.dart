import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/auth/auth_status/auth_status_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import '../../../domain/core/string_constant.dart';

@RoutePage(name: "ContractorUpdateProfileView")
class ContractorUpdateProfileView extends StatelessWidget {
  const ContractorUpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: "Update Profile",
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(SvgImageConstant.updateProfile),
                Gap(getSize(25)),
                BaseText(text: "Profile", fontFamily: "Aclonica", fontSize: 22, fontWeight: FontWeight.w400),
                Gap(getSize(5)),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: BaseText(
                    text: "Keep your profile up-to-date to ensure accurate and complete information, boosting your hiring chances.",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Gap(getSize(50)),
            Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(15),
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ListTile(
                      icon: SvgImageConstant.editUser,
                      onPressed: () {
                        context.router.push(PageRouteInfo(AddExperienceDetailScreen.name));
                      },
                      label: "Role and Experience",
                    ),
                    _ListTile(
                      icon: SvgImageConstant.capOutline,
                      onPressed: () {
                        context.router.push(PageRouteInfo(EducationListScreen.name));
                      },
                      label: "Education",
                    ),
                    _ListTile(
                      icon: SvgImageConstant.document,
                      onPressed: () {
                        context.router.push(PageRouteInfo(DocumentPageScreen.name));
                      },
                      label: "Documents",
                    ),
                    _ListTile(
                      icon: SvgImageConstant.bank,
                      onPressed: () {
                        context.router.push(PageRouteInfo(BankListView.name));
                      },
                      label: "Bank Details",
                    ),
                    _ListTile(
                      icon: SvgImageConstant.references,
                      onPressed: () {
                        context.router.push(PageRouteInfo(ReferenceListView.name));

                      },
                      label: "References",
                    ),
                  ],
                ),
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
      visualDensity: VisualDensity.compact,
      onTap: onPressed,
      title: BaseText(text: label, fontSize: 12, fontWeight: FontWeight.w500),
      leading: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
      ),
      trailing: SvgPicture.asset(SvgImageConstant.rightArrow2, height: 18, width: 18),
    );
  }
}
