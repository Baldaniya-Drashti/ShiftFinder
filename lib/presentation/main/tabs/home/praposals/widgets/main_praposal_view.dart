import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';

class MainPraposalView extends StatelessWidget {
  const MainPraposalView({
    super.key,
    required this.additionalData,
    required this.postId,
  });

  final EmployerProposalDto additionalData;
  final int postId;

  @override
  Widget build(BuildContext context) {
    final industry = CommonList.industryList
        .firstWhere((element) => element.id == additionalData.industry)
        .title;
    Log.info((additionalData.start_date ?? 0) * 1000);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getSize(20)),
      padding: EdgeInsets.all(getSize(10)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(getSize(12)),
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(getSize(10)),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: getSize(23),
                      backgroundColor: Colors.transparent,
                      child: Image.asset(PngImageConstants.nurse2),
                    ),
                    SizedBox(width: getSize(15)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: BaseText(
                                  text: additionalData.roles_list_name ?? "",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 1,
                                ),
                              ),
                              Spacer(),
                              BaseText(
                                text: additionalData.last_ago ?? "",
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(height: getSize(3)),
                          BaseText(
                            text:
                                '($industry- ${additionalData.listing_id ?? ""})',
                            fontSize: 12,
                            textColor: const Color.fromARGB(255, 55, 46, 46)
                                .withValues(alpha: 0.8),
                          ),
                          BaseText(
                            text:
                                additionalData.location?.facility_type?.name ??
                                    "",
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getSize(10)),
                Divider(
                  height: 0,
                  color: AppColors.black.withValues(alpha: 0.2),
                  thickness: 0.5,
                ),
                SizedBox(height: getSize(10)),
                GestureDetector(
                  onTap: () {
                    final location = additionalData.location;
                    final latitude = location?.latitude;
                    final longitude = location?.longitude;
                    if (latitude != null && longitude != null) {
                      LocationHelper.openDirections(context,
                          endLat: latitude, endLng: longitude);
                      /* context.router.push(
                        PageRouteInfo(
                          ShowGoogleMap.name,
                          args: ShowGoogleMapArgs(
                            latitude: latitude,
                            longitude: longitude,
                          ),
                        ),
                      ); */
                    }
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        SvgImageConstant.location,
                        colorFilter: ColorFilter.mode(
                          AppColors.black,
                          BlendMode.srcATop,
                        ),
                      ),
                      SizedBox(width: getSize(5)),
                      Flexible(
                        child: BaseText(
                          text: additionalData.location?.location ?? "",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getSize(10)),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: getSize(5),
              horizontal: getSize(20),
            ),
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(getSize(10)),
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: 'Shift Date:-',
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: getSize(3)),
                      Text.rich(
                        style: TextStyle(fontSize: 12),
                        TextSpan(
                          text:
                              "${convertUnixTimeToLocalString(additionalData.start_date ?? 0)}, ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text:
                                    "${DateTime.fromMillisecondsSinceEpoch((additionalData.start_date ?? 0) * 1000).year}",
                                style: TextStyle(
                                    color: AppColors.black
                                        .withValues(alpha: 0.5))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: AppColors.black.withValues(alpha: 0.3),
                    width: 0,
                    indent: getSize(5),
                    endIndent: getSize(5),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: '${StringConstant.startAndEndTime}:-',
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: getSize(5)),
                      BaseText(
                        text:
                            '${formatUnixTimestamp(additionalData.start_time ?? 0)} to ${formatUnixTimestamp(additionalData.end_time ?? 0)}',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // if (additionalData.complete_shift != 0) ...[
          SizedBox(height: getSize(10)),
          Container(
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(7),
            ),
            padding: EdgeInsets.all(12),
            child: InkWell(
              onTap: (additionalData.complete_shift != 0)
                  ? () {
                      context.router.push(
                        PageRouteInfo(FilledHiredContractorList.name,
                            args:
                                FilledHiredContractorListArgs(postId: postId)),
                      );
                    }
                  : null,
              child: Row(
                children: [
                  SvgPicture.asset(
                    SvgImageConstant.profileCircle,
                    height: 35,
                    width: 35,
                  ),
                  Gap(8),
                  Expanded(
                    child: BaseText(
                      text:
                          "${StringConstant.allHiredContractors} (${additionalData.complete_shift}/${additionalData.total_shift})",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SvgPicture.asset(
                    SvgImageConstant.rightArrow,
                    height: 14,
                    width: 14,
                    colorFilter: ColorFilter.mode(
                        AppColors.black.withValues(alpha: 0.7),
                        BlendMode.srcIn),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
