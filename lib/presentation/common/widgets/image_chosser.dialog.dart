// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class ImageChooserDialog {
  showImageChooserDialog({
    required VoidCallback takePhotoCallback,
    required VoidCallback selectPhotoCallback,
    required BuildContext context,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: takePhotoCallback,
            child: BaseText(
              text: StringConstant.takePhoto,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: selectPhotoCallback,
            child: BaseText(
              text: StringConstant.galleryPhoto,
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
