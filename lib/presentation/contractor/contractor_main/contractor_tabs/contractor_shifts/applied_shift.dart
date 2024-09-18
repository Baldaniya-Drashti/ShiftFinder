import 'package:flutter/material.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class AppliedShift extends StatelessWidget {
  const AppliedShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseText(
        text: StringConstant.underDevelopment,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
