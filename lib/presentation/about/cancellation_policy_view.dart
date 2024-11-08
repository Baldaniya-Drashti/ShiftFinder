import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import '../../domain/core/string_constant.dart';

@RoutePage(name: "CancellationPolicyView")
class CancellationPolicyView extends StatelessWidget {
  const CancellationPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Cancellation Policy"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            documentImage(),
            SizedBox(
              height: getSize(20),
            ),
            BaseText(
              text: "Cancellation Policy",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: AppColors.primaryColor,
            ),
            Gap(8),
            BaseText(
              text: "Aliqua id fugiat nostrud irure ex duis ea fdsquis id quis ad et. Sunt qui esse pariatur duis deserunt mollit fdsfdolore cillum minim tempor enim. Elit aute irure tempofdsfd or cupidatat incididunt sint deserunt ut voluptate aute deid dfsd deserunt nisi.Nulla Lorem mollit cupidatat irure. Laborum magna nulla duis ullamco cillum dolor. Voluptate exercitation dfsincididunt aliquip deserunnaekea maeti ormer rt reprehenderit elit labor",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              maxLines: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget documentImage() {
    return Container(
      // height: getSize(103),
      padding: EdgeInsets.symmetric(vertical: getSize(20), horizontal: getSize(32)),
      decoration: BoxDecoration(color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgImageConstant.clockWithVerticalLine,
            height: getSize(63),
            width: getSize(57.95),
          ),
          SizedBox(
            width: getSize(15),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  text: "Hello,✋  Misty Evans",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.5,
                ),
                SizedBox(
                  width: getHorizontalSize(200),
                  child: BaseText(
                    text: StringConstant.termsScreenImageDesc1,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
