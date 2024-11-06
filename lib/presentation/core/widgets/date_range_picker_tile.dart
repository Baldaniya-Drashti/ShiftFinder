import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class DateRangePickerTile extends StatelessWidget {
  const DateRangePickerTile({
    super.key,
    this.selectedDate = const [],
    required this.onDateSelected, required this.label,
  });

  final List<DateTime> selectedDate;
  final void Function(List<DateTime> value) onDateSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    final label = selectedDate.isEmpty ? StringConstant.chooseDateRange : getFormattedString(selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: BaseText(text: this.label,fontSize: 10),
        ),
        Gap(8),
        Material(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.black, width: 0.5),
            borderRadius: BorderRadius.circular(7),
          ),
          child: InkWell(
            onTap: () => pickMultiDateDialog(
              context,
              onDateSelected: onDateSelected,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  SvgPicture.asset(SvgImageConstant.calendar, height: 20, width: 20),
                  Gap(8),
                  Expanded(child: BaseText(text: label, fontSize: 12, fontWeight: FontWeight.w600)),
                  SvgPicture.asset(SvgImageConstant.rightArrow, height: 15, width: 15),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String getFormattedString(List<DateTime> dates) {
  if (dates.isEmpty) return "";
  final firstDate = dates.first;
  final lastDate = dates.last;

  final formattedDate = "${DateFormat("dd MMM").format(firstDate)} to ${DateFormat("dd MMM").format(lastDate)}, ${lastDate.year}";
  return formattedDate;
}
