import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/file_picker_utils.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class AttachmentOption extends StatelessWidget {
  const AttachmentOption({
    super.key,
    required this.onSelected,
    this.path,
    required this.onRemove,
  });

  final Function(String path) onSelected;
  final VoidCallback onRemove;
  final String? path;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (path != null) {
      child = ShowPickedFile(selectedFile: path, onDelete: onRemove);
    } else {
      child = InkWell(
        onTap: () => _onSelected(context),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(PngImageConstants.upload, height: 60),
              Gap(30),
              Material(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryColor.withValues(alpha: 0.15),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 34),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(SvgImageConstant.upload),
                      Gap(10),
                      BaseText(
                        text: StringConstant.upload,
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        child: child,
      ),
    );
  }

  void _onSelected(BuildContext context) {
    final imagePicker = ImagePickerUtils();
    final filePicker = FilePickerUtils();

    ImageChooserDialog().showImageChooserDialog(
      takePhotoCallback: () async {
        final path = await imagePicker.pickImage(
            imageSource: ImageSource.camera, context: context);
        if (path != null) onSelected(path);
      },
      selectPhotoCallback: () async {
        final path = await imagePicker.pickImage(
            imageSource: ImageSource.gallery, context: context);
        if (path != null) onSelected(path);
      },
      selectPdfCallback: () async {
        final path = await filePicker.pickPdf(context: context);
        if (path != null) onSelected(path);
      },
      context: context,
    );
  }
}
