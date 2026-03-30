import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ProfessionalReferenceDetail')
class ProfessionalReferenceDetail extends StatelessWidget {
  const ProfessionalReferenceDetail({super.key, required this.data});
  final ReferenceDTO data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: StringConstant.referenceDetail,
        onBackPressed: () {
          context.router.maybePop();
        },
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
        physics: BouncingScrollPhysics(),
        children: [
          referenceDetail(
            title: StringConstant.jobPosition,
            image: SvgImageConstant.briefcase,
            value: data.job_position ?? "",
          ),
          referenceDetail(
            title: StringConstant.organization,
            image: SvgImageConstant.organization,
            value: data.organization ?? "",
          ),
          referenceDetail(
            title: StringConstant.referrer,
            image: SvgImageConstant.person,
            value: data.referrer ?? "",
          ),
          referenceDetail(
            title: StringConstant.referrerEmail,
            image: SvgImageConstant.email,
            value: data.email ?? "",
          ),
          referenceDetail(
            title: StringConstant.referrerPhoneNumber,
            image: SvgImageConstant.call,
            value: "${data.phone ?? 0}",
          ),
          referenceDetail(
            title: StringConstant.jobLocationFacility,
            image: SvgImageConstant.locationIcon,
            value: data.job_location ?? "",
          ),
          referenceDetail(
            title: StringConstant.unitDepartment,
            image: SvgImageConstant.unitDepartment,
            value: data.unit ?? "",
          ),
          referenceDetail(
            title: StringConstant.startDate,
            image: SvgImageConstant.calendar,
            value: DateFormat("d MMM, yyyy").format(
                CustomDateTimeFormat.timeStampToDateTime(
                    (data.start_date ?? -1))),
          ),
          referenceDetail(
            title: StringConstant.endDate,
            image: SvgImageConstant.calendar,
            value: DateFormat("dd MMM, yyyy").format(
                CustomDateTimeFormat.timeStampToDateTime(
                    (data.end_date ?? -1))),
          ),
          SizedBox(height: getSize(20)),
        ],
      ),
    );
  }

  referenceDetail(
      {required String title, required String image, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getSize(20)),
        BaseText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: getSize(8)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: getSize(20),
            vertical: getSize(14),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                image,
                colorFilter:
                    ColorFilter.mode(AppColors.green, BlendMode.srcATop),
              ),
              SizedBox(width: getSize(10)),
              Visibility(
                visible: image == SvgImageConstant.call,
                child: Row(
                  children: [
                    SizedBox(width: getSize(15)),
                    Text(
                      "${data.country_name_code}",
                      style: TextStyle(fontSize: 19),
                    ),
                    SizedBox(width: getSize(5)),
                    Icon(Icons.keyboard_arrow_down),
                    SizedBox(width: getSize(15)),
                  ],
                ),
              ),
              Expanded(
                child: BaseText(
                  text: value,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
