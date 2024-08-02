// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  String imageUrl;
  Widget? errorWidget;
  Widget? placeWidget;
  CustomCachedNetworkImage(
      {super.key, required this.imageUrl, this.errorWidget, this.placeWidget});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => placeWidget ?? Container(),
      errorWidget: (context, error, _) {
        return errorWidget ?? Image.asset(PngImageConstants.splash_logo);
      },
    );
  }
}
