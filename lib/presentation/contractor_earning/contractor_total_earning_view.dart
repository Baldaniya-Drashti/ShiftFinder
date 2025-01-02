import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_earning_bloc/contractor_earning_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/monthly_statement_dto/monthly_statement_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/billing/invoice_detail_view.dart';
import 'package:shift/presentation/billing/invoice_viewer.dart';
import 'package:shift/presentation/billing/total_earning_statement_viewer.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/save_file_to_storage.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/no_data_ui.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage(name: "ContractorTotalEarningView")
class ContractorTotalEarningView extends StatelessWidget {
  const ContractorTotalEarningView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorEarningBloc>(),
      child: BlocBuilder<ContractorEarningBloc, ContractorEarningState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.totalEarningsStatement,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocSelector<ContractorEarningBloc, ContractorEarningState,
                    List<DateTime>>(
                  selector: (state) => state.selectedDateTime,
                  builder: (context, selectedDateTime) {
                    return DateRangePickerTile(
                      label: StringConstant.period,
                      selectedDate: selectedDateTime,
                      onDateSelected: (value) {
                        print("selected range dates---> $value");
                        context.read<ContractorEarningBloc>().add(
                            ContractorEarningEvent.onDateSelected(
                                dates: value));
                      },
                    );
                  },
                ),
                Gap(getSize(12)),
                Expanded(
                  child: (state.statement == null)
                      ? Center(
                          child: NoDataText(
                            title: "",
                            description: StringConstant
                                .pleaseSelectDateToViewEarningStatement,
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(getSize(16)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                companyDetail(context,
                                    statementPeriod: state.selectedDateTime,
                                    statement: state.statement ??
                                        MonthlyStatementDTO()),
                                commonDivider(),
                                _Earning(),
                                Gap(getSize(15)),
                                _Compensation(),
                                Gap(getSize(15)),
                                _ReferralBonus(),
                                Gap(getSize(15)),
                                Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.scaffoldColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MonthlyStatementInfo(
                                          label: StringConstant
                                              .totalCompletedShiftEarnings,
                                          value: "\$1350.00",
                                          showSign: false,
                                        ),
                                        MonthlyStatementInfo(
                                          label: StringConstant
                                              .totalCompensationReceived,
                                          value: "\$1350.00",
                                          showSign: false,
                                        ),
                                        MonthlyStatementInfo(
                                          label: StringConstant
                                              .totalReferralBonusReceived,
                                          value: "\$1350.00",
                                          showSign: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(22),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.green.withOpacity(0.2),
                                  ),
                                  padding: EdgeInsets.all(getSize(16)),
                                  child: MonthlyStatementInfo(
                                    label: StringConstant.netEarnings,
                                    value: "\$1070.00",
                                    showSign: false,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getSize(22)),
                                  child: _Footer(),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget commonDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Divider(),
    );
  }

  Widget companyDetail(BuildContext context,
      {required List<DateTime> statementPeriod,
      required MonthlyStatementDTO statement}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: getSize(60),
          child: Image.asset(PngImageConstants.splash_logo),
        ),
        Gap(getSize(8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: BaseText(
                          text: StringConstant.shiftFinder,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                  downLoadInvoiceBtn(onTap: () async {
                    final pdfData = await GenerateTotalEarningStatement()
                        .totalEarningStatement(selectedDates: statementPeriod);

                    String? pdfPath =
                        await SaveFileToStorage.savePdfToShiftFinderDirectory(
                            pdfData,
                            fileName: 'Total_Earning_Statement.pdf');

                    if (pdfPath != null) {
                      print('PDF saved to: $pdfPath');
                      showSuccess(
                              message: "Total Earning Statement Downloaded..!")
                          .show(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PdfViewerScreen(pdfPath: pdfPath),
                        ),
                      );
                    } else {
                      showError(message: "Failed to download PDF!")
                          .show(context);
                    }
                  }),
                ],
              ),
              BaseText(text: "Total Earning Statement", fontSize: 10),
              Gap(getSize(10)),
              BaseText(text: "Contractor Name", fontSize: 10),
              Gap(getSize(5)),
              Row(
                children: [
                  BaseText(text: "Statement Period", fontSize: 10),
                  Gap(getSize(5)),
                  BaseText(
                    text: getFormattedString(statementPeriod),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget downLoadInvoiceBtn({required void Function() onTap}) {
    return CommonButton(
      buttonText: "",
      onPressed: onTap,
      borderRadius: 5,
      width: 76,
      height: 20,
      backgroundColor: AppColors.primaryColor.withOpacity(0.20),
      buttonTextColor: AppColors.primaryColor,
      customWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            SvgImageConstant.download,
            width: getSize(10),
            height: getSize(10),
          ),
          SizedBox(width: getSize(5)),
          BaseText(
            textAlign: TextAlign.center,
            text: StringConstant.download,
            fontSize: 8,
            fontWeight: FontWeight.w500,
            textColor: AppColors.green,
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseText(
          text: StringConstant.shiftFinderInc,
          fontSize: 12,
          // fontWeight: FontWeight.bold,
        ),
        Gap(getSize(4)),
        Image.asset(PngImageConstants.splash_logo,
            height: getSize(60), width: getSize(55)),
        Gap(getSize(4)),
        BaseText(
          text: StringConstant.contactInformation,
          fontSize: 12,
          textColor: AppColors.black,
          // fontWeight: FontWeight.bold,
        ),
        Gap(getSize(8)),
        _buildSeparateText(context,
            label: StringConstant.email, value: "debra.holt@example.com"),
        Gap(getSize(6)),
        _buildSeparateText(context,
            label: StringConstant.phoneNumber, value: "6325148452"),
        Gap(getSize(6)),
        _buildSeparateText(
          context,
          label: StringConstant.website,
          value: StringConstant.shiftFinderWebsite,
          onTap: () async {
            final Uri url = Uri.parse(StringConstant.shiftFinderWebsite);
            try {
              bool launched =
                  await launchUrl(url, mode: LaunchMode.externalApplication);
              if (!launched) {
                print("Could not launch the URL");
              }
            } catch (e) {
              print("Catch error: $e");
            }
          },
          valueColor: Color(0xFF218AEB),
        )
      ],
    );
  }

  Widget _buildSeparateText(
    BuildContext context, {
    VoidCallback? onTap,
    Color? valueColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        BaseText(text: "$label : ", fontSize: 11, fontWeight: FontWeight.w500),
        GestureDetector(
          onTap: onTap,
          child: BaseText(
              text: value,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              textColor: valueColor),
        ),
      ],
    );
  }
}

class _Earning extends StatelessWidget {
  const _Earning();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatementHeadingTitle(
          title: StringConstant.completedShiftsEarning,
          color: AppColors.green.withOpacity(0.15),
        ),
        // Gap(getSize(8)),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(
                    label: StringConstant.date, value: "12 May 2024"),
                TransactionInfo(
                    label: StringConstant.companyName,
                    value: "Louis Vuitton Pvt. Ltd."),
                TransactionInfo(
                    label: StringConstant.location,
                    value: "6391 Elgin St. Celina, Delaware"),
                TransactionInfo(
                    label: StringConstant.hoursWorked, value: "9 h 30 min"),
                TransactionInfo(
                    label: StringConstant.hourlyRate, value: "\$30.00"),
                TransactionInfo(label: StringConstant.wages, value: "\$30.00"),
                TransactionInfo(
                    label: StringConstant.allowances, value: "\$30.00"),
                TransactionInfo(
                    label: StringConstant.earnings,
                    value: "\$335.00",
                    valueColor: AppColors.green),
              ],
            );
          },
        ),
        Gap(getSize(12)),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.scaffoldColor,
          child: Padding(
            padding: EdgeInsets.all(getSize(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MonthlyStatementInfo(
                  label: StringConstant.totalWage,
                  value: "\$1350.00",
                  showSign: false,
                ),
                MonthlyStatementInfo(
                  label: StringConstant.totalAllowance,
                  value: "\$1350.00",
                  showSign: false,
                ),
                Divider(),
                MonthlyStatementInfo(
                    label: StringConstant.totalEarnings,
                    value: "\$1350.00",
                    showSign: false,
                    valueColor: AppColors.green),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Compensation extends StatelessWidget {
  const _Compensation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatementHeadingTitle(
          title: StringConstant.compensationReceivedFromCancellations,
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(
                    label: StringConstant.date, value: "12 May 2024"),
                TransactionInfo(
                    label: StringConstant.companyName,
                    value: "Louis Vuitton Pvt. Ltd."),
                TransactionInfo(
                    label: StringConstant.location,
                    value: "6391 Elgin St. Celina, Delaware"),
                TransactionInfo(
                    label: StringConstant.cancellationFee,
                    value: "\$120.00",
                    valueColor: AppColors.green),
              ],
            );
          },
        ),
        Gap(getSize(12)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(getSize(12)),
          child: MonthlyStatementInfo(
              label: StringConstant.totalCancellationFee,
              value: "\$200.00",
              showSign: false,
              valueColor: AppColors.green),
        ),
      ],
    );
  }
}

class _ReferralBonus extends StatelessWidget {
  const _ReferralBonus();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatementHeadingTitle(
          title: StringConstant.referralBonusReceived,
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(
                    label: StringConstant.date, value: "12 May 2024"),
                TransactionInfo(
                    label: StringConstant.referredContractorName,
                    value: "David Malpas"),
                TransactionInfo(
                    label: StringConstant.bonusAmount,
                    value: "\$50.00",
                    valueColor: AppColors.green),
              ],
            );
          },
        ),
        Gap(getSize(12)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(getSize(12)),
          child: MonthlyStatementInfo(
            label: StringConstant.totalBonus,
            value: "\$170.00",
            showSign: false,
            valueColor: AppColors.green,
          ),
        ),
      ],
    );
  }
}
