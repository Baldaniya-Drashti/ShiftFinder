import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage(name: "CustomerSupportView")
class CustomerSupportView extends StatelessWidget {
  const CustomerSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: StringConstant.customerSupport,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Gap(getSize(50)),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(SvgImageConstant.consumerSupport,
                      height: 100),
                  Gap(getSize(30)),
                  BaseText(
                      text: StringConstant.helpDesk,
                      fontFamily: "Aclonica",
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                  Gap(getSize(12)),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: BaseText(
                      text: StringConstant.helpDeskDesk,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Gap(getSize(50)),
              if (getCurrentRole() == 1)
                Padding(
                  padding:
                      EdgeInsets.only(left: getSize(18), bottom: getSize(15)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: BaseText(
                      text: StringConstant.customerSupport,
                      fontSize: 14,
                    ),
                  ),
                ),
              supportTile(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget supportTile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getSize(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ListTile(
            icon: SvgImageConstant.ticket,
            onPressed: () =>
                context.router.push(PageRouteInfo(SupportTicketView.name)),
            label: StringConstant.submitATicket,
          ),
          SizedBox(height: getSize(10)),
          _ListTile(
            icon: SvgImageConstant.message,
            onPressed: () {
              showUnderDevelopment(context);
              /* context.router.push(
                        PageRouteInfo(
                          Message.name,
                          args: MessageArgs(
                            receiverId: post.user?.user_id ?? 0,
                          ),
                        ),
                      ); */
            },
            label: StringConstant.chatWithSupport,
          ),
          if (getCurrentRole() == 1) ...[
            SizedBox(height: getSize(10)),
            _ListTile(
              icon: SvgImageConstant.questionMark,
              onPressed: () async {
                // context.router.push(PageRouteInfo(FaqView.name));
                final Uri url =
                    Uri.parse('${StringConstant.shiftFinderWebsite}/faq-3/');
                try {
                  bool launched = await launchUrl(url,
                      mode: LaunchMode.externalApplication);
                  if (!launched) {
                    print("Could not launch the URL");
                  }
                } catch (e) {
                  print("Catch error: $e");
                }
              },
              label: StringConstant.faq,
            ),
          ]
        ],
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: AppColors.white,
      visualDensity: VisualDensity.compact,
      onTap: onPressed,
      title: BaseText(text: label, fontSize: 12, fontWeight: FontWeight.w600),
      leading: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
      ),
      trailing:
          SvgPicture.asset(SvgImageConstant.rightArrow2, height: 18, width: 18),
    );
  }
}
