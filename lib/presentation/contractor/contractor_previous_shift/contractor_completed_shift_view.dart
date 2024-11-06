import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_profile/contractor_profile.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class ContractorCompletedShiftView extends StatelessWidget {
  const ContractorCompletedShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(12),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(getSize(12)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(getSize(20)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.2),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              userDetail(context),

              Gap(15),
              Row(
                children: [
                  Expanded(
                    child: CommonInfoTile(
                      leading: SvgPicture.asset(
                        SvgImageConstant.calendar,
                        height: 15,
                        width: 15,
                        colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.6), BlendMode.srcIn),
                      ),
                      title: BaseText(
                        text: "Shift Date",
                        fontSize: getSize(10),
                        textColor: AppColors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                      ),
                      subtitle: Text.rich(
                        style: TextStyle(fontSize: 12),
                        TextSpan(
                          text: "12 May, ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(text: "2024", style: TextStyle(color: AppColors.black.withOpacity(0.5))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: AppColors.scaffoldColor,
                      borderRadius: BorderRadius.circular(7),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: BaseText(text: "View Shift Details", fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Gap(15),
              CommonButton(
                onPressed: () {
                  context.router.push(PageRouteInfo(InvoiceDetailView.name));
                },
                buttonText: "View Invoice",
                backgroundColor: AppColors.green.withOpacity(0.1),
                buttonFontSize: 12,
                height: 43,
                buttonTextColor: AppColors.black,
                buttonFontWeight: FontWeight.w600,
                borderRadius: 7,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Gap(15),
      itemCount: 5,
    );
  }

  Widget userDetail(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.scaffoldColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(12)),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Image.asset(
              PngImageConstants.leafWithBG,
              height: getSize(45),
              width: getSize(45),
            ),
            isThreeLine: true,
            title: BaseText(
              text: "CT Technologist",
              textColor: AppColors.black,
              fontSize: 16,
              maxLines: 1,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: "Louis Vuitton Pvt. Ltd.",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                BaseText(
                  text: "(Healthcare - 2DFG125)",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          Divider(
            color: AppColors.black.withOpacity(0.2),
            thickness: getSize(0.5),
          ),
          GestureDetector(
            onTap: () {
              /*context.router.push(
                    PageRouteInfo(
                      ShowGoogleMap.name,
                      args: ShowGoogleMapArgs(
                        latitude: 21.191535534205194,
                        longitude: 72.78582206137469,
                      ),
                    ),
                  );*/
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgImageConstant.location,
                  height: getSize(25),
                  width: getSize(25),
                  color: AppColors.black,
                ),
                SizedBox(
                  width: getSize(10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: "4517 Washington Manchester, Kentucky 39495",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: "10.2 Km Away",
                        fontSize: 10,
                        maxLines: 1,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getSize(12),
          ),
        ],
      ),
    );
  }
}
