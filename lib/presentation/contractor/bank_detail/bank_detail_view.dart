import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/auth/contractor_auth/bank_details_bloc/bank_details_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "BankListView")
class BankListView extends StatelessWidget {
  const BankListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BankDetailsBloc>()..add(BankDetailsEvent.getBankDetails()),
      child: BlocBuilder<BankDetailsBloc, BankDetailsState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding:
                  EdgeInsets.all(getSize(20)).copyWith(bottom: getSize(40)),
              child: CommonButton(
                onPressed: () {},
                buttonText: StringConstant.addBankDetails,
              ),
            ),
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.bankDetails,
            ),
            body: (state.isLoading)
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : Visibility(
                    visible: state.bankDetail != null,
                    replacement: noBankDetailView(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getSize(20), vertical: getSize(12)),
                      child: bankDetail(context),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget bankDetail(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(14),
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgImageConstant.bankDollar,
            height: getSize(45),
            width: getSize(45),
          ),
          SizedBox(width: getSize(15)),
          Image.asset(
            PngImageConstants.line,
            height: getSize(80),
          ),
          SizedBox(width: getSize(15)),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: BaseText(
                        text:
                            "${getCurrentUser().firstName ?? ""} ${getCurrentUser().lastName ?? ""}",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Gap(getSize(5)),
                    verificationTag(
                      color: AppColors.primaryColor,
                      label: StringConstant.verified,
                      icon: SvgImageConstant.verify,
                    ),
                  ],
                ),
                SizedBox(height: getSize(5)),
                BaseText(
                    text: "Transit Number",
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
                SizedBox(height: getSize(10)),
                BaseText(
                  text: "********2548",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          SizedBox(width: getSize(15)),
          Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(6),
            color: AppColors.red.withOpacity(0.15),
            child: InkWell(
              onTap: () {
                AppDialog.showDelete(
                  context,
                  title: StringConstant.deleteAccount,
                  infoMessage:
                      StringConstant.areYouSureYouWantToDeleteThisBankccount,
                  onCancelClick: () {
                    context.router.maybePop();
                  },
                  onDeleteClick: () {},
                );
              },
              child: Padding(
                padding: EdgeInsets.all(getSize(5)),
                child: SvgPicture.asset(
                  SvgImageConstant.delete,
                  color: AppColors.red,
                  height: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget verificationTag(
      {required String icon, required String label, required Color color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, height: 14),
        Gap(getSize(2)),
        BaseText(
          text: label,
          fontWeight: FontWeight.w500,
          fontSize: 10,
          textColor: color,
        ),
      ],
    );
  }

  Widget noBankDetailView() {
    return Padding(
      padding: EdgeInsets.all(getSize(28)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            height: getSize(100),
            width: getSize(100),
            SvgImageConstant.bankDollar,
            colorFilter: ColorFilter.mode(
                AppColors.black.withOpacity(0.7), BlendMode.srcIn),
          ),
          Gap(getSize(30)),
          BaseText(
            text: StringConstant.noBankDetailsAdded,
            fontFamily: "Aclonica",
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          Gap(getSize(5)),
          BaseText(
            fontSize: 14,
            text: StringConstant.noBankDetailsDesc,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
