import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

// ignore: must_be_immutable
class CustomChipSet extends StatelessWidget {
  List<String> chipList;
  void Function(String value) onDelete;
  Color? backgroundColor;
  double? spacing;
  double? runSpacing;
  Widget? deleteIcon;
  BoxConstraints? deleteIconBoxConstraints;
  String? chipLabel;

  CustomChipSet({
    super.key,
    required this.onDelete,
    required this.chipList,
    this.backgroundColor,
    this.runSpacing,
    this.spacing,
    this.deleteIcon,
    this.deleteIconBoxConstraints,
    this.chipLabel,
  });

  @override
  Widget build(BuildContext context) {
    return (chipLabel != null)
        ? Wrap(
            spacing: getSize(spacing ?? 10),
            runSpacing: getSize(runSpacing ?? 0),
            children: [
              Chip(
                deleteIconBoxConstraints: deleteIconBoxConstraints,
                deleteIcon: deleteIcon ??
                    Icon(
                      Icons.close,
                      size: getSize(18),
                    ),
                backgroundColor: backgroundColor ?? AppColors.scaffoldColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: BaseText(
                  text: chipLabel ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                onDeleted: () {
                  onDelete.call(chipLabel!);
                },
              )
            ],
          )
        : Wrap(
            spacing: getSize(spacing ?? 10),
            runSpacing: getSize(runSpacing ?? 0),
            children: chipList.map((String option) {
              return Chip(
                deleteIconBoxConstraints: deleteIconBoxConstraints,
                deleteIcon: deleteIcon ??
                    Icon(
                      Icons.close,
                      size: getSize(18),
                    ),
                backgroundColor: backgroundColor ?? AppColors.scaffoldColor,
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
              );
            }).toList(),
          );
  }
}
