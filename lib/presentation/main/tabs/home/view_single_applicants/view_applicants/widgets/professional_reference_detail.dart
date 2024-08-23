import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ProfessionalReferenceDetail')
class ProfessionalReferenceDetail extends StatelessWidget {
  const ProfessionalReferenceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Reference Detail',
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
            title: 'Job Position',
            image: SvgImageConstant.briefcase,
            value: 'Job Position',
          ),
          referenceDetail(
            title: 'Organization',
            image: SvgImageConstant.organization,
            value: 'Organization',
          ),
          referenceDetail(
            title: 'Referrer',
            image: SvgImageConstant.person,
            value: 'Kathryn Murphy',
          ),
          referenceDetail(
            title: 'Referrer E-mail',
            image: SvgImageConstant.email,
            value: 'nevaeh.simmons@example.com',
          ),
          referenceDetail(
            title: 'Referrer Phone Number',
            image: SvgImageConstant.call,
            value: '6284985687',
          ),
          referenceDetail(
            title: 'Job Location/Facility',
            image: SvgImageConstant.locationIcon,
            value: '6391 Elgin St. Celina, Delaware 10299',
          ),
          referenceDetail(
            title: 'Unit/Department',
            image: SvgImageConstant.unitDepartment,
            value: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
          ),
          referenceDetail(
            title: 'Start Date',
            image: SvgImageConstant.calendar,
            value: 'May 12, 2024',
          ),
          referenceDetail(
            title: 'End Date',
            image: SvgImageConstant.calendar,
            value: 'May 12, 2024',
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
                    Icon(Icons.flag),
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
