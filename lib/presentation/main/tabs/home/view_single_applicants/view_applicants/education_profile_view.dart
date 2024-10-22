import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/infrastructure/core/education_dto/education_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'EducationProfileListView')
class EducationProfileListView extends StatelessWidget {
  const EducationProfileListView({super.key, required this.applicantDto});

  final ApplicantDto applicantDto;

  @override
  Widget build(BuildContext context) {
    final list = (applicantDto.education ?? []);
    Log.info(list);
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: "Education",
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        separatorBuilder: (context, index) => Gap(16),
        itemCount: list.length,
        itemBuilder: (context, index) => _ListTile(data: list[index]),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({required this.data});

  final EducationDTO data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(14),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          context.router.push(
            PageRouteInfo(
              AddEducationDetailScreen.name,
              args: AddEducationDetailScreenArgs(educationObj: data,readOnly: true)
            ),
          );
        },
        child: Row(
          children: [
            Image.asset(
              PngImageConstants.education,
              height: getSize(25),
              width: getSize(45),
            ),
            SizedBox(
              width: getSize(15),
            ),
              Image.asset(
                PngImageConstants.line,
                height: getSize(80),
              ),
            SizedBox(
              width: getSize(15),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    text: data.program_completed ?? "",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  Text.rich(
                    TextSpan(text: "Completed in - ", style: TextStyle(fontSize: 8), children: [
                      TextSpan(text: data.year_of_completion ?? "", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                    ]),
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  BaseText(
                    text: data.graduating_institution ?? "",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            //  Icon(Icons.arrow_forward_rounded)
          ],
        ),
      ),
    );
  }
}
