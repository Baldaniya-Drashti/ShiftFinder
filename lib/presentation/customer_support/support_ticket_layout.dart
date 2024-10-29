import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class SupportTicketFormLayout extends StatelessWidget {
  const SupportTicketFormLayout({
    super.key,
    required this.children,
    required this.title,
  });

  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          BaseText(text: title, textColor: AppColors.green, fontSize: 16, fontWeight: FontWeight.w500),
          Gap(12),
        Material(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: List.generate(
                children.length * 2 - 1,
                (initialIndex) {
                  final index = initialIndex ~/ 2;
                  if (initialIndex.isEven) return children[index];
                  return Gap(16);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
