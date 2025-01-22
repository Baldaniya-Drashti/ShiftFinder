import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/contractor_earning/contractor_wallet_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorWithdrawPaymentView")
class ContractorWithdrawPaymentView extends StatelessWidget {
  const ContractorWithdrawPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: StringConstant.withdrawPayment,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            WalletInfoSection(),
            Gap(30),
            SvgPicture.asset(
              SvgImageConstant.withdrawPayment,
              height: 80,
              width: 80,
            ),
            Gap(16),
            BaseText(
                text: "Enter Amount to Withdraw",
                fontWeight: FontWeight.w500,
                fontSize: 12),
            IntrinsicWidth(
              child: Row(
                children: [
                  BaseText(
                    text: "\$",
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    textColor: AppColors.green,
                  ),
                  Flexible(
                    child: TextField(
                      onSubmitted: (value) {
                        AppDialog.showSuccess(
                          context,
                          title: "Withdraw Successful!",
                          image: Image.asset(
                              PngImageConstants.withdrawDialogImage),
                          infoMessage:
                              "Payment successfully deposited to your bank account. Thank you for using ShiftFinder!",
                        );
                      },
                      autofocus: true,
                      cursorColor: AppColors.green,
                      cursorHeight: 35,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                          fontSize: 35),
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.green.withOpacity(0.4),
                            fontSize: 35),
                        hintText: "0.00",
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
