// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class SelectedDocumentBox extends StatelessWidget {
  String? leadingImageString;
  Widget? leadingImage;
  String? pickedFile;
  String title;
  String? subTitle1;
  String? subTitle2;
  bool showDeleteButton;
  String? deleteDescription;
  VoidCallback? onCancelClick;
  VoidCallback? onDeleteClick;

  SelectedDocumentBox(
      {this.leadingImageString,
      this.leadingImage,
      this.pickedFile,
      required this.title,
      this.subTitle1,
      this.subTitle2,
      this.deleteDescription,
      this.onCancelClick,
      this.onDeleteClick,
      this.showDeleteButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListTile(
        tileColor: AppColors.grey.withOpacity(0.4),
        minTileHeight: getSize(103),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: (pickedFile != null)
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   height: getSize(60),
                  //   width: getSize(60),
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: getSize(11), vertical: getSize(6)),
                  //   decoration: const BoxDecoration(
                  //     color: AppColors.white,
                  //   ),
                  //   child: Container(
                  //     decoration: BoxDecoration(boxShadow: [
                  //       BoxShadow(
                  //           blurRadius: 5,
                  //           spreadRadius: 1,
                  //           color: Colors.black.withOpacity(0.2)),
                  //     ]),
                  //     child: leadingImage!,
                  //   ),
                  // ),
                  ShowPickedFile(
                    selectedFile: pickedFile,
                    showBadge: false,
                    isExpandedImage: false,
                    mainBoxHeight: getSize(60),
                    mainBoxWidth: getSize(50),
                    childBoxHeight: getSize(48),
                    childBoxWidth: getSize(38),
                    iconSize: getSize(20),
                  ),
                  SizedBox(
                    width: getSize(20),
                  ),
                  SvgPicture.asset(
                    SvgImageConstant.verticalLine,
                    width: getSize(59.56),
                    height: getSize(63),
                  )
                ],
              )
            : SvgPicture.asset(
                leadingImageString ?? SvgImageConstant.infoCircle,
                width: getSize(59.56),
                height: getSize(63),
                fit: BoxFit.fitHeight,
              ),
        title: boxTitleUI(
          subTitle1: subTitle1,
          subTitle2: subTitle2,
          title: title,
        ),
        trailing: (showDeleteButton)
            ? GestureDetector(
                onTap: () {
                  AppDialog.showDelete(
                    context,
                    title: StringConstant.delete,
                    infoMessage: deleteDescription ?? "",
                    onCancelClick: onCancelClick,
                    onDeleteClick: onDeleteClick,
                  );
                },
                child: SvgPicture.asset(SvgImageConstant.bin),
              )
            : null,
      ),
    );
  }

  Widget boxTitleUI({String? title, String? subTitle1, String? subTitle2}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseText(
          text: title ?? "",
          fontWeight: FontWeight.w600,
          fontSize: 14,
          lineHeight: 0,
        ),
        if (subTitle1 != null)
          BaseText(
            text: subTitle1,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black.withOpacity(0.8),
          ),
        if (subTitle2 != null)
          BaseText(
            text: subTitle2,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            lineHeight: 0,
            textColor: AppColors.black.withOpacity(0.8),
          ),
      ],
    );
  }
}
