import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_wallet/contractor_wallet_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/contractor_earning/contractor_wallet_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorWithdrawPaymentView")
class ContractorWithdrawPaymentView extends StatelessWidget {
  const ContractorWithdrawPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorWalletBloc>(),
      child: BlocBuilder<ContractorWalletBloc, ContractorWalletState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.withdrawPayment,
            ),
            body: Padding(
              padding: EdgeInsets.all(getSize(16)),
              child: Column(
                children: [
                  WalletInfoSection(),
                  Gap(getSize(30)),
                  (state.isLoading)
                      ? Expanded(
                          child: CenterLoadingIndicator(isOnlyLoader: true))
                      : SingleChildScrollView(
                          padding: EdgeInsets.all(getSize(16)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                SvgImageConstant.withdrawPayment,
                                height: getSize(80),
                                width: getSize(80),
                              ),
                              Gap(getSize(12)),
                              BaseText(
                                text: StringConstant.enterAmountToWithdraw,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              IntrinsicWidth(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    BaseText(
                                      text: "\$",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30,
                                      textColor: AppColors.green,
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        onChanged: (value) {
                                          context
                                              .read<ContractorWalletBloc>()
                                              .add(ContractorWalletEvent
                                                  .withdrawPaymentChanged(
                                                      value));
                                        },
                                        onFieldSubmitted: (value) {
                                          context
                                              .read<ContractorWalletBloc>()
                                              .add(ContractorWalletEvent
                                                  .submitWithdrawPayment(
                                                      context));
                                        },
                                        // autofocus: true,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true, signed: true),
                                        maxLength: 5,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}')),
                                        ],
                                        cursorColor: AppColors.green,
                                        cursorHeight: getFontSize(34),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryColor,
                                            fontSize: getFontSize(34)),
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.4),
                                              fontSize: getFontSize(34)),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
