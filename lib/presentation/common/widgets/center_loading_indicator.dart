// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class CenterLoadingIndicator extends StatelessWidget {
  bool isOnlyLoader;
  CenterLoadingIndicator({this.isOnlyLoader = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black.withOpacity((isOnlyLoader) ? 0 : 0.2),
      child: Center(
        child: Container(
          height: getSize(100),
          width: getSize(100),
          decoration: BoxDecoration(
            color: (isOnlyLoader) ? AppColors.transparent : AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

  //  Center(
  //     child: CircularProgressIndicator(
  //       valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
  //     ),
  //   );
