import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class CommonTeamContainer extends StatelessWidget {
  final bool isFromTeamDetail;
  final String teamName;
  final num totalMembers;
  final String address;
  final Function()? onPressedEdit;
  final Function()? onPressedDelete;
  const CommonTeamContainer({
    super.key,
    this.isFromTeamDetail = false,
    required this.teamName,
    this.totalMembers = 0,
    required this.address,
    this.onPressedEdit,
    this.onPressedDelete,
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
          SizedBox(width: getSize(15)),
          Image.asset(
            PngImageConstants.line,
            height: getSize(80),
          ),
          SizedBox(width: getSize(15)),
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
                          text: '${StringConstant.totalMembers} - ',
                          style: TextStyle(
                            fontSize: getFontSize(8),
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withValues(alpha: 0.8),
                          ),
                          children: [
                            TextSpan(
                              text: (totalMembers.toString().length == 2)
                                  ? totalMembers.toString()
                                  : "0$totalMembers",
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
                        text: StringConstant.noTeamMemberAddedYet,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.green,
                      ),
                SizedBox(height: getSize(5)),
                BaseText(
                  text: address,
                  fontSize: 10,
                  maxLines: 3,
                  textColor: AppColors.black.withValues(alpha: 0.8),
                ),
              ],
            ),
          ),
          SizedBox(
            width: getSize(10),
          ),
          if (isFromTeamDetail)
            Row(
              children: [
                GestureDetector(
                  onTap: onPressedEdit,
                  child: Container(
                    padding: EdgeInsets.all(getSize(5)),
                    decoration: BoxDecoration(
                      color: Color(0xFF2512FF).withValues(alpha: 0.15),
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
                  onTap: onPressedDelete,
                  child: Container(
                    padding: EdgeInsets.all(getSize(5)),
                    decoration: BoxDecoration(
                      color: Color(0xFFEB0000).withValues(alpha: 0.15),
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
