import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/auth_status/auth_status_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/domain/profile/profile_item_model.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';

class ProfileItems extends StatelessWidget {
  const ProfileItems({super.key});

  @override
  Widget build(BuildContext context) {
    var profileItems = <ProfileItemModel>[
      ProfileItemModel(
        title: 'Completed Shifts',
        image: SvgImageConstant.completedShifts,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Previous ShiftPros',
        image: SvgImageConstant.previousShifts,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Chat',
        image: SvgImageConstant.chat,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Locations',
        image: SvgImageConstant.locationIcon,
        onTap: () {
          //context.router.push(PageRouteInfo(LocationDetailForm.name));
        },
      ),
      ProfileItemModel(
        title: 'Teams',
        image: SvgImageConstant.teams,
        onTap: () {
          context.router.push(PageRouteInfo(TeamsView.name));
        },
      ),
      ProfileItemModel(
        title: 'Saved Templates',
        image: SvgImageConstant.savedTemplates,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Billing',
        image: SvgImageConstant.billing,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Account Management',
        image: SvgImageConstant.setting,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'About ShiftFinder',
        image: SvgImageConstant.aboutShiftFinder,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Customer Support',
        image: SvgImageConstant.customerSupport,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Log Out',
        image: SvgImageConstant.logout,
        onTap: () {
          AcceptRejectDialog(
            title: 'Logout',
            description: 'Are you sure you want to log out?',
            onPressedAccept: () {
              context.router.maybePop().then(
                    (value) => context
                        .read<AuthStatusBloc>()
                        .add(AuthStatusEvent.signedOut()),
                  );
            },
            onPressedReject: () {
              context.router.maybePop();
            },
            acceptButtonText: 'Logout',
          ).acceptRejectDialog(context);
        },
      ),
    ];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getSize(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(15)),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: profileItems.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          dense: true,
          minVerticalPadding: 0,
          onTap: profileItems[index].onTap,
          visualDensity: VisualDensity.compact,
          leading: SvgPicture.asset(
            profileItems[index].image,
            height: getSize(20),
            width: getSize(20),
          ),
          contentPadding: EdgeInsets.zero,
          trailing: Icon(
            Icons.arrow_forward_rounded,
            size: getSize(20),
            color: AppColors.black.withOpacity(0.5),
          ),
          title: BaseText(
            text: profileItems[index].title,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ContractorProfileItems extends StatelessWidget {
  const ContractorProfileItems({super.key});

  @override
  Widget build(BuildContext context) {
    var profileItems = <ProfileItemModel>[
      /*ProfileItemModel(
        title: 'Completed Shifts',
        image: SvgImageConstant.completedShifts,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Previous ShiftPros',
        image: SvgImageConstant.previousShifts,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Chat',
        image: SvgImageConstant.chat,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Locations',
        image: SvgImageConstant.locationIcon,
        onTap: () {
          //context.router.push(PageRouteInfo(LocationDetailForm.name));
        },
      ),
      ProfileItemModel(
        title: 'Teams',
        image: SvgImageConstant.teams,
        onTap: () {
          context.router.push(PageRouteInfo(TeamsView.name));
        },
      ),
      ProfileItemModel(
        title: 'Saved Templates',
        image: SvgImageConstant.savedTemplates,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Billing',
        image: SvgImageConstant.billing,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Account Management',
        image: SvgImageConstant.setting,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'About ShiftFinder',
        image: SvgImageConstant.aboutShiftFinder,
        onTap: () {},
      ),
      ProfileItemModel(
        title: 'Customer Support',
        image: SvgImageConstant.customerSupport,
        onTap: () {},
      ),*/
      ProfileItemModel(
        title: 'Log Out',
        image: SvgImageConstant.logout,
        onTap: () {
          AcceptRejectDialog(
            title: 'Logout',
            description: 'Are you sure you want to log out?',
            onPressedAccept: () {
              context.router.maybePop().then(
                    (value) => context
                        .read<AuthStatusBloc>()
                        .add(AuthStatusEvent.signedOut()),
                  );
            },
            onPressedReject: () {
              context.router.maybePop();
            },
            acceptButtonText: 'Logout',
          ).acceptRejectDialog(context);
        },
      ),
    ];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getSize(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(15)),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: profileItems.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          dense: true,
          minVerticalPadding: 0,
          onTap: profileItems[index].onTap,
          visualDensity: VisualDensity.compact,
          leading: SvgPicture.asset(
            profileItems[index].image,
            height: getSize(20),
            width: getSize(20),
          ),
          contentPadding: EdgeInsets.zero,
          trailing: Icon(
            Icons.arrow_forward_rounded,
            size: getSize(20),
            color: AppColors.black.withOpacity(0.5),
          ),
          title: BaseText(
            text: profileItems[index].title,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
