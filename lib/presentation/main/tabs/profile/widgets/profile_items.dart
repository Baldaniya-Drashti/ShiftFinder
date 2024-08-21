import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shift/application/auth/auth_status/auth_status_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
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
        title: StringConstant.completedShifts,
        image: SvgImageConstant.completedShifts,
        onTap: () {
          context.router.push(PageRouteInfo(EmployerCompletedShiftView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.previousShiftPros,
        image: SvgImageConstant.previousShifts,
        onTap: () {
          context.router.push(PageRouteInfo(PreviousShiftView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.longTermPositions,
        image: SvgImageConstant.previousShifts,
        onTap: () {
          context.router.push(PageRouteInfo(EmployerLongTermView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.fullTimePositions,
        image: SvgImageConstant.bagLocation,
        onTap: () {
          context.router.push(PageRouteInfo(EmployerFullPostingView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.chat,
        image: SvgImageConstant.chat,
        onTap: () {
          context.router.push(PageRouteInfo(Chat.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.locations,
        image: SvgImageConstant.locationIcon,
        onTap: () {
          context.router.push(PageRouteInfo(EmployerLocationView.name));
          //context.router.push(PageRouteInfo(EmployerLocationFormView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.teams,
        image: SvgImageConstant.teams,
        onTap: () {
          context.router.push(PageRouteInfo(TeamsView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.savedTemplates,
        image: SvgImageConstant.savedTemplates,
        onTap: () {
          context.router.push(PageRouteInfo(SaveTemplateView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.billing,
        image: SvgImageConstant.billing,
        onTap: () {
          context.router.push(PageRouteInfo(BillingView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.shareShiftFinder,
        image: SvgImageConstant.share,
        onTap: () async {
          final byteData =
              await rootBundle.load(PngImageConstants.shiftFinderWhiteLogo);

          final tempDir = await getTemporaryDirectory();
          final file = File('${tempDir.path}/logo.png');
          await file.writeAsBytes(byteData.buffer.asUint8List());

          String message = '''
ShiftFinder: Your Gateway to Healthcare Opportunities.\n
Explore your opportunities in healthcare! Download the ShiftFinder app to connect with top facilities across sectors like healthcare, pharmacy, dental, ophthalmology, and hospitality. Explore shifts that fit your schedule or find skilled professionals to meet your staffing needs. Start building better connections today!

Download now: ${StringConstant.shiftFinderWebsite}
''';
// https://play.google.com/store/apps/details?id=com.kiloo.subwaysurf&pcampaignid=web_share
          Share.shareXFiles(
            [XFile(file.path)],
            text: message,
            subject: StringConstant.joinShiftFinder,
          );
        },
      ),
      ProfileItemModel(
        title: StringConstant.accountManagement,
        image: SvgImageConstant.setting,
        onTap: () {
          context.router.push(PageRouteInfo(AccountManagementView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.aboutShiftFinder,
        image: SvgImageConstant.aboutShiftFinder,
        onTap: () {
          context.router.push(PageRouteInfo(AboutView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.customerSupport,
        image: SvgImageConstant.customerSupport,
        onTap: () {
          context.router.push(
            PageRouteInfo(CustomerSupportView.name),
          );
        },
      ),
      ProfileItemModel(
        title: StringConstant.logOut,
        image: SvgImageConstant.logout,
        onTap: () {
          AcceptRejectDialog(
            title: StringConstant.logoutJoin,
            description: StringConstant.logoutAlertDesc,
            onPressedAccept: () {
              context.router.maybePop().then(
                    (value) => context
                        .read<AuthStatusBloc>()
                        .add(AuthStatusEvent.signedOut(isDeleteAccount: false)),
                  );
            },
            onPressedReject: () {
              context.router.maybePop();
            },
            acceptButtonText: StringConstant.logoutJoin,
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
      ProfileItemModel(
        title: StringConstant.updateProfile,
        image: SvgImageConstant.person,
        onTap: () {
          context.router.push(PageRouteInfo(ContractorUpdateProfileView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.previousShifts,
        image: SvgImageConstant.completedShifts,
        onTap: () {
          context.router.push(PageRouteInfo(ContractorPreviousShiftView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.longTermPositions,
        image: SvgImageConstant.calendarWithClock,
        onTap: () {
          context.router.push(PageRouteInfo(ContractorLongTermView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.fullTimePositions,
        image: SvgImageConstant.bagLocation,
        onTap: () {
          context.router
              .push(PageRouteInfo(ContractorFullTimePositionView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.myCalendar,
        image: SvgImageConstant.calendar,
        onTap: () {
          context.router.push(PageRouteInfo(MyCalendarView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.chat,
        image: SvgImageConstant.chat,
        onTap: () {
          context.router.push(PageRouteInfo(Chat.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.myEarnings,
        image: SvgImageConstant.billing,
        onTap: () {
          context.router.push(PageRouteInfo(ContractorEarningView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.performanceInsights,
        image: SvgImageConstant.insights,
        onTap: () {
          context.router
              .push(PageRouteInfo(ContractorPerformanceInsightView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.referAColleague,
        image: SvgImageConstant.referral,
        onTap: () {
          context.router.push(PageRouteInfo(ReferColleagueView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.ratings,
        image: SvgImageConstant.star,
        onTap: () {
          context.router.push(PageRouteInfo(ContractorRatingView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.shareShiftFinder,
        image: SvgImageConstant.share,
        onTap: () async {
          final byteData =
              await rootBundle.load(PngImageConstants.shiftFinderWhiteLogo);

          final tempDir = await getTemporaryDirectory();
          final file = File('${tempDir.path}/logo.png');
          await file.writeAsBytes(byteData.buffer.asUint8List());

          String message = '''
ShiftFinder: Your Gateway to Healthcare Opportunities.\n
Explore your opportunities in healthcare! Download the ShiftFinder app to connect with top facilities across sectors like healthcare, pharmacy, dental, ophthalmology, and hospitality. Explore shifts that fit your schedule or find skilled professionals to meet your staffing needs. Start building better connections today!

Download now: ${StringConstant.shiftFinderWebsite}
''';
// https://play.google.com/store/apps/details?id=com.kiloo.subwaysurf&pcampaignid=web_share

          Share.shareXFiles(
            [XFile(file.path)],
            text: message,
            subject: StringConstant.joinShiftFinder,
          );
        },
      ),
      ProfileItemModel(
        title: StringConstant.accountManagement,
        image: SvgImageConstant.setting,
        onTap: () {
          context.router.push(PageRouteInfo(AccountManagementView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.policies,
        image: SvgImageConstant.policies,
        onTap: () {
          context.router.push(PageRouteInfo(AboutView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.supportHelp,
        image: SvgImageConstant.customerSupport,
        onTap: () {
          context.router.push(PageRouteInfo(CustomerSupportView.name));
        },
      ),
      ProfileItemModel(
        title: StringConstant.logOut,
        image: SvgImageConstant.logout,
        onTap: () {
          AcceptRejectDialog(
            title: StringConstant.logoutJoin,
            description: StringConstant.logoutAlertDesc,
            onPressedAccept: () {
              context.router.maybePop().then(
                    (value) => context
                        .read<AuthStatusBloc>()
                        .add(AuthStatusEvent.signedOut(isDeleteAccount: false)),
                  );
            },
            onPressedReject: () {
              context.router.maybePop();
            },
            acceptButtonText: StringConstant.logoutJoin,
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
