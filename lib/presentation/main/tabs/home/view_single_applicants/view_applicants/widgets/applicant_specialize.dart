import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class ApplicantSpecialize extends StatelessWidget {
  const ApplicantSpecialize({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getSize(12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getDetailsView(
            mainTitle: 'Roles',
            subTitle1: 'Registered Nurse',
            subTitle2: 'Paramedic',
            experience1: 'EXP - 04 Yr.  03 Mo.',
            experience2: 'EXP - 02 Yr.  11 Mo.',
          ),
          SizedBox(height: getSize(15)),
          Divider(
            height: 0,
          ),
          SizedBox(height: getSize(15)),
          getDetailsView(
            mainTitle: 'Specialties',
            subTitle1: 'Community Health',
            subTitle2: 'ICU Level 2',
            experience1: 'EXP - 04 Years',
            experience2: 'EXP - 02 Years',
          ),
          SizedBox(height: getSize(15)),
          Divider(
            height: 0,
          ),
          SizedBox(height: getSize(15)),
          getSkillsDetailsView(
            mainTitle: 'Software Skillset',
            skills: 'Solvo Portal, PointClickCare, Solvo Portal',
          ),
          SizedBox(height: getSize(15)),
          Divider(
            height: 0,
          ),
          SizedBox(height: getSize(15)),
          getSkillsDetailsView(
            mainTitle: 'Languages Known',
            skills: 'English, Hindi, Polish',
          ),
        ],
      ),
    );
  }

  getDetailsView({
    required String mainTitle,
    required String subTitle1,
    required String subTitle2,
    required String experience1,
    required String experience2,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: mainTitle,
          textColor: AppColors.green.withOpacity(0.8),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: getSize(5)),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  text: subTitle1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: getSize(5)),
                BaseText(
                  text: experience1,
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(width: getSize(50)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  text: subTitle2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: getSize(5)),
                BaseText(
                  text: experience2,
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  getSkillsDetailsView({
    required String mainTitle,
    required String skills,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: mainTitle,
          textColor: AppColors.green.withOpacity(0.8),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: getSize(5)),
        BaseText(
          text: skills,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
