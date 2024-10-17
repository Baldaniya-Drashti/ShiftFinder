import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/additional_data_dto/additional_data_dto.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';

class MainPraposalView extends StatelessWidget {
  const MainPraposalView({
    super.key,
    required this.additionalData,
  });

  final EmployerProposalDto additionalData;

  @override
  Widget build(BuildContext context) {
    final industry = CommonList.industryList.firstWhere((element) => element.id == additionalData.industry).title;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getSize(20)),
      padding: EdgeInsets.all(getSize(10)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.15),
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
                  children: [
                    CircleAvatar(
                      radius: getSize(20),
                      backgroundColor: AppColors.green,
                      child: CircleAvatar(
                        radius: getSize(19),
                        backgroundImage: NetworkImage(

                              "https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg",
                        ),
                      ),
                    ),
                    SizedBox(width: getSize(15)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: BaseText(
                                  text: additionalData.roles_list_name ?? "",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 2,
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
                            text: '($industry- ${additionalData.listing_id ?? ""})',
                            fontSize: 12,
                            textColor: const Color.fromARGB(255, 55, 46, 46).withOpacity(0.8),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getSize(10)),
                Divider(
                  height: 0,
                  color: AppColors.black.withOpacity(0.2),
                  thickness: 0.5,
                ),
                SizedBox(height: getSize(10)),
                Row(
                  children: [
                    SvgPicture.asset(
                      SvgImageConstant.location,
                      colorFilter: ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcATop,
                      ),
                    ),
                    SizedBox(width: getSize(5)),
                    BaseText(
                      text: additionalData.location?.location ?? "",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
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
                          text: "${convertUnixTimeToLocalString(additionalData.start_date ?? 0)}, ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: "${DateTime.fromMillisecondsSinceEpoch(additionalData.start_date ?? 0).year}",
                                style: TextStyle(color: AppColors.black.withOpacity(0.5))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: AppColors.black.withOpacity(0.3),
                    width: 0,
                  ),
                  Column(
                    children: [
                      BaseText(
                        text: 'Start and End Time:-',
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
          SizedBox(height: getSize(10)),
          ListTile()
        ],
      ),
    );
  }
}
