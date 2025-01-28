// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class ImageChooserDialog {
  showImageChooserDialog({
    required VoidCallback takePhotoCallback,
    required VoidCallback selectPhotoCallback,
    VoidCallback? selectVideoCallback,
    VoidCallback? selectPdfCallback,
    required BuildContext context,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              AppFocus.unfocus(context);
              takePhotoCallback.call();
            },
            child: BaseText(
              text: StringConstant.takePhoto,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              AppFocus.unfocus(context);
              selectPhotoCallback.call();
            },
            child: BaseText(
              text: StringConstant.galleryPhoto,
            ),
          ),
          if (selectVideoCallback != null)
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                AppFocus.unfocus(context);
                selectVideoCallback.call();
              },
              child: BaseText(
                text: StringConstant.galleryVideo,
              ),
            ),
          if (selectPdfCallback != null)
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                AppFocus.unfocus(context);
                selectPdfCallback.call();
              },
              child: BaseText(
                text: StringConstant.chooseFile,
              ),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: BaseText(
            text: StringConstant.cancle,
            fontSize: 18,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
