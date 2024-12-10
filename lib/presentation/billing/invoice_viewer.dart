import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/employer_invoice_dto/employer_invoice_dto.dart';
import 'package:shift/infrastructure/core/monthly_statement_dto/monthly_statement_dto.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;
  const PdfViewerScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invoice Viewer")),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}

class InvoiceGenerator {
  Future<Uint8List> generateContractorCompleteShiftInvoice(
      EmployerInvoiceDTO invoice) async {
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

    final industry = CommonList.industryList
        .firstWhere((element) => element.id == invoice.industry);

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
                          invoice.employer_company_name ?? "",
                          style: pw.TextStyle(
                            fontBold: regularFont,
                            fontSize: getFontSize(14),
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        paddingBetweenFilled(),
                        pw.Text(
                          '(${industry.title ?? ""} - ${invoice.listing_id ?? ""})',
                          style: pw.TextStyle(
                              font: regularFont, fontSize: getFontSize(10)),
                        ),
                        paddingBetweenFilled(),
                        pw.Text(
                          invoice.location?.location ?? "",
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
              titleWidget(StringConstant.contractorsDetails),
              detailWidget(
                  title: "${StringConstant.name} :",
                  value:
                      "${invoice.contractor_first_name ?? ""} ${invoice.contractor_last_name ?? ""}"),
              detailWidget(
                  title: "${StringConstant.email} :",
                  value: invoice.contractor_email ?? ""),
              detailWidget(
                  title: "${StringConstant.address} :",
                  value: invoice.location?.location ?? ""),
              paddingBetweenFilled(height: getSize(30)),
              titleWidget(StringConstant.shiftsDetails),
              detailWidget(
                  title: "${StringConstant.shiftType} :",
                  value: (invoice.shift_type == "2")
                      ? StringConstant.multi
                      : StringConstant.single),
              detailWidget(
                  title: "${StringConstant.role} :",
                  value: invoice.roles_list_name ?? ""),
              detailWidget(
                  title: "${StringConstant.date} :",
                  value: (invoice.date != null)
                      ? DateFormat("dd MMM, yyyy").format(
                          DateTime.fromMillisecondsSinceEpoch(
                              (invoice.date!) * 1000))
                      : ""),
              paddingBetweenFilled(height: getSize(30)),
              titleWidget(StringConstant.paymentsDetails),
              detailWidget(
                  title: "${StringConstant.totalPayableHours} :",
                  value: invoice.total_payable_hours ?? ""),
              detailWidget(
                  title: "${StringConstant.hourlyRate} :",
                  value: "\$${invoice.hourly_rate ?? 00}"),
              detailWidget(
                  title: "${StringConstant.totalWage} :",
                  value: "\$${invoice.total_wage ?? 00}"),
              detailWidget(
                  title: "${StringConstant.totalAllowance} :",
                  value: "\$${invoice.total_allowance ?? 00}"),
              pw.Container(
                padding: pw.EdgeInsets.symmetric(
                    vertical: getSize(10), horizontal: getSize(16)),
                margin: pw.EdgeInsets.symmetric(vertical: getSize(15)),
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(10),
                  color: PdfColors.green100,
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("${StringConstant.totalAmountPayable} :",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Text("\$${invoice.total_amount_payble ?? "00"}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> generateMonthlyStatement(MonthlyStatementDTO statement,
      {required List<DateTime> selectedDates}) async {
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

    final logoImage = await rootBundle.load('assets/png/splash_logo.png');

    List<MonthlyStatementDetailDTO> data = statement.list ?? [];

    List<List<MonthlyStatementDetailDTO>> chunkedData = [];
    int chunkSize = 6;

    for (int i = 0; i < data.length; i += chunkSize) {
      chunkedData.add(data.sublist(
          i, i + chunkSize > data.length ? data.length : i + chunkSize));
    }

    final industry = CommonList.industryList.firstWhere((element) {
      return element.id == statement.industry_id;
    });

    final startDate = DateFormat('dd MMM').format(selectedDates.first);
    final endDate = DateFormat('dd MMM, yyyy').format(selectedDates.last);
    pdf.addPage(
      index: 0,
      pw.MultiPage(
          build: (pw.Context context) => [
                pw.Wrap(
                  alignment: pw.WrapAlignment.start,
                  crossAxisAlignment: pw.WrapCrossAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Container(
                            width: getSize(60),
                            height: getSize(60),
                            child: pw.Image(
                              pw.MemoryImage(logoImage.buffer.asUint8List()),
                            )),
                        paddingBetweenFilled(width: getSize(20)),
                        pw.Column(
                            mainAxisSize: pw.MainAxisSize.min,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                statement.company_name ?? "",
                                style: pw.TextStyle(
                                  fontBold: regularFont,
                                  fontSize: getFontSize(14),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                industry.title ?? "",
                                style: pw.TextStyle(
                                  fontNormal: regularFont,
                                  fontSize: getFontSize(10),
                                ),
                              ),
                            ]),
                      ],
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.only(top: getSize(10)),
                      child: pw.Divider(color: PdfColor.fromInt(0xFFD9D9D9)),
                    ),
                    titleWidget(
                      StringConstant.statementDetails,
                      otherValue: "$startDate to $endDate",
                      bgColor: PdfColors.green100,
                    ),
                    ...chunkedData.map((chunk) {
                      return pw.Wrap(
                        alignment: pw.WrapAlignment.start,
                        crossAxisAlignment: pw.WrapCrossAlignment.start,
                        children: [
                          ...chunk.map((item) {
                            return pw.Column(
                                mainAxisSize: pw.MainAxisSize.min,
                                children: [
                                  statementBox(item),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.symmetric(
                                        vertical: getSize(5)),
                                    child: pw.Divider(
                                        color: PdfColor.fromInt(0xFFD9D9D9)),
                                  ),
                                ]);
                          }),
                        ],
                      );
                    }),
                    /*  pw.ListView.separated(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return statementBox();
                      },
                      separatorBuilder: (context, index) {
                        return pw.Padding(
                          padding:
                              pw.EdgeInsets.symmetric(vertical: getSize(5)),
                          child:
                              pw.Divider(color: PdfColor.fromInt(0xFFD9D9D9)),
                        );
                      },
                    ),
                     */
                    statementTotal(statement),
                  ],
                ),
              ]),
    );

    return pdf.save();
  }

  pw.Container statementBox(MonthlyStatementDetailDTO item) {
    return pw.Container(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
              title: "${StringConstant.dateOfTransaction} :",
              value: (item.date_of_transaction != null)
                  ? DateFormat('dd MMM yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          item.date_of_transaction! * 1000))
                  : ""),
          detailWidget(
              title: "${StringConstant.contractorName} :",
              value:
                  "${item.contractor_first_name ?? ""} ${item.contractor_last_name ?? ""}"),
          if (item.type == 2)
            detailWidget(
                title: "${StringConstant.shiftCancellationFee} :",
                value: "\$${item.shiftfinder_service_fee}",
                valueColor: PdfColors.redAccent),
          detailWidget(
            title: "${StringConstant.shiftFinderServiceFee} :",
            value: "\$${item.shiftfinder_service_fee}",
          ),
          detailWidget(
              title: "${StringConstant.wage} :",
              value: "\$${item.total_wage}",
              valueColor: PdfColors.green),
        ],
      ),
    );
  }

  pw.Container statementTotal(MonthlyStatementDTO statement) {
    return pw.Container(
      margin: pw.EdgeInsets.symmetric(vertical: getSize(10)),
      padding: pw.EdgeInsets.symmetric(
          horizontal: getSize(10), vertical: getSize(10)),
      decoration: pw.BoxDecoration(
          color: PdfColors.grey200,
          borderRadius: pw.BorderRadius.circular(
            getSize(5),
          )),
      alignment: pw.Alignment.centerLeft,
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
            title: StringConstant.totalWage,
            value: "\$${statement.total_wage ?? ""}",
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
          detailWidget(
            title: StringConstant.totalShiftFinderServiceFee,
            value: "\$${statement.total_service_fee ?? ""}",
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
          detailWidget(
            title: StringConstant.totalShiftCancellationFee,
            value: "\$${statement.total_cancellation_fee ?? ""}",
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(
                vertical: getSize(10), horizontal: getSize(10)),
            child: pw.Divider(color: PdfColor.fromInt(0xFFD9D9D9)),
          ),
          detailWidget(
            title: StringConstant.netAmount,
            value: "\$${statement.net_amount ?? ""}",
            valueColor: PdfColors.green,
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
        ],
      ),
    );
  }

  pw.Container titleWidget(String title,
      {PdfColor? bgColor, String? otherValue}) {
    return pw.Container(
      margin: pw.EdgeInsets.symmetric(vertical: getSize(10)),
      padding: pw.EdgeInsets.symmetric(
          horizontal: getSize(20), vertical: getSize(10)),
      decoration: pw.BoxDecoration(
          color: bgColor ?? PdfColors.grey200,
          borderRadius: pw.BorderRadius.circular(
            getSize(5),
          )),
      alignment: pw.Alignment.centerLeft,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title,
              style: pw.TextStyle(
                fontSize: getFontSize(12),
                fontWeight: pw.FontWeight.bold,
              )),
          if (otherValue != null && otherValue.isNotEmpty)
            pw.Text(otherValue,
                style: pw.TextStyle(
                  fontSize: getFontSize(12),
                )),
        ],
      ),
    );
  }

  pw.Padding detailWidget({
    required String title,
    required String value,
    PdfColor? valueColor,
    pw.Alignment? alignment,
    double? fontSize,
  }) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(
          horizontal: getSize(20), vertical: getSize(2)),
      child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Flexible(
              flex: 10,
              child: pw.Text(title,
                  style: pw.TextStyle(
                    fontSize: fontSize ?? getFontSize(10),
                  )),
            ),
            pw.Flexible(
                flex: 13,
                child: pw.Align(
                  alignment: alignment ?? pw.Alignment.centerLeft,
                  child: pw.Text(value,
                      style: pw.TextStyle(
                        fontSize: fontSize ?? getFontSize(10),
                        fontWeight: pw.FontWeight.bold,
                        color: valueColor,
                      )),
                )),
          ]),
    );
  }
}
