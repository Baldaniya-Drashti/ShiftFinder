import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ProfessionalProfileView')
class ProfessionalProfileView extends StatelessWidget {
  const ProfessionalProfileView({super.key, required this.applicantDto});

  final ApplicantDto applicantDto;

  @override
  Widget build(BuildContext context) {
    final list = applicantDto.reference?.where((element) => element.type == 1).toList() ?? [];

    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: "Professional Reference",
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        separatorBuilder: (context, index) => Gap(16),
        itemCount: list.length,
        itemBuilder: (context, index) => _ListTile(
          data: list[index],
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({required this.data});

  final ReferenceDTO data;

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
            PageRouteInfo(ProfessionalReferenceDetail.name, args: ProfessionalReferenceDetailArgs(data: data)),
          );
        },
        child: Row(
          children: [
            Image.asset(
              PngImageConstants.suitcase,
              height: getSize(40),
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
                    text: data.job_position ?? "-",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "${data.unit ?? ""} ",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  BaseText(
                    text: data.organization ?? "",
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
