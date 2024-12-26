import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class TransactionInfo extends StatelessWidget {
  const TransactionInfo({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueFontSize,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final double? valueFontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getSize(6)).copyWith(left: getSize(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: BaseText(
              text: "$label :",
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: getSize(10)),
          Expanded(
            flex: 13,
            child: BaseText(
              text: value,
              fontSize: valueFontSize ?? 10,
              fontWeight: FontWeight.w600,
              textColor: valueColor,
              // maxLines: 1,overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class MonthlyStatementInfo extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool showSign;
  const MonthlyStatementInfo(
      {super.key,
      required this.label,
      this.showSign = true,
      required this.value,
      this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getSize(6)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: BaseText(
                text: showSign ? "$label :" : label,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: BaseText(
              text: value,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textColor: valueColor,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
