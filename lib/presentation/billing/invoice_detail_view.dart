import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
// import 'package:printing/printing.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/billing/invoice_viewer.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/utils/save_file_to_storage.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "InvoiceDetailView")
class InvoiceDetailView extends StatelessWidget {
  const InvoiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final isContractor = getCurrentRole() == 1;

    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Invoice',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          children: [
            BaseTileDecoration(
              padding: EdgeInsets.symmetric(
                  vertical: getSize(25), horizontal: getSize(10)),
              child: Column(
                children: [
                  companyDetail(showDownloadBtn: isContractor),
                  commonDivider(),
                  _ContractorDetail(),
                  Gap(getSize(16)),
                  _ShiftDetail(),
                  Gap(getSize(16)),
                  _PaymentDetail(),
                  if (isContractor) ...[
                    Divider(),
                    TransactionInfo(
                        label: "Total Earnings",
                        value: "\$500",
                        valueColor: AppColors.green,
                        valueFontSize: 12),
                    Gap(getSize(10)),
                    downLoadInvoiceBtn(
                      isContractor,
                      onTap: () async {
                        showInvoice(context);
                      },
                    ),
                  ] else ...[
                    Gap(getSize(16)),
                    Container(
                      padding: EdgeInsets.all(getSize(16)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.green.withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: "${StringConstant.totalAmountPayable} :",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          BaseText(
                            text: "\$170.00",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    )
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget commonDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Divider(),
    );
  }

  Widget downLoadInvoiceBtn(bool isContractor,
      {required void Function() onTap}) {
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
            textColor: isContractor ? AppColors.white : AppColors.green,
          ),
        ],
      ),
    );
  }

  Widget companyDetail({bool showDownloadBtn = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox.square(
          dimension: getSize(60),
          child: Image.asset(PngImageConstants.leafWithBG),
        ),
        Gap(getSize(8)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: "Louis Vuitton Pvt. Ltd.",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      BaseText(
                          text: "(Healthcare - 2DFG175)",
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  if (!showDownloadBtn) ...[
                    downLoadInvoiceBtn(
                      showDownloadBtn,
                      onTap: () {},
                    ),
                  ]
                ],
              ),
              Gap(getSize(3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    SvgImageConstant.location,
                    colorFilter:
                        ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                    height: getSize(24),
                    width: getSize(24),
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
        StatementHeadingTitle(title: "Contractor’s Details"),
        TransactionInfo(label: "Name", value: "Rochel Foose"),
        TransactionInfo(label: "Email", value: "debra.holt@example.com"),
        TransactionInfo(
            label: "Address", value: "6391 Elgin St. Celina, Delaware 10299")
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
        StatementHeadingTitle(title: "Shift’s Details"),
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
        StatementHeadingTitle(title: "Payment’s Details"),
        TransactionInfo(label: "Total Payable Hours", value: "9h 30min"),
        TransactionInfo(label: "Hourly Rate", value: "\$10.00"),
        TransactionInfo(label: "Total Wage", value: "\$92.05"),
        TransactionInfo(label: "ShiftFinder Service Fee", value: "\$50.00"),
        TransactionInfo(label: "Total Allowance", value: "\$30.00"),
      ],
    );
  }
}

class StatementHeadingTitle extends StatelessWidget {
  const StatementHeadingTitle({
    super.key,
    required this.title,
    this.color,
  });

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding:
          EdgeInsets.symmetric(horizontal: getSize(18), vertical: getSize(10)),
      margin: EdgeInsets.symmetric(vertical: getSize(10)),
      decoration: BoxDecoration(
        color: color ?? AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: BaseText(text: title, fontSize: 10, fontWeight: FontWeight.w600),
    );
  }
}

void showInvoice(BuildContext context) async {
  final pdfData =
      await InvoiceGenerator().generateContractorCompleteShiftInvoice();

  String? pdfPath = await SaveFileToStorage.savePdfToShiftFinderDirectory(
      pdfData,
      fileName: 'PreviusShift_Invoice.pdf');

  if (pdfPath != null) {
    print('PDF saved to: $pdfPath');
    showSuccess(message: "Invoice Downloaded..!").show(context);
    /* Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfPath: pdfPath),
      ),
    ); */
  } else {
    showError(message: "Failed to download PDF!").show(context);
  }
}
