// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class StackedImage extends StatelessWidget {
  StackedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSize(100),
      height: getSize(30),
      // color: Colors.yellow,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < imageList.length; i++)
            if (i <= 5)
              Positioned(
                left: imagePosition[i],
                child: Container(
                  width: getSize(30),
                  height: getSize(30),
                  decoration: BoxDecoration(
                    color: AppColors.authBlack,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: getSize(2),
                    ),
                    image: DecorationImage(
                      opacity: (imageList.length > 6 && i == 5) ? 0.4 : 100,
                      image: NetworkImage(
                        imageList[i],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          if (imageList.length > 6)
            Align(
              alignment: Alignment.centerRight,
              child: BaseText(
                text: "${imageList.length - 6}+",
                fontSize: 9,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
                textColor: AppColors.white,
              ),
            ),
        ],
      ),
    );
  }

  List<String> imageList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_1bpO0XDD8fbmRvnbnkCoQNFFoH3AqofVTg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbG-0Pc_dX0swJiOnUTf58QaSAwwUTpBUi6Q&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWiodenmhSgAPXBgEUGskn4mNvaixE0JlzV4o6-8K4MRUBcLWWuds9cftE1S7_A62UG6M&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4eg_GnT767VTLgEErziGbNpbhNYpCA118Pt2rKOtHTxGNtIBEgJb5zDI_itZ1jWG35GY&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoU9CKHrZmTmgm-wggrQeiLMyy12an8YR-3VSH_rF6opYSGD9GGhdSVPHwfuZD91TIBRQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu6XpGMYJoyiyKejzXAuppy2PHBaWoEv46iAvz2oSzNP-GzC0OIrrSV6RwmSu1zY1NXg8&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWiodenmhSgAPXBgEUGskn4mNvaixE0JlzV4o6-8K4MRUBcLWWuds9cftE1S7_A62UG6M&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4eg_GnT767VTLgEErziGbNpbhNYpCA118Pt2rKOtHTxGNtIBEgJb5zDI_itZ1jWG35GY&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoU9CKHrZmTmgm-wggrQeiLMyy12an8YR-3VSH_rF6opYSGD9GGhdSVPHwfuZD91TIBRQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu6XpGMYJoyiyKejzXAuppy2PHBaWoEv46iAvz2oSzNP-GzC0OIrrSV6RwmSu1zY1NXg8&usqp=CAU",
  ];

  List<double> imagePosition = [0, 13, 26, 39, 52, 65];
}
