import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/billing/common_payment_history_tile.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "PaymentHistoryView")
class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Payment History',
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) => CommonPaymentHistoryTile(
          child: _PaymentHistoryExpandableTile(),
        ),
        separatorBuilder: (context, index) => Gap(16),
        itemCount: 5,
      ),
    );
  }
}

class _PaymentHistoryExpandableTile extends StatelessWidget {
  const _PaymentHistoryExpandableTile();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      collapsedBackgroundColor: AppColors.scaffoldColor,
      backgroundColor: AppColors.scaffoldColor,
      visualDensity: VisualDensity.compact,
      childrenPadding: EdgeInsets.all(15).copyWith(top: 0),
      trailing: SvgPicture.asset(SvgImageConstant.downArrow),
      title: _buildPaymentDetailTitle(context, title: 'Total Amount Payable', amount: "860"),
      children: [
        Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPaymentDetailTitle(context, title: "Total Wage", amount: "92.05"),
                Gap(10),
                _buildPaymentDetailTitle(context, title: "Total Allowance", amount: "30"),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox.square(
                dimension: 55,
                child: SvgPicture.asset(
                  SvgImageConstant.billingAccount,
                  colorFilter: ColorFilter.mode(AppColors.green.withOpacity(0.15), BlendMode.srcIn),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildPaymentDetailTitle(
    BuildContext context, {
    required String title,
    required String amount,
  }) {
    final Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgPicture.asset(SvgImageConstant.dollorRound, height: 18, width: 18),
        Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: title,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            BaseText(
              text: amount,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textColor: AppColors.green,
            ),
          ],
        ),
      ],
    );
    return content;
  }
}
