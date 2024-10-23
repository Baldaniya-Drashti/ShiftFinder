import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "BillingView")
class BillingView extends StatelessWidget {
  const BillingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Billing',
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(SvgImageConstant.billingAccount),
                Gap(getSize(25)),
                BaseText(text: "Billing Details", fontFamily: "Aclonica", fontSize: 22, fontWeight: FontWeight.w400),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: BaseText(
                    text: "Manage your financial transactions organized and up-to-date with detailed records.",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ),


              ],
            ),
          ),
          Gap(getSize(50)),
        ],
      ),
    );
  }
}
