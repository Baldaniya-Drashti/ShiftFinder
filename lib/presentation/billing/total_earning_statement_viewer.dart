import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/contractor_main/earning/earning_statement_dto/earning_statement_dto.dart';
import 'package:shift/infrastructure/core/monthly_statement_dto/monthly_statement_dto.dart';

class GenerateTotalEarningStatement extends StatelessWidget {
  const GenerateTotalEarningStatement({super.key});
  final int maxRecordLength = 3;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<Uint8List> totalEarningStatement(
      {required List<DateTime> selectedDates,
      required EarningStatementDTO statement}) async {
    final pdf = pw.Document();

    final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/RobotoFlex-Regular.ttf'),
    );

    final logoImage = await rootBundle.load('assets/png/splash_logo.png');

    // final startDate = DateFormat('dd MMM').format(selectedDates.first);
    // final endDate = DateFormat('dd MMM, yyyy').format(selectedDates.last);

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
                                "ShiftFinder",
                                style: pw.TextStyle(
                                  fontBold: regularFont,
                                  fontSize: getFontSize(12),
                                ),
                              ),
                              pw.SizedBox(height: getSize(5)),
                              pw.Text(
                                "Total Earning Statement",
                                style: pw.TextStyle(
                                  fontNormal: regularFont,
                                  fontSize: getFontSize(10),
                                ),
                              ),
                              pw.SizedBox(height: getSize(10)),
                              pw.Text(
                                "Contractor Name",
                                style: pw.TextStyle(
                                  fontBold: regularFont,
                                  fontSize: getFontSize(10),
                                ),
                              ),
                              pw.SizedBox(height: getSize(5)),
                              pw.Row(children: [
                                pw.Text(
                                  "Statement Period ",
                                  style: pw.TextStyle(
                                    fontBold: regularFont,
                                    fontSize: getFontSize(10),
                                  ),
                                ),
                                paddingBetweenFilled(width: getSize(5)),
                                pw.Text(
                                  "2 Apr to 2 May 2024",
                                  style: pw.TextStyle(
                                    fontBold: regularFont,
                                    fontSize: getFontSize(10),
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ]),
                            ]),
                      ],
                    ),
                    commonDivider(),
                    earning(statement),
                    compensation(statement),
                    refereBonus(statement),
                    statementTotal(statement),
                    titleWidget(
                      StringConstant.netEarnings,
                      otherValue: "\$1070.00",
                      bgColor: PdfColors.green100,
                    ),
                    detailWidget(
                        title: StringConstant.shiftFinderInc, value: ""),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(
                          horizontal: getSize(20), vertical: getSize(2)),
                      child: pw.Container(
                          width: getSize(40),
                          height: getSize(40),
                          child: pw.Image(
                            pw.MemoryImage(logoImage.buffer.asUint8List()),
                          )),
                    ),
                    detailWidget(
                        title: StringConstant.contactInformation,
                        value: "",
                        fontSize: 12),
                    paddingBetweenFilled(),
                    detailWidget(
                      title: "${StringConstant.email} : ",
                      value: "debra.holt@example.com",
                      isFooter: true,
                    ),
                    detailWidget(
                      title: "${StringConstant.phoneNumber} : ",
                      value: "6325148452",
                      isFooter: true,
                    ),
                    detailWidget(
                      title: "${StringConstant.website} : ",
                      value: StringConstant.shiftFinderWebsite,
                      isFooter: true,
                    ),
                  ],
                ),
              ]),
    );

    return pdf.save();
  }

  pw.SizedBox paddingBetweenFilled({double? height, double? width}) {
    return (width != null)
        ? pw.SizedBox(width: getSize(width))
        : pw.SizedBox(height: getSize(height ?? 10));
  }

  pw.Widget earning(EarningStatementDTO statement) {
    List<MonthlyStatementDetailDTO> data = [];

    List<List<MonthlyStatementDetailDTO>> earningList = [];

    for (int i = 0; i < data.length; i += maxRecordLength) {
      earningList.add(data.sublist(
          i,
          i + maxRecordLength > data.length
              ? data.length
              : i + maxRecordLength));
    }

    return pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        titleWidget(
          StringConstant.completedShiftsEarning,
          bgColor: PdfColors.green100,
        ),
        ...earningList.map((earning) {
          return pw.Wrap(
            alignment: pw.WrapAlignment.start,
            crossAxisAlignment: pw.WrapCrossAlignment.start,
            children: [
              ...earning.map((item) {
                return pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    earningBox(),
                    commonDivider(),
                  ],
                );
              }),
            ],
          );
        }),
        paddingBetweenFilled(),
        pw.Container(
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
                value: "\$650.00",
                alignment: pw.Alignment.centerRight,
                fontSize: getFontSize(12),
              ),
              detailWidget(
                title: StringConstant.totalAllowance,
                value: "\$100.00",
                alignment: pw.Alignment.centerRight,
                fontSize: getFontSize(12),
              ),
              commonDivider(),
              detailWidget(
                title: StringConstant.totalEarnings,
                value: "\$750.00",
                valueColor: PdfColors.green,
                alignment: pw.Alignment.centerRight,
                fontSize: getFontSize(12),
              ),
            ],
          ),
        )
      ],
    );
  }

  pw.Widget compensation(EarningStatementDTO statement) {
    List<MonthlyStatementDetailDTO> data = [];

    List<List<MonthlyStatementDetailDTO>> compensationList = [];

    for (int i = 0; i < data.length; i += maxRecordLength) {
      compensationList.add(data.sublist(
          i,
          i + maxRecordLength > data.length
              ? data.length
              : i + maxRecordLength));
    }

    return pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        titleWidget(
          StringConstant.compensationReceivedFromCancellations,
          bgColor: PdfColors.green100,
        ),
        ...compensationList.map((compensation) {
          return pw.Wrap(
            alignment: pw.WrapAlignment.start,
            crossAxisAlignment: pw.WrapCrossAlignment.start,
            children: [
              ...compensation.map((item) {
                return pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    compensationBox(),
                    commonDivider(),
                  ],
                );
              }),
            ],
          );
        }),
        paddingBetweenFilled(),
        pw.Container(
          margin: pw.EdgeInsets.symmetric(vertical: getSize(10)),
          padding: pw.EdgeInsets.symmetric(
              horizontal: getSize(10), vertical: getSize(10)),
          decoration: pw.BoxDecoration(
              color: PdfColors.grey200,
              borderRadius: pw.BorderRadius.circular(
                getSize(5),
              )),
          alignment: pw.Alignment.centerLeft,
          child: detailWidget(
            title: StringConstant.totalCancellationFee,
            value: "\$220.00",
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
        )
      ],
    );
  }

  pw.Widget refereBonus(EarningStatementDTO statement) {
    List<MonthlyStatementDetailDTO> data = [];

    List<List<MonthlyStatementDetailDTO>> bonusList = [];

    for (int i = 0; i < data.length; i += maxRecordLength) {
      bonusList.add(data.sublist(
          i,
          i + maxRecordLength > data.length
              ? data.length
              : i + maxRecordLength));
    }

    return pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        titleWidget(
          StringConstant.referralBonusReceived,
          bgColor: PdfColors.green100,
        ),
        ...bonusList.map((bonus) {
          return pw.Wrap(
            alignment: pw.WrapAlignment.start,
            crossAxisAlignment: pw.WrapCrossAlignment.start,
            children: [
              ...bonus.map((item) {
                return pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    bonusBox(),
                    commonDivider(),
                  ],
                );
              }),
            ],
          );
        }),
        paddingBetweenFilled(),
        pw.Container(
          margin: pw.EdgeInsets.symmetric(vertical: getSize(10)),
          padding: pw.EdgeInsets.symmetric(
              horizontal: getSize(10), vertical: getSize(10)),
          decoration: pw.BoxDecoration(
              color: PdfColors.grey200,
              borderRadius: pw.BorderRadius.circular(
                getSize(5),
              )),
          alignment: pw.Alignment.centerLeft,
          child: detailWidget(
            title: StringConstant.totalBonus,
            value: "\$100.00",
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
        )
      ],
    );
  }

  pw.Widget commonDivider() {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: getSize(5)),
      child: pw.Divider(color: PdfColor.fromInt(0xFFD9D9D9)),
    );
  }

  pw.Container earningBox() {
    return pw.Container(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
              title: "${StringConstant.date} :", value: "12 May, 2024"),
          detailWidget(
              title: "${StringConstant.companyName} :",
              value: "Louis Vuitton Pvt. Ltd."),
          detailWidget(
            title: "${StringConstant.location} :",
            value: "6391 Elgin St. Celina, Delaware",
          ),
          detailWidget(
            title: "${StringConstant.hourWorked} :",
            value: "9 h 30 min",
          ),
          detailWidget(
            title: "${StringConstant.hourlyRate} :",
            value: "\$30",
          ),
          detailWidget(
            title: "${StringConstant.wages} :",
            value: "\$285.00",
          ),
          detailWidget(
            title: "${StringConstant.allowances} :",
            value: "\$50",
          ),
          detailWidget(
            title: "${StringConstant.earnings} :",
            value: "\$335.00",
          ),
        ],
      ),
    );
  }

  pw.Container compensationBox() {
    return pw.Container(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
              title: "${StringConstant.date} :", value: "12 May, 2024"),
          detailWidget(
              title: "${StringConstant.companyName} :",
              value: "Louis Vuitton Pvt. Ltd."),
          detailWidget(
              title: "${StringConstant.location} :",
              value: "6391 Elgin St. Celina, Delaware"),
          detailWidget(
            title: "${StringConstant.cancellationFee} :",
            value: "\$120.00",
            valueColor: PdfColors.green,
          ),
        ],
      ),
    );
  }

  pw.Container bonusBox() {
    return pw.Container(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
              title: "${StringConstant.date} :", value: "12 May, 2024"),
          detailWidget(
              title: "${StringConstant.referredContractorName} :",
              value: "David Malpas"),
          detailWidget(
              title: "${StringConstant.bonusAmount} :", value: "\$50.00"),
        ],
      ),
    );
  }

  pw.Container statementTotal(EarningStatementDTO statement) {
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
            title: StringConstant.totalCompletedShiftEarnings,
            value: "\$750.00",
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
          detailWidget(
            title: StringConstant.totalCompensationReceived,
            value: "\$220.00",
            alignment: pw.Alignment.centerRight,
            fontSize: getFontSize(12),
          ),
          detailWidget(
            title: StringConstant.totalReferralBonusReceived,
            value: "\$100.00",
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
              )),
          if (otherValue != null && otherValue.isNotEmpty)
            pw.Text(otherValue,
                style: pw.TextStyle(
                  fontSize: getFontSize(12),
                  fontWeight: pw.FontWeight.bold,
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
    bool? isFooter,
  }) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(
          horizontal: getSize(20), vertical: getSize(2)),
      child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Flexible(
              flex: (isFooter == true) ? 0 : 1,
              child: pw.Text(title,
                  style: pw.TextStyle(
                    fontSize: fontSize ?? getFontSize(10),
                  )),
            ),
            pw.Flexible(
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
