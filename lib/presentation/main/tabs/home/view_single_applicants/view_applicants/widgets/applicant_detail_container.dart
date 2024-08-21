import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class ApplicantsDetailView extends StatelessWidget {
  const ApplicantsDetailView({
    super.key,
    required this.data,
  });

  final ApplicantDto data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getSize(12)),
      decoration: BoxDecoration(
        color: AppColors.white,
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
                    data.profile ?? "",
                  ),
                ),
              ),
              SizedBox(width: getSize(15)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      text: "${data.first_name ?? ""} ${data.last_name ?? ""}",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
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
          GestureDetector(
            onTap: () {
              final latitude = data.latitude;
              final longitude = data.longitude;
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
                Expanded(
                    child: BaseText(
                  text: data.location ?? "",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  maxLines: 4,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
