// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/widgets.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class MultiPostShift extends StatelessWidget {
  const MultiPostShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: BaseText(
            text: "Multi shift",
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
