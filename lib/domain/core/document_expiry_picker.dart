// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class DocumentExpiryDatePicker {
  static Widget expiryDateTextField(
    BuildContext context, {
    required String selectedDate,
    DateTime? lastDate,
    required void Function(DateTime) onPickedDate,
    required void Function() onCancelClick,
    bool isDisabled = false,
    String? labelText,
    String? hintText,
    TextStyle? labelStyle,
  }) {
    return CustomTextField(
      labelText: labelText ?? StringConstant.expiryDate,
      labelStyle: (!isDisabled)
          ? TextStyle(
              fontSize: getFontSize(14),
              color: AppColors.black.withOpacity(0.3))
          : labelStyle ?? null,
      fillColor: (!isDisabled) ? AppColors.grey04 : null,
      isLabelPadding: true,
      readOnly: true,
      hintText: (selectedDate.isNotEmpty)
          ? DateFormat('d MMM, yyyy').format(DateTime.parse(selectedDate))
          : hintText ?? StringConstant.expiryDate,
      hintAsValue: (selectedDate.isNotEmpty) ? true : false,
      onTap: (!isDisabled)
          ? null
          : () {
              customDatePicker(
                context,
                firstDate: DateTime.now(),
                lastDate: lastDate,
                onPickedDate: onPickedDate,
                onCancelClick: onCancelClick,
                selectedDate: (selectedDate.isNotEmpty)
                    ? DateTime.parse(selectedDate)
                    : DateTime.now(),
              );
            },
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.calendar,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
    );
  }

  static Future<void> customDatePicker(
    BuildContext context, {
    required void Function(DateTime) onPickedDate,
    required void Function() onCancelClick,
    required DateTime? selectedDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate ?? DateTime(1950, 1),
      lastDate: lastDate ?? DateTime(2100, 1),
      initialDate: selectedDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      onPickedDate(pickedDate);
    } else {
      onCancelClick();
    }
  }

  Widget notApplicableExpiryCheckBox(
    BuildContext context, {
    required void Function(bool?) onChanged,
    bool isDisabled = false,
    required bool value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(5)),
      child: Container(
        height: getSize(46),
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          vertical: getSize(10),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
        ),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity((isDisabled) ? 0.2 : 0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              // color: Colors.green,
              child: Checkbox(
                value: value,
                activeColor: AppColors.primaryColor,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (isDisabled)
                    ? null
                    : (value) {
                        onChanged(value);
                      },
              ),
            ),
            SizedBox(
              width: getSize(20),
            ),
            Flexible(
              child: BaseText(
                text: StringConstant.expiryDateIsNotApplicable,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textColor:
                    (isDisabled) ? AppColors.black.withOpacity(0.5) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
