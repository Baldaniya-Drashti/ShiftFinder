// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class NoDataText extends StatelessWidget {
  String title;
  String? description;
  String? image;
  NoDataText({super.key, this.image, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSize(280),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null) ...[
            SvgPicture.asset(image!),
            SizedBox(
              height: getSize(30),
            ),
          ],
          BaseText(
            text: title,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: "Aclonica",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getSize(5),
          ),
          BaseText(
            text: description ?? "",
            textAlign: TextAlign.center,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
