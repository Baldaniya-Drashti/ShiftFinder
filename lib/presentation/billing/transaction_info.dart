import 'package:flutter/material.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class TransactionInfo extends StatelessWidget {
  const TransactionInfo({super.key, required this.label, required this.value});

  final String label;
  final String value;

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
            child: BaseText(text: value, fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
