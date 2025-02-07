import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ReferenceListView")
class ReferenceListView extends StatelessWidget {
  const ReferenceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(), title: "Reference"),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(18),
              vertical: getSize(20),
            ),
            separatorBuilder: (context, index) => Gap(16),
            itemCount: 5,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _ReferenceListTile();
            },
          ),
          Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: AppColors.green.withOpacity(0.15),
            borderRadius: BorderRadius.circular(7),
            child: InkWell(
              onTap: () async {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: BaseText(
                  text: "+ Add More Reference",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.green,
                ),
              ),
            ),
          ),
          Gap(30)
        ],
      ),
    );
  }
}

class _ReferenceListTile extends StatelessWidget {
  const _ReferenceListTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(12).copyWith(left: 16, right: 16),
      child: Row(
        children: [
          Image.asset(
            PngImageConstants.person,
            height: 45,
            width: 45,
            color: AppColors.green,
          ),
          Gap(12),
          Image.asset(
            PngImageConstants.line,
            height: getSize(80),
          ),
          Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  text: "Professional",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text: "Organization Name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                BaseText(
                  text: "debra.holt@example.com",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          Gap(12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {},
                child: SvgPicture.asset(SvgImageConstant.editWithBg),
              ),
              SizedBox(width: getSize(10)),
              GestureDetector(
                onTap: () async {
                  final result = await AppDialog.showCommonDialog(
                    context: context,
                    title: "Delete",
                    content: "Are you sure you want to delete this reference?",
                    successLabel: "Delete",
                  );
                  if (result ?? false) {}
                },
                child: SvgPicture.asset(SvgImageConstant.bin),
              ),
            ],
          )
        ],
      ),
    );
  }
}
