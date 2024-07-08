import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/common_styles.dart';

Widget commonErrorText(String errorText, {EdgeInsets? padding}) {
  return Padding(
    padding: padding ?? EdgeInsets.only(left: getSize(20), top: getSize(10)),
    child: BaseText(
      text: errorText,
      style: commonErrorStyle(),
    ),
  );
}
