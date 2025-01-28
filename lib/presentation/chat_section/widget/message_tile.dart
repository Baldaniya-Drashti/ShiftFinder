import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/core/chat/message_response.dart';
import 'package:shift/presentation/chat_section/widget/message_document.dart';
import 'package:shift/presentation/chat_section/widget/message_image.dart';
import 'package:shift/presentation/chat_section/widget/message_video.dart';
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
                horizontal: getSize(message.type == 1 ? 15 : 5),
                vertical: getSize(message.type == 1 ? 11 : 5),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.5,
              ),
              decoration: message.type == 1
                  ? BoxDecoration(
                      color: isSender
                          ? AppColors.primaryColor
                          : AppColors.grey2.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(
                        getSize(10),
                      ),
                      border: Border.all(
                        color: isSender
                            ? AppColors.primaryColor
                            : AppColors.grey2.withOpacity(0.10),
                        width: getSize(2),
                      ),
                    )
                  : null,
              child: message.type == 1
                  ? BaseText(
                      text: message.message ?? '',
                      maxLines: 50,
                      fontSize: 12,
                      textColor: isSender ? AppColors.white : AppColors.black,
                      fontWeight: FontWeight.w500,
                    )
                  : message.type == 2
                      ? MessageImage(
                          imageUrl: message.message ?? '',
                          isSender: isSender,
                        )
                      : message.type == 3
                          ? MessageVideo(
                              videoThumbnail: message.thumbnail ?? '',
                              isSender: isSender,
                              videoUrl: message.message ?? '',
                            )
                          : message.type == 4
                              ? MessageDocument(
                                  documentName: message.mediaName ?? '',
                                  isSender: isSender,
                                  documentUrl: message.message ?? '',
                                )
                              : BaseText(text: 'File'),
            ),
          ],
        ),
      ],
    );
  }
}
