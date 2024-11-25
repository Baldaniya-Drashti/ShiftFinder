import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/core/chat/message_response.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class MessageTile extends StatelessWidget {
  final MessageData message;
  final bool isSender;
  const MessageTile({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(15),
                vertical: getSize(11),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.5,
              ),
              decoration: BoxDecoration(
                color: isSender
                    ? AppColors.primaryColor
                    : AppColors.grey2.withOpacity(0.10),
                borderRadius: BorderRadius.circular(
                  getSize(10),
                ),
              ),
              child: BaseText(
                text: message.message ?? '',
                maxLines: 50,
                fontSize: 12,
                textColor: isSender ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
