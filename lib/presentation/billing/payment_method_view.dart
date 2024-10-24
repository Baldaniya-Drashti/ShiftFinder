import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "PaymentMethodView")
class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Payment Methods',
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(12).copyWith(left: 16, right: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    SvgImageConstant.securePayment,
                    height: 45,
                    width: 45,
                    colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                  ),
                  Gap(12),
                  Image.asset(
                    PngImageConstants.line,
                    height: getSize(80),
                  ),
                  Gap(16),
                  Expanded(
                    child: BaseText(
                      text: "Securely add your debit or credit card details to facilitate seamless transactions.",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Gap(30),
            BaseText(
              text: "Credit & Debit Cards",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            Gap(16),
            Expanded(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      tileColor: AppColors.white,
                      title: BaseText(text: "**** **** ****5614",fontWeight: FontWeight.w500,fontSize: 14,),
                      trailing: Material(
                        color: AppColors.redAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            SvgImageConstant.delete,
                            colorFilter: ColorFilter.mode(AppColors.redAccent, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => Gap(16),
                    itemCount: 3,
                  ),
                  Gap(16),
                  Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: AppColors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7),
                    child: InkWell(
                      onTap: () {
                        context.router.push(PageRouteInfo(AddCardDetailPage.name));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        child: BaseText(
                          text: "+Add New Card",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          textColor: AppColors.green,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
