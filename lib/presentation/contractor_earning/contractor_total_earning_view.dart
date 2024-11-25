import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/billing/invoice_detail_view.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorTotalEarningView")
class ContractorTotalEarningView extends StatelessWidget {
  const ContractorTotalEarningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: "Total Earning Statement",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DateRangePickerTile(
              onDateSelected: (value) {},
              label: "Period",
            ),
            Gap(12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: BaseText(text: "ShiftFinder", fontSize: 12, fontWeight: FontWeight.w400)),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.green.withOpacity(0.15),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgImageConstant.download,
                                height: 16,
                                width: 16,
                                colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                              ),
                              Gap(8),
                              BaseText(
                                textAlign: TextAlign.center,
                                text: "Download",
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.green,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  BaseText(text: "Total Earning Statement", fontWeight: FontWeight.w400, fontSize: 10),
                  Gap(12),
                  BaseText(text: "Contractor Name", fontSize: 12),
                  Gap(6),
                  Row(
                    children: [
                      BaseText(text: "Statement Period", fontSize: 10),
                      Gap(3),
                      BaseText(
                        text: "2 Apr 2024 to  2 May 2024",
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Gap(6),
                  Divider(),
                  Gap(12),
                  _Earning(),
                  Gap(22),
                  _Compensation(),
                  Gap(22),
                  _ReferralBonus(),
                  Gap(22),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.scaffoldColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MonthlyStatementInfo(label: "Total Completed Shift Earnings", value: "\$1350.00"),
                          MonthlyStatementInfo(label: "Total Compensation Received", value: "\$1350.00"),
                          MonthlyStatementInfo(label: "Total Referral Bonus Received", value: "\$1350.00"),
                        ],
                      ),
                    ),
                  ),
                  Gap(22),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.green.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: BaseText(
                              text: "Net Earnings",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.black.withOpacity(0.8),
                            ),
                          ),
                          BaseText(
                            text: "\$1070.00",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(22),
                  _Footer(),
                  Gap(22),
                ],
              ),
            ),
          ],
        ),
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
        BaseText(text: "ShiftFinder Inc.", fontSize: 12),
        Gap(4),
        Image.asset(PngImageConstants.splash_logo, height: 50, width: 50),
        Gap(4),
        BaseText(text: "Contact Information", fontSize: 12,textColor: AppColors.black),
        Gap(6),
        _buildSeparateText(context, label: "Email", value: "debra.holt@example.com"),
        Gap(6),
        _buildSeparateText(context, label: "Phone Number", value: "6325148452"),
        Gap(6),
        _buildSeparateText(context, label: "Website", value: "Www.ShiftFinder.com", valueColor: Color(0xFF218AEB))
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
        BaseText(text: "$label :", fontSize: 11, fontWeight: FontWeight.w500),
        GestureDetector(
          onTap: onTap,
          child: BaseText(text: value, fontSize: 11, fontWeight: FontWeight.w600, textColor: valueColor),
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
          title: "Completed Shifts Earning",
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(label: "Date", value: "12 May 2024"),
                TransactionInfo(label: "Company Name", value: "Louis Vuitton Pvt. Ltd."),
                TransactionInfo(label: "Location", value: "6391 Elgin St. Celina, Delaware"),
                TransactionInfo(label: "Hours Worked", value: "9 h 30 min"),
                TransactionInfo(label: "Hourly Rate", value: "\$30.00"),
                TransactionInfo(label: "Wages", value: "\$30.00"),
                TransactionInfo(label: "Allowances", value: "\$30.00"),
                TransactionInfo(label: "Earnings", value: "\$335.00", valueColor: AppColors.green),
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
        ),
        Gap(12),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.scaffoldColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MonthlyStatementInfo(label: "Total Wage", value: "\$1350.00"),
                MonthlyStatementInfo(label: "Total ShiftFinder Service Fee", value: "\$1350.00"),
                MonthlyStatementInfo(label: "Total Shift Cancellation Fee", value: "\$1350.00"),
                Divider(),
                MonthlyStatementInfo(label: "Net Amount", value: "\$1350.00", valueColor: AppColors.green),
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
          title: "Compensation Received From Cancellations ",
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(label: "Date", value: "12 May 2024"),
                TransactionInfo(label: "Company Name", value: "Louis Vuitton Pvt. Ltd."),
                TransactionInfo(label: "Location", value: "6391 Elgin St. Celina, Delaware"),
                TransactionInfo(label: "Compensation Fee:", value: "\$120.00", valueColor: AppColors.green),
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
        ),
        Gap(12),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.scaffoldColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: "Total Cancellation Fee",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black.withOpacity(0.8),
                  ),
                ),
                BaseText(
                  text: "\$200.00",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  textColor: AppColors.green,
                ),
              ],
            ),
          ),
        )
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
          title: "Referral Bonus Received",
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(label: "Date", value: "12 May 2024"),
                TransactionInfo(label: "Referred Contractor Name", value: "David Malpas"),
                TransactionInfo(label: "Bonus Amount", value: "\$50.00", valueColor: AppColors.green),
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
        ),
        Gap(12),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.scaffoldColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: "Total Bonus",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black.withOpacity(0.8),
                  ),
                ),
                BaseText(
                  text: "\$170.00",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  textColor: AppColors.green,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
