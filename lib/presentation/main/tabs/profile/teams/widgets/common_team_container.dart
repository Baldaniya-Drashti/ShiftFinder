import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';

class CommonTeamContainer extends StatelessWidget {
  final bool isFromTeamDetail;
  final String teamName;
  final num totalMembers;
  final String address;
  const CommonTeamContainer({
    super.key,
    this.isFromTeamDetail = false,
    required this.teamName,
    this.totalMembers = 0,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(14),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      decoration: BoxDecoration(
        color: Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            PngImageConstants.teamImage,
            height: getSize(45),
            width: getSize(60),
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
                  text: teamName,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: getSize(5),
                ),
                totalMembers > 0
                    ? Text.rich(
                        TextSpan(
                          text: 'Total Members - ',
                          style: TextStyle(
                            fontSize: getFontSize(8),
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.8),
                          ),
                          children: [
                            TextSpan(
                              text: totalMembers.toString(),
                              style: TextStyle(
                                fontSize: getFontSize(8),
                                fontWeight: FontWeight.w600,
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                      )
                    : BaseText(
                        text: 'No team member added yet',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.green,
                      ),
                SizedBox(
                  height: getSize(5),
                ),
                BaseText(
                  text: address,
                  fontSize: 10,
                  textColor: AppColors.black.withOpacity(0.8),
                ),
              ],
            ),
          ),
          if (isFromTeamDetail)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.router.push(
                      PageRouteInfo(
                        AddNewMemberView.name,
                        args: AddNewMemberViewArgs(isUpdateMember: true),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(getSize(5)),
                    decoration: BoxDecoration(
                      color: Color(0xFF2512FF).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(getSize(6)),
                    ),
                    child: SvgPicture.asset(
                      SvgImageConstant.edit,
                      colorFilter: ColorFilter.mode(
                        Color(0xFF2512FF),
                        BlendMode.srcATop,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: getSize(10),
                ),
                GestureDetector(
                  onTap: () {
                    AcceptRejectDialog(
                      title: 'Delete Team',
                      description:
                          'Deleting this team will prevent you from sharing the shift posting summary with its members. Are you sure you want to proceed?',
                      onPressedAccept: () {},
                      onPressedReject: () {
                        context.router.maybePop();
                      },
                      acceptButtonText: 'Delete',
                    ).acceptRejectDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(getSize(5)),
                    decoration: BoxDecoration(
                      color: Color(0xFFEB0000).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(getSize(6)),
                    ),
                    child: SvgPicture.asset(
                      SvgImageConstant.delete,
                      colorFilter: ColorFilter.mode(
                        Color(0xFFEB0000),
                        BlendMode.srcATop,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }
}
