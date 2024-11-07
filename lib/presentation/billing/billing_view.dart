import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "BillingView")
class BillingView extends StatelessWidget {
  const BillingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: StringConstant.billing,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(SvgImageConstant.billingAccount),
                  Gap(getSize(25)),
                  BaseText(text: StringConstant.billingDetail, fontFamily: "Aclonica", fontSize: 22, fontWeight: FontWeight.w400),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: BaseText(
                      text: StringConstant.billingDetailDescription,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ListTile(
                      icon: SvgImageConstant.paymentHistory,
                      onPressed: () => context.router.push(PageRouteInfo(PaymentHistoryView.name)),
                      label: StringConstant.paymentHistory,
                    ),
                    _ListTile(
                      icon: SvgImageConstant.invoice,
                      onPressed: () => context.router.push(PageRouteInfo(InvoiceView.name)),
                      label: StringConstant.invoices,
                    ),
                    _ListTile(
                      icon: SvgImageConstant.paymentMethod,
                      onPressed: () => context.router.push(PageRouteInfo(PaymentMethodView.name)),
                      label: StringConstant.paymentMethod,
                    ),
                    _ListTile(
                      icon: SvgImageConstant.paymentHistory,
                      onPressed: () => context.router.push(PageRouteInfo(MonthlyStatementView.name)),
                      label: StringConstant.monthlyStatement,
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
      trailing: SvgPicture.asset(SvgImageConstant.rightArrow2, height: 18,width: 18),
    );
  }
}
