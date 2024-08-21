import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/contractor_main/earning/statement_dto/statement_dto.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/contractor_earning/contractor_statement_view.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';

class GenerateContractorStatement extends StatelessWidget {
  const GenerateContractorStatement({super.key});
  final int maxRecordLength = 3;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<Uint8List> completeEarningStatement(
      {required List<DateTime> selectedDates,
      required StatementDTO statement,
      required StatementFilterModel currentStatement}) async {
    final pdf = pw.Document();

    final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/RobotoFlex-Regular.ttf'),
    );

    pdf.addPage(
      index: 0,
      pw.MultiPage(
          build: (pw.Context context) => [
                pw.Wrap(
                  alignment: pw.WrapAlignment.start,
                  crossAxisAlignment: pw.WrapCrossAlignment.start,
                  children: [
                    pw.Column(
                        mainAxisSize: pw.MainAxisSize.min,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            StringConstant.shiftFinder,
                            style: pw.TextStyle(
                              fontBold: regularFont,
                              fontSize: getFontSize(12),
                            ),
                          ),
                          pw.SizedBox(height: getSize(5)),
                          pw.Text(
                            StringConstant.totalEarningStatement,
                            style: pw.TextStyle(
                              fontNormal: regularFont,
                              fontSize: getFontSize(10),
                            ),
                          ),
                          pw.SizedBox(height: getSize(10)),
                          pw.Text(
                            "${getCurrentUser().firstName ?? ""} ${getCurrentUser().lastName ?? ""}",
                            style: pw.TextStyle(
                              fontBold: regularFont,
                              fontSize: getFontSize(10),
                            ),
                          ),
                          pw.SizedBox(height: getSize(5)),
                          pw.Row(children: [
                            pw.Text(
                              StringConstant.statementPeriod,
                              style: pw.TextStyle(
                                fontBold: regularFont,
                                fontSize: getFontSize(10),
                              ),
                            ),
                            paddingBetweenFilled(width: getSize(5)),
                            pw.Text(
                              getFormattedString(selectedDates),
                              style: pw.TextStyle(
                                fontBold: regularFont,
                                fontSize: getFontSize(10),
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ]),
                        ]),
                    commonDivider(),
                    switch (currentStatement.id) {
                      1 => earning(statement: statement),
                      2 => compensation(statement: statement),
                      3 => refereBonus(statement: statement),
                      4 => bankBonus(statement: statement),
                      _ => earning(statement: statement),
                    },
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

  pw.Widget earning({required StatementDTO statement}) {
    List<StatementDetailDTO> data = statement.list ?? [];

    List<List<StatementDetailDTO>> earningList = [];

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
                    earningBox(item),
                    commonDivider(),
                  ],
                );
              }),
            ],
          );
        }),
        paddingBetweenFilled(),
        titleWidget(
          StringConstant.netEarnings,
          otherValue:
              "\$${statement.additional_data?.completed_total_earnings?.toStringAsFixed(2) ?? 0.0}",
          bgColor: PdfColors.green100,
        ),
      ],
    );
  }

  pw.Widget compensation({required StatementDTO statement}) {
    List<StatementDetailDTO> data = statement.list ?? [];

    List<List<StatementDetailDTO>> compensationList = [];

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
                    compensationBox(item),
                    commonDivider(),
                  ],
                );
              }),
            ],
          );
        }),
        paddingBetweenFilled(),
        titleWidget(
          StringConstant.totalCancellationFee,
          otherValue:
              "\$${statement.additional_data?.total_cancellation_fee?.toStringAsFixed(2) ?? 0.0}",
          bgColor: PdfColors.green100,
        ),
      ],
    );
  }

  pw.Widget refereBonus({required StatementDTO statement}) {
    List<StatementDetailDTO> data = statement.list ?? [];

    List<List<StatementDetailDTO>> bonusList = [];

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
          StringConstant.compensationReceivedFromCancellations,
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
                    bonusBox(item),
                    commonDivider(),
                  ],
                );
              }),
            ],
          );
        }),
        paddingBetweenFilled(),
        titleWidget(
          StringConstant.totalBonus,
          otherValue: "\$${statement.additional_data?.total_bonus ?? 0.0}",
          bgColor: PdfColors.green100,
        ),
      ],
    );
  }

  pw.Widget bankBonus({required StatementDTO statement}) {
    List<StatementDetailDTO> data = statement.list ?? [];

    List<List<StatementDetailDTO>> bankList = [];

    for (int i = 0; i < data.length; i += maxRecordLength) {
      bankList.add(data.sublist(
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
        ...bankList.map((bonus) {
          return pw.Wrap(
            alignment: pw.WrapAlignment.start,
            crossAxisAlignment: pw.WrapCrossAlignment.start,
            children: [
              ...bonus.map((item) {
                return pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    bankBonusBox(item),
                    commonDivider(),
                  ],
                );
              }),
            ],
          );
        }),
        paddingBetweenFilled(),
        titleWidget(
          StringConstant.totalBonus,
          otherValue: "\$${statement.additional_data?.total_withdraw ?? 0.0}",
          bgColor: PdfColors.green100,
        ),
      ],
    );
  }

  pw.Widget commonDivider() {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: getSize(5)),
      child: pw.Divider(color: PdfColor.fromInt(0xFFD9D9D9)),
    );
  }

  pw.Container earningBox(StatementDetailDTO earning) {
    return pw.Container(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
              title: "${StringConstant.date} :",
              value: DateFormat('dd MMM yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(earning.date! * 1000))),
          detailWidget(
              title: "${StringConstant.companyName} :",
              value: earning.company_name ?? ""),
          detailWidget(
              title: "${StringConstant.location} :",
              value: earning.location?.location ?? ""),
          detailWidget(
              title: "${StringConstant.hourWorked} :",
              value: earning.hours_worked ?? ""),
          detailWidget(
              title: "${StringConstant.hourlyRate} :",
              value: "\$${earning.hourly_rate?.toStringAsFixed(2) ?? 0.0}"),
          detailWidget(
              title: "${StringConstant.wages} :",
              value: "\$${earning.total_wage?.toStringAsFixed(2) ?? 0.0}"),
          detailWidget(
              title: "${StringConstant.allowances} :",
              value: "\$${earning.total_allowance?.toStringAsFixed(2) ?? 0.0}"),
          detailWidget(
            title: "${StringConstant.earnings} :",
            value: "\$${earning.total_earnings?.toStringAsFixed(2) ?? 0.0}",
            valueColor: PdfColors.green,
          ),
        ],
      ),
    );
  }

  pw.Container compensationBox(StatementDetailDTO earning) {
    return pw.Container(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
              title: "${StringConstant.date} :",
              value: DateFormat('dd MMM yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(earning.date! * 1000))),
          detailWidget(
              title: "${StringConstant.companyName} :",
              value: earning.company_name ?? ""),
          detailWidget(
              title: "${StringConstant.location} :",
              value: earning.location?.location ?? ""),
          detailWidget(
            title: "${StringConstant.compensationFee} :",
            value: "\$${earning.amount?.toStringAsFixed(2) ?? 0.0}",
            valueColor: PdfColors.green,
          ),
        ],
      ),
    );
  }

  pw.Container bonusBox(StatementDetailDTO earning) {
    return pw.Container(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
              title: "${StringConstant.date} :",
              value: DateFormat('dd MMM yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(earning.date! * 1000))),
          detailWidget(
              title: "${StringConstant.referredContractorName} :",
              value: earning.referred_contractor_name ?? ""),
          detailWidget(
            title: "${StringConstant.bonusAmount} :",
            value: "\$${earning.amount?.toStringAsFixed(2) ?? 0.0}",
            valueColor: PdfColors.green,
          ),
        ],
      ),
    );
  }

  pw.Container bankBonusBox(StatementDetailDTO earning) {
    return pw.Container(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          detailWidget(
              title: "${StringConstant.date} :",
              value: DateFormat('dd MMM yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(earning.date! * 1000))),
          detailWidget(
            title: "${StringConstant.depositAmount} :",
            value: "\$${earning.amount?.toStringAsFixed(2) ?? 0.0}",
            valueColor: PdfColors.green,
          ),
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
