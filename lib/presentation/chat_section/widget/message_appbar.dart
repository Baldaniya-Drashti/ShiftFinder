import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/additional_data_dto/additional_data_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class MessageAppbar extends StatelessWidget implements PreferredSizeWidget {
  final AdditionalDataDto additionalData;
  final void Function()? onBackPressed;
  const MessageAppbar(
      {super.key, required this.additionalData, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.scaffoldColor,
      elevation: 0,
      leadingWidth: 0,
      leading: SizedBox.shrink(),
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onBackPressed ??
                    () {
                      context.router.maybePop();
                    },
                child: SvgPicture.asset(
                  SvgImageConstant.back,
                  colorFilter:
                      ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                ),
              ),
              SizedBox(width: getSize(15)),
              if (additionalData.profile != null)
                Container(
                  height: getSize(30),
                  width: getSize(35),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: getSize(2),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        additionalData.profile ??
                            'https://img.freepik.com/free-photo/fashionable-young-woman-standing-front-blue-backdrop_23-2148204718.jpg?semt=ais_hybrid-rr-similar',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(width: getSize(12)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BaseText(
                    text: additionalData.name ?? '',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  SizedBox(height: getSize(2)),
                  BaseText(
                    text: (additionalData.service_roles == "2")
                        ? additionalData.location ?? ''
                        : additionalData.role_list_name ?? "",
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                    textColor: AppColors.black.withValues(alpha: 0.8),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: getSize(5)),
          Divider(
            color: AppColors.black.withValues(alpha: 0.1),
            thickness: 1,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(getSize(70));
}
