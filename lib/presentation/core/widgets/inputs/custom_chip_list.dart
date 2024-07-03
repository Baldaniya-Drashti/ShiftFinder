import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

// ignore: must_be_immutable
class CustomChipSet extends StatelessWidget {
  List<String> chipList;
  void Function(String value) onDelete;
  CustomChipSet({super.key, required this.onDelete, required this.chipList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: getSize(10),
      runSpacing: getSize(0),
      children: chipList.map((String option) {
        return Chip(
          deleteIcon: Icon(
            Icons.close,
            size: getSize(18),
          ),
          backgroundColor: AppColors.scaffoldColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          label: BaseText(
            text: option,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          onDeleted: () {
            onDelete.call(option);
          },
          // () {
          //   setState(() {
          //     _selectedOptions.remove(option);
          //   });
          // },
        );
      }).toList(),
    );
  }
}
