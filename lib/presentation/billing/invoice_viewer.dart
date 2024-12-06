import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';

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
  Future<Uint8List> generateContractorCompleteShiftInvoice() async {
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

  Future<Uint8List> generateMonthlyStatement() async {
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

    List<int> data = [1, 2, 3];

    List<List<dynamic>> chunkedData = [];
    int chunkSize = 6;

    for (int i = 0; i < data.length; i += chunkSize) {
      chunkedData.add(data.sublist(
          i, i + chunkSize > data.length ? data.length : i + chunkSize));
    }
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
                                'Louis Vuitton Pvt. Ltd.',
                                style: pw.TextStyle(
                                  fontBold: regularFont,
                                  fontSize: getFontSize(14),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              paddingBetweenFilled(),
                              pw.Text(
                                'Healthcare',
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
                    titleWidget(StringConstant.statementDetails,
                        bgColor: PdfColors.green100),
                    ...chunkedData.map((chunk) {
                      return pw.Wrap(
                        alignment: pw.WrapAlignment.start,
                        crossAxisAlignment: pw.WrapCrossAlignment.start,
                        children: [
                          ...chunk.map((item) {
                            return pw.Column(
                                mainAxisSize: pw.MainAxisSize.min,
                                children: [
                                  statementBox(),
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
                    statementTotal(),
                  ],
                ),
              ]),
    );

    return pdf.save();
  }

  pw.Container statementBox() {
    return pw.Container(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
              title: "${StringConstant.dateOfTransaction} :",
              value: "12 July 2024"),
          detailWidget(
              title: "${StringConstant.contractorName} :",
              value: "Karen Adderiy"),
          detailWidget(
              title: "${StringConstant.shiftFinderServiceFee} :",
              value: "\$50",
              valueColor: PdfColors.red),
          detailWidget(
              title: "${StringConstant.wage} :",
              value: "\$300",
              valueColor: PdfColors.green),
        ],
      ),
    );
  }

  pw.Container statementTotal() {
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
            value: "\$1350.00",
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
          detailWidget(
            title: StringConstant.totalShiftFinderServiceFee,
            value: "\$1350.00",
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
          detailWidget(
            title: StringConstant.totalShiftCancellationFee,
            value: "\$50",
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
            value: "\$1400.00",
            valueColor: PdfColors.green,
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
        ],
      ),
    );
  }

  pw.Container titleWidget(String title, {PdfColor? bgColor}) {
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
