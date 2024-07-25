import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:path/path.dart' as path;
import 'package:shift/presentation/core/style/app_colors.dart';

class ShowPickedFile extends StatelessWidget {
  String? selectedFile;
  double? mainBoxHeight;
  double? mainBoxWidth;
  double? childBoxHeight;
  double? childBoxWidth;
  bool? isExpandedImage;
  double? iconSize;
  ShowPickedFile(
      {required this.selectedFile,
      this.mainBoxHeight,
      this.childBoxHeight,
      this.childBoxWidth,
      this.mainBoxWidth,
      this.isExpandedImage = true,
      this.iconSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    print("fillle called");
    String fileExtension = (selectedFile != null)
        ? path.extension(selectedFile!).toLowerCase()
        : '';

    return Container(
      height: mainBoxHeight,
      width: mainBoxWidth,
      decoration: BoxDecoration(
        color: (isExpandedImage == true)
            ? AppColors.grey.withOpacity(0.4)
            : AppColors.white,
        borderRadius: (isExpandedImage == true)
            ? BorderRadius.circular(10)
            : BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
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
                    // placeholder: (context, url) => Container(
                    //   height: getSize(90),
                    //   width: getSize(90),
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey.shade100,
                    //     borderRadius: BorderRadius.circular(getSize(10)),
                    //   ),
                    // ),
                    height: getSize(90),
                    width: getSize(90),
                    fit: BoxFit.cover,
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
    );
  }
}
