import 'dart:io';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:printing/printing.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/billing/pdf_viewer.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:pdf/widgets.dart' as pw;

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
                                  child: BaseText(
                                      text: "Louis Vuitton Pvt. Ltd.",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                if (!isContractor) ...[
                                  Gap(8),
                                  downLoadInvoiceBtn(
                                    isContractor,
                                    onTap: () {},
                                  ),
                                ]
                              ],
                            ),
                            Gap(3),
                            BaseText(
                                text: "(Healthcare - 2DFG175)",
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                            Gap(3),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  SvgImageConstant.location,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.green, BlendMode.srcIn),
                                  height: 24,
                                  width: 24,
                                ),
                                Expanded(
                                  child: BaseText(
                                    text:
                                        "4517 Washington Manchester, Kentucky 39495",
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
                  if (isContractor) ...[
                    Divider(),
                    TransactionInfo(
                        label: "Total Earnings",
                        value: "\$500",
                        valueColor: AppColors.green,
                        valueFontSize: 12),
                    Gap(16),
                    downLoadInvoiceBtn(
                      isContractor,
                      onTap: () async {
                        showInvoice(context);
                      },
                    ),
                    Gap(12),
                  ] else ...[
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
                                text: "${StringConstant.totalAmountPayable} :",
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
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget downLoadInvoiceBtn(bool isContractor,
      {required void Function() onTap}) {
    return CommonButton(
      buttonText: "",
      onPressed: onTap,
      height: 32,
      width: 200,
      borderRadius: 5,
      customWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            SvgImageConstant.download,
            height: getSize(12),
            width: getSize(12),
            colorFilter: ColorFilter.mode(
                isContractor ? AppColors.white : AppColors.green,
                BlendMode.srcIn),
          ),
          Gap(8),
          BaseText(
            textAlign: TextAlign.center,
            text:
                "${StringConstant.download} ${isContractor ? StringConstant.invoice : ""}",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            textColor: isContractor ? AppColors.white : AppColors.green,
          ),
        ],
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
        StatementHeadingTitle(title: "Contractor’s Details"),
        Gap(8),
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
        StatementHeadingTitle(title: "Payment’s Details"),
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
    return SizedBox(
      width: double.maxFinite,
      child: Material(
        color: color ?? AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(7),
        child: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(left: 12),
          child:
              BaseText(text: title, fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

Future<String?> savePdfToShiftFinderDirectory(Uint8List pdfData) async {
  try {
    // Request storage permissions for Android
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        return 'Storage permission denied.';
      }
    }

    // Get the Downloads directory
    Directory? downloadsDir;
    if (Platform.isAndroid) {
      downloadsDir = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      downloadsDir = await getApplicationDocumentsDirectory();
    }

    if (downloadsDir == null) {
      return 'Could not find Downloads directory.';
    }

    // Create "ShiftFinder" directory inside Downloads
    final shiftFinderDir = Directory('${downloadsDir.path}/ShiftFinder');
    if (!shiftFinderDir.existsSync()) {
      shiftFinderDir.createSync(recursive: true);
    }

    // Save the PDF file in the "ShiftFinder" directory
    final pdfPath = '${shiftFinderDir.path}/PreviusShift_Invoice.pdf';
    final file = File(pdfPath);
    await file.writeAsBytes(pdfData);

    return pdfPath; // Return the file path
  } catch (e) {
    return 'Error saving PDF: $e';
  }
}

void showInvoice(BuildContext context) async {
  // Generate the invoice
  final pdfData = await InvoiceGenerator().generateInvoice();

  // Save the PDF and get its path
  String? pdfPath = await savePdfToShiftFinderDirectory(pdfData);

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

class InvoiceGenerator {
  Future<Uint8List> generateInvoice() async {
    final pdf = pw.Document();

    // Load the custom font
    final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/RobotoFlex-Regular.ttf'),
    );

    pw.SizedBox paddingBetweenFilled({double? height, double? width}) {
      return (width != null)
          ? pw.SizedBox(width: getSize(width))
          : pw.SizedBox(height: getSize(height ?? 10));
    }

    final logoImage =
        // await rootBundle.loadString('assets/svg/contact_support.svg');
        await rootBundle.load('assets/png/leaf_with_bg.png');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Container(
          padding: pw.EdgeInsets.all(getSize(0)),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(getSize(8))),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                      width: getSize(60),
                      height: getSize(60),
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        border: pw.Border.all(
                          width: 2.0,
                          color: PdfColor.fromInt(0xFF0FB62A),
                        ),
                      ),
                      child: pw.Image(
                        pw.MemoryImage(logoImage.buffer.asUint8List()),
                      )),
                  paddingBetweenFilled(width: getSize(20)),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Louis Vuitton Pvt. Ltd.',
                          style: pw.TextStyle(
                            fontBold: regularFont,
                            fontSize: getFontSize(14),
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        paddingBetweenFilled(),
                        pw.Text(
                          '(Healthcare - 2DFG125)',
                          style: pw.TextStyle(
                              font: regularFont, fontSize: getFontSize(10)),
                        ),
                        paddingBetweenFilled(),
                        pw.Text(
                          '4517 Washington Manchester, Kentucky 39495',
                          style: pw.TextStyle(
                              font: regularFont, fontSize: getFontSize(10)),
                        ),
                      ]),
                ],
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: getSize(10)),
                child: pw.Divider(),
              ),
              titleWidget("Contractor's Details"),
              detailWidget(title: "Name :", value: "Rochel Foose"),
              detailWidget(title: "Email :", value: "debra.holt@example.com"),
              detailWidget(
                  title: "Address :",
                  value: "6391 Elgin St. Celina, Delaware 10299"),
              paddingBetweenFilled(height: getSize(30)),
              titleWidget("Shift's Details"),
              detailWidget(title: "Shift Type :", value: "Single"),
              detailWidget(title: "Role :", value: "CT Technologist"),
              detailWidget(title: "Date :", value: "12 May 2024"),
              paddingBetweenFilled(height: getSize(30)),
              titleWidget("Payment's Details"),
              detailWidget(title: "Total Worked Hours :", value: "9h 30min"),
              detailWidget(title: "Hourly Rate :", value: "\$10.00"),
              detailWidget(title: "Total Wage :", value: "\$200.05"),
              detailWidget(title: "Total Allowance :", value: "\$30.00"),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: getSize(10)),
                child: pw.Divider(),
              ),
              detailWidget(title: "Total Earnings :", value: "\$259.50"),
            ],
          ),
        ),
      ),
    );
    return pdf.save();
  }

  pw.Container titleWidget(String title) {
    return pw.Container(
      margin: pw.EdgeInsets.symmetric(vertical: getSize(10)),
      padding: pw.EdgeInsets.symmetric(
          horizontal: getSize(20), vertical: getSize(10)),
      decoration: pw.BoxDecoration(
          color: PdfColors.grey200,
          borderRadius: pw.BorderRadius.circular(
            getSize(5),
          )),
      alignment: pw.Alignment.centerLeft,
      child: pw.Text(title,
          style: pw.TextStyle(
            fontSize: getFontSize(12),
            fontWeight: pw.FontWeight.bold,
          )),
    );
  }

  pw.Padding detailWidget({
    required String title,
    required String value,
  }) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(
          horizontal: getSize(20), vertical: getSize(5)),
      child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Flexible(
              flex: 10,
              child: pw.Text(title,
                  style: pw.TextStyle(
                    fontSize: getFontSize(12),
                  )),
            ),
            pw.Flexible(
                flex: 13,
                child: pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(value,
                      style: pw.TextStyle(
                        fontSize: getFontSize(12),
                        fontWeight: pw.FontWeight.bold,
                      )),
                )),
          ]),
    );
  }
}
