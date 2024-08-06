// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/widgets.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class SinglePostShift extends StatelessWidget {
  const SinglePostShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: BaseText(
            text: "Single shift",
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
