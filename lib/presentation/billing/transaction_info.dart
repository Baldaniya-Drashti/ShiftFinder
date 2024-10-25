import 'package:flutter/material.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class TransactionInfo extends StatelessWidget {
  const TransactionInfo({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BaseText(text: "$label :", fontSize: 10, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: BaseText(
              text: value,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              textColor: valueColor,
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
  const MonthlyStatementInfo({super.key, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2,
            child: BaseText(text: "$label :", fontSize: 12, fontWeight: FontWeight.w500),
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
