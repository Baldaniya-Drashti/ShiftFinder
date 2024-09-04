import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class RevokingView extends StatelessWidget {
  const RevokingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getSize(30),
        ),
        Expanded(
          child: BaseText(
            text: 'Revoking...',
            textColor: AppColors.black.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: getSize(3),
            horizontal: getSize(15),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(getSize(6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time_rounded,
                  color: AppColors.green, size: getSize(20)),
              SizedBox(width: getSize(2)),
              BaseText(
                text: '1 h 23 min',
                textColor: AppColors.green,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
