import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/payment_history_dto/payment_history_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class CommonPaymentHistoryTile extends StatelessWidget {
  final PaymentHistoryDTO shift;
  final Widget child;
  const CommonPaymentHistoryTile(
      {super.key, required this.shift, required this.child});

  @override
  Widget build(BuildContext context) {
    final industry = CommonList.industryList
        .firstWhere((element) => element.id == shift.industry);
    return BaseTileDecoration(
      child: Column(
        children: [
          Material(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonInfoTile(
                    leading: SizedBox.square(
                      dimension: getSize(50),
                      child: Image.asset(PngImageConstants.nurse2),
                    ),
                    title: BaseText(
                      text: shift.roles_list_name ?? "",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    subtitle: BaseText(
                        text:
                            '(${industry.title ?? ""} - ${shift.listing_id ?? ""})',
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(text: StringConstant.endDate, fontSize: 8),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(color: AppColors.primaryColor),
                            text: (shift.end_date != null)
                                ? DateFormat('dd MMM, ').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        (shift.end_date!) * 1000))
                                : "",
                            children: [
                              TextSpan(
                                text: (shift.end_date != null)
                                    ? "${DateTime.fromMillisecondsSinceEpoch((shift.end_date!) * 1000).year}"
                                    : "",
                                style: TextStyle(
                                    color: AppColors.black.withOpacity(0.8)),
                              ),
                            ],
                          ),
                          style: TextStyle(fontSize: getFontSize(8)),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      final location = shift.location;
                      final latitude = location?.latitude;
                      final longitude = location?.longitude;
                      if (latitude != null && longitude != null) {
                        context.router.push(
                          PageRouteInfo(
                            ShowGoogleMap.name,
                            args: ShowGoogleMapArgs(
                              latitude: latitude,
                              longitude: longitude,
                            ),
                          ),
                        );
                      }
                    },
                    child: CommonInfoTile(
                      leading: SvgPicture.asset(
                        SvgImageConstant.location,
                        colorFilter:
                            ColorFilter.mode(Colors.black, BlendMode.srcIn),
                        height: getSize(24),
                        width: getSize(24),
                      ),
                      title: BaseText(
                          text: shift.location?.location ?? "",
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Divider(),
                  CommonInfoTile(
                    leading: UserAvatar(
                      size: getSize(35),
                      url: shift.profile ?? "",
                    ),
                    title: BaseText(
                        text:
                            "${shift.first_name ?? ""} ${shift.last_name ?? ""}",
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    subtitle: BaseText(
                        text: (shift.shift_type == "1")
                            ? StringConstant.singleShift
                            : StringConstant.multiShift,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ),
          Gap(getSize(12)),
          child,
        ],
      ),
    );
  }
}
