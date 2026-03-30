import 'package:flutter/material.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/chat_section/widget/chat_date_method.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class ShowDateWidget extends StatelessWidget {
  final int date;
  const ShowDateWidget({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseText(
        text: ChatDateMethod().isToday(
          CustomDateTimeFormat.timeStampToDateTime(
            date,
            isMillisecond: false,
          ),
        )
            ? StringConstant.today
            : ChatDateMethod().formatAsYesterday(
                CustomDateTimeFormat.timeStampToDateTime(
                  date,
                  isMillisecond: false,
                ),
              ),
        fontSize: 10,
        textColor: AppColors.primaryColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
