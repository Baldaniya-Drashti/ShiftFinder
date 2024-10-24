import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "InvoiceDetailView")
class InvoiceDetailView extends StatelessWidget {
  const InvoiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Invoices',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BaseTileDecoration(
              child: Column(
                children: [
                  Gap(8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox.square(
                        dimension: 60,
                        child: Image.asset(PngImageConstants.leafWithBG),
                      ),
                      Gap(8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: BaseText(text: "Louis Vuitton Pvt. Ltd.", fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                Material(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: AppColors.green.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(5),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            SvgImageConstant.download,
                                            height: 16,
                                            width: 16,
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
                                  ),
                                )
                              ],
                            ),
                            BaseText(text: "(Healthcare - 2DFG175)", fontSize: 12, fontWeight: FontWeight.w400),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  SvgImageConstant.location,
                                  colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                                  height: 24,
                                  width: 24,
                                ),
                                Expanded(
                                  child: BaseText(
                                    text: "4517 Washington Manchester, Kentucky 39495",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(16),
                  Divider(height: 0),
                  Gap(16),
                  _ContractorDetail(),
                  Gap(16),
                  _ShiftDetail(),
                  Gap(16),
                  _PaymentDetail(),
                  Gap(16),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.green.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: BaseText(
                              text: "Total Amount Payable :",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          BaseText(
                            text: "\$170.00",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ],
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

class _ContractorDetail extends StatelessWidget {
  const _ContractorDetail();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _InvoiceTitle(title: "Contractor’s Details"),
        Gap(8),
        TransactionInfo(label: "Name", value: "Rochel Foose"),
        TransactionInfo(label: "Email", value: "debra.holt@example.com"),
        TransactionInfo(label: "Address", value: "6391 Elgin St. Celina, Delaware 10299")
      ],
    );
  }
}

class _ShiftDetail extends StatelessWidget {
  const _ShiftDetail();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _InvoiceTitle(title: "Shift’s Details"),
        Gap(8),
        TransactionInfo(label: "Shift Type", value: "Single"),
        TransactionInfo(label: "Role", value: "CT Technologist"),
        TransactionInfo(label: "Date", value: "12 May 2024")
      ],
    );
  }
}

class _PaymentDetail extends StatelessWidget {
  const _PaymentDetail();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _InvoiceTitle(title: "Payment’s Details"),
        Gap(8),
        TransactionInfo(label: "Total Payable Hours", value: "9h 30min"),
        TransactionInfo(label: "Hourly Rate", value: "\$10.00"),
        TransactionInfo(label: "Total Wage", value: "\$92.05"),
        TransactionInfo(label: "ShiftFinder Service Fee", value: "\$50.00"),
        TransactionInfo(label: "Total Allowance", value: "\$30.00"),
      ],
    );
  }
}

class _InvoiceTitle extends StatelessWidget {
  const _InvoiceTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Material(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BaseText(text: title, fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
