import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class ReferenceView extends StatelessWidget {
  const ReferenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        BaseText(
          text: 'References (Tap To View)',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          textColor: Colors.black.withOpacity(0.8),
        ),
        SizedBox(
          height: getSize(8),
        ),
        professionalRef(context),
        personalRef(context),
      ],
    );
  }

  professionalRef(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(PageRouteInfo(ProfessionalReferenceDetail.name));
        //  context.router.push(PageRouteInfo(ProfessionalReferenceDetail.name));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: getSize(10)),
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(14),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              PngImageConstants.person,
              height: getSize(35),
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
                    text: 'Professional',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  BaseText(
                    text: 'Brooklyn Simmons',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  BaseText(
                    text: 'debra.holt@example.com',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded)
          ],
        ),
      ),
    );
  }

  personalRef(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(PageRouteInfo(PersonalReferenceDetail.name));
        //  context.router.push(PageRouteInfo(ProfessionalReferenceDetail.name));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: getSize(10)),
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(14),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              PngImageConstants.person,
              height: getSize(35),
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
                    text: 'Personal',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  BaseText(
                    text: 'Brooklyn Simmons',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  BaseText(
                    text: 'debra.holt@example.com',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded)
          ],
        ),
      ),
    );
  }
}
