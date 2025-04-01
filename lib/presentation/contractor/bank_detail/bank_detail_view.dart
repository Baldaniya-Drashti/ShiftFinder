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
import 'package:shift/infrastructure/auth/contractor/bank/bank_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
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
            bottomNavigationBar: (state.bankDetail == null && !state.isLoading)
                ? Padding(
                    padding: EdgeInsets.all(getSize(20))
                        .copyWith(bottom: getSize(40)),
                    child: CommonButton(
                      onPressed: () {
                        context.router
                            .push(PageRouteInfo(AddBankDetailsScreen.name,
                                args: AddBankDetailsScreenArgs(isUpdate: true)))
                            .then((value) {
                          if (value == true) {
                            context
                                .read<BankDetailsBloc>()
                                .add(BankDetailsEvent.getBankDetails());
                          }
                        });
                      },
                      buttonText: StringConstant.addBankDetails,
                    ),
                  )
                : null,
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.bankDetails,
            ),
            body: (state.isLoading)
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : (state.bankDetail != null)
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getSize(20), vertical: getSize(12)),
                        child: bankDetail(context, bank: state.bankDetail!),
                      )
                    : noBankDetailView(),
          );
        },
      ),
    );
  }

  Widget bankDetail(BuildContext context, {required BankDTO bank}) {
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
                    BaseText(
                      text: "${bank.first_name ?? ""} ${bank.last_name ?? ""}",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(getSize(5)),
                    (bank.status == 1)
                        ? verificationTag(
                            color: AppColors.primaryColor,
                            label: StringConstant.verified,
                            icon: SvgImageConstant.verify,
                          )
                        : (bank.status == 2)
                            ? verificationTag(
                                color: AppColors.red,
                                label: StringConstant.rejected,
                                icon: SvgImageConstant.rejected,
                              )
                            : verificationTag(
                                color: AppColors.yellowColor,
                                label: StringConstant.pending,
                                icon: SvgImageConstant.pending,
                              ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: getSize(5)),
                          BaseText(
                              text: bank.transit_number ?? "",
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                          SizedBox(height: getSize(5)),
                          BaseText(
                            text: "********${bank.account_number}",
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: getSize(15)),
                    InkWell(
                      onTap: () {
                        context.router
                            .push(PageRouteInfo(AddBankDetailsScreen.name,
                                args: AddBankDetailsScreenArgs(
                                    bankDetail: bank, isUpdate: true)))
                            .then((value) {
                          if (value == true) {
                            context
                                .read<BankDetailsBloc>()
                                .add(BankDetailsEvent.getBankDetails());
                          }
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                            horizontal: getSize(5), vertical: getSize(10)),
                        child: SvgPicture.asset(SvgImageConstant.editWithBg),
                      ),
                    ),
                    /*  InkWell(
                      onTap: () {
                        AppDialog.showDelete(
                          context,
                          title: StringConstant.deleteAccount,
                          infoMessage: StringConstant
                              .areYouSureYouWantToDeleteThisBankccount,
                          onCancelClick: () {
                            context.router.maybePop();
                          },
                          onDeleteClick: () {},
                        );
                      },
                      child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              horizontal: getSize(5), vertical: getSize(10)),
                          child: SvgPicture.asset(SvgImageConstant.bin)),
                    ),
                   */
                  ],
                )
              ],
            ),
          ),
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
                AppColors.black.withValues(alpha: 0.7), BlendMode.srcIn),
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
