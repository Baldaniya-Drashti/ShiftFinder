// ignore_for_file: depend_on_referenced_packages, must_be_immutable, avoid_print

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:path/path.dart' as path;
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:badges/badges.dart' as badges;

class ShowPickedFile extends StatelessWidget {
  final String? selectedFile;
  final double? mainBoxHeight;
  final double? mainBoxWidth;
  final double? childBoxHeight;
  final double? childBoxWidth;
  final bool? isExpandedImage;
  final bool showBadge;
  final double? iconSize;
  final VoidCallback? onDelete;
  const ShowPickedFile(
      {required this.selectedFile,
      this.mainBoxHeight,
      this.childBoxHeight,
      this.childBoxWidth,
      this.mainBoxWidth,
      this.isExpandedImage = true,
      this.showBadge = true,
      this.iconSize,
      this.onDelete,
      super.key});

  @override
  Widget build(BuildContext context) {
    String fileExtension = (selectedFile != null)
        ? path.extension(selectedFile!).toLowerCase()
        : '';
    return Container(
      height: mainBoxHeight,
      width: mainBoxWidth,
      decoration: BoxDecoration(
        color: (isExpandedImage == true) ? AppColors.grey04 : AppColors.white,
        borderRadius: (isExpandedImage == true)
            ? BorderRadius.circular(10)
            : BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: showBadgeButton(
        showBadge,
        context: context,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: (fileExtension == '.jpg' ||
                        fileExtension == '.jpeg' ||
                        fileExtension == '.png')
                    ? AppColors.grey
                    : AppColors.white,
                spreadRadius: 0.2,
                blurRadius: (fileExtension == '.jpg' ||
                        fileExtension == '.jpeg' ||
                        fileExtension == '.png')
                    ? 10
                    : 0,
              ),
            ],
            border: (fileExtension == '.jpg' ||
                    fileExtension == '.jpeg' ||
                    fileExtension == '.png')
                ? null
                : Border.all(
                    color: (isExpandedImage == true)
                        ? AppColors.black
                        : AppColors.transparent),
            borderRadius: (fileExtension == '.jpg' ||
                    fileExtension == '.jpeg' ||
                    fileExtension == '.png')
                ? BorderRadius.circular(5)
                : BorderRadius.circular(5),
          ),
          height: childBoxHeight ?? getSize(384),
          width: childBoxWidth ?? (298),
          child: (fileExtension == '.jpg' ||
                  fileExtension == '.jpeg' ||
                  fileExtension == '.png')
              ? (selectedFile != null && selectedFile!.contains('http'))
                  ? CachedNetworkImage(
                      imageUrl: selectedFile ?? "",
                      height: getSize(90),
                      width: getSize(90),
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      File(selectedFile ?? ''),
                      fit: BoxFit.fill,
                      width: double.infinity,
                    )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        (fileExtension == '.pdf')
                            ? Icons.picture_as_pdf
                            : Icons.description,
                        size: iconSize ?? getSize(50),
                        color: Colors.red),
                    if (isExpandedImage == true) ...[
                      SizedBox(height: getSize(10)),
                      SizedBox(
                        width: getSize(180),
                        child: BaseText(
                          text: path.basename(selectedFile ?? ""),
                          fontSize: 14,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }

  Widget showBadgeButton(bool showBadge,
      {required BuildContext context, required Widget child}) {
    return (showBadge)
        ? badges.Badge(
            onTap: () {
              AppFocus.unfocus(context);
              if (onDelete != null) {
                onDelete!.call();
              }
            },
            showBadge: showBadge,
            badgeContent: SvgPicture.asset(
              SvgImageConstant.minusCircle,
              height: getSize(20),
              width: getSize(20),
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: AppColors.primaryColor,
            ),
            child: child,
          )
        : child;
  }
}
