import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class ApplicantSpecialize extends StatelessWidget {
  const ApplicantSpecialize({
    super.key,
    required this.data,
  });

  final ApplicantDto data;

  @override
  Widget build(BuildContext context) {
    final completeProfile = data.complete_profile;
    final specialityOther = completeProfile?.specialties_detail
        ?.where((element) => element.specialtie_lists == null)
        .toList();
    final speciality = completeProfile?.specialties_detail
        ?.where((element) => element.specialtie_lists != null)
        .toList();
    Log.info(data.experience);
    return Container(
      padding: EdgeInsets.all(getSize(12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((data.experience ?? []).isNotEmpty) ...[
            BaseText(
              text: "Roles",
              textColor: AppColors.green.withOpacity(0.8),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getSize(5)),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(
                data.experience?.length ?? 0,
                (index) {
                  final role = data.experience?[index].role?.name ?? "";
                  final exp = data.experience?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: role,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: getSize(2)),
                      BaseText(
                        text:
                            "Exp - ${exp?.experience_year ?? "-"} Yr. ${exp?.experience_month ?? "-"} Mo.",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],

          // getDetailsView(
          //   mainTitle: 'Roles',
          //   subTitle1: roles ?? "",
          //   subTitle2: 'Paramedic',
          //   experience1: 'EXP - 04 Yr.  03 Mo.',
          //   experience2: 'EXP - 02 Yr.  11 Mo.',
          // ),
          SizedBox(height: getSize(15)),
          Divider(
            height: 0,
          ),
          SizedBox(height: getSize(15)),

          if ((speciality ?? []).isNotEmpty) ...[
            BaseText(
              text: "Specialties",
              textColor: AppColors.green.withOpacity(0.8),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getSize(5)),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(
                speciality?.length ?? 0,
                (index) {
                  final role = speciality?[index].specialtie_lists?.name ?? "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: role,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: getSize(2)),
                      BaseText(
                        text:
                            "Exp - ${speciality?[index].experience_year ?? 0} Yr.  ${speciality?[index].experience_month ?? 0} Mo.",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],

          if ((specialityOther ?? []).isNotEmpty) ...[
            SizedBox(height: getSize(8)),
            BaseText(
              text: "Other Specialties",
              textColor: AppColors.green.withOpacity(0.8),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getSize(2)),
            Wrap(
              children: List.generate(
                specialityOther?.length ?? 0,
                (index) {
                  final role =
                      specialityOther?[index].specialtie_lists_other ?? "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: role,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: getSize(5)),
                      BaseText(
                        text:
                            "Exp - ${speciality?[index].experience_year ?? 0} Yr.  ${speciality?[index].experience_month ?? 0} Mo.",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],

          SizedBox(height: getSize(15)),
          Divider(
            height: 0,
          ),
          SizedBox(height: getSize(15)),
          getSkillsDetailsView(
            mainTitle: 'Software Skillset',
            skills:
                '${data.complete_profile?.softwares_skill_list?.map((e) => e.name ?? "").join(", ")}',
          ),

          if (data.complete_profile?.software_skill_other != null) ...[
            SizedBox(height: getSize(8)),
            getSkillsDetailsView(
              mainTitle: 'Software Skillset Other',
              skills: '${data.complete_profile?.software_skill_other}',
            ),
          ],
          SizedBox(height: getSize(15)),
          Divider(
            height: 0,
          ),
          SizedBox(height: getSize(15)),
          getSkillsDetailsView(
            mainTitle: 'Languages Known',
            skills:
                '${completeProfile?.languages_list?.map((e) => e.name ?? "").toList().join(", ")}',
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
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
