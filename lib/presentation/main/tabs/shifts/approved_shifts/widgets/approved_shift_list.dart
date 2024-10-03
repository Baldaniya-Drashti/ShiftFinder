import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/tabs/shifts/approved_shifts/widgets/edit_clock_time_dialog.dart';

class ApprovedShiftList extends StatelessWidget {
  const ApprovedShiftList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: getSize(10),
        vertical: getSize(12.5),
      ),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // context.router.push(
            //   PageRouteInfo(
            //     ViewApplicantProfile.name,
            //   ),
            // );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: getSize(index == 0 || index == 9 ? 0 : 12.5)),
            padding: EdgeInsets.all(getSize(10)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(getSize(20)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.15),
                  blurRadius: 24,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(getSize(12)),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(getSize(10)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: getSize(30),
                            backgroundColor: AppColors.green,
                            child: CircleAvatar(
                              radius: getSize(29),
                              backgroundImage: NetworkImage(
                                'https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg',
                              ),
                            ),
                          ),
                          SizedBox(width: getSize(15)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    BaseText(
                                      text: "CT Technologist",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                SizedBox(height: getSize(3)),
                                BaseText(
                                  text: '(Healthcare - 2DFG125)',
                                  fontSize: 12,
                                  textColor:
                                      const Color.fromARGB(255, 55, 46, 46)
                                          .withOpacity(0.8),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getSize(10)),
                      Divider(
                        height: 0,
                        color: AppColors.black.withOpacity(0.2),
                        thickness: 0.5,
                      ),
                      SizedBox(height: getSize(10)),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImageConstant.location,
                            colorFilter: ColorFilter.mode(
                              AppColors.black,
                              BlendMode.srcATop,
                            ),
                          ),
                          SizedBox(width: getSize(5)),
                          BaseText(
                            text: '4517 Washington Manchester, Kentucky 39495',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getSize(10)),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getSize(12),
                    horizontal: getSize(20),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(getSize(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        text: 'Remaining Shifts',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      BaseText(
                        text: '03',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.primaryColor,
                      )
                    ],
                  ),
                ),
                SizedBox(height: getSize(10)),
                Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      SvgImageConstant.calendar,
                      height: getSize(15),
                      width: getSize(15),
                      colorFilter: ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcATop,
                      ),
                    ),
                    SizedBox(width: getSize(7)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          text: 'Shift Date',
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: getSize(5)),
                        BaseText(
                          text: 'May 12, 2024',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      SvgImageConstant.infoCircle,
                      height: getSize(15),
                      width: getSize(15),
                      colorFilter: ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcATop,
                      ),
                    ),
                    SizedBox(width: getSize(7)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          text: 'Time',
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: getSize(5)),
                        BaseText(
                          text: '09:15 AM to 07:30 PM',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: getSize(15)),
                Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      SvgImageConstant.calendar,
                      height: getSize(15),
                      width: getSize(15),
                      colorFilter: ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcATop,
                      ),
                    ),
                    SizedBox(width: getSize(7)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          text: 'Estimated Payables',
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: getSize(5)),
                        BaseText(
                          text: '\$460',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Spacer(),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.router.push(
                            PageRouteInfo(
                              ViewFilledShiftsDetails.name,
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: getSize(8),
                            // horizontal: getSize(20),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldColor,
                            borderRadius: BorderRadius.circular(getSize(7)),
                          ),
                          child: BaseText(
                            text: 'View shift Details',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getSize(15)),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getSize(10),
                    horizontal: getSize(20),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(getSize(10)),
                  ),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        SvgImageConstant.clock,
                        height: getSize(15),
                        width: getSize(15),
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcATop,
                        ),
                      ),
                      SizedBox(width: getSize(7)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            text: 'Clock in',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.black.withOpacity(0.7),
                          ),
                          SizedBox(height: getSize(5)),
                          BaseText(
                            text: '09:15 AM',
                            fontSize: 12,
                            textColor: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        SvgImageConstant.infoCircle,
                        height: getSize(15),
                        width: getSize(15),
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcATop,
                        ),
                      ),
                      SizedBox(width: getSize(7)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            text: 'Clock out',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.black.withOpacity(0.7),
                          ),
                          SizedBox(height: getSize(5)),
                          BaseText(
                            text: '07:30 PM',
                            fontSize: 12,
                            textColor: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getSize(15)),
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        height: 34,
                        onPressed: () {
                          AcceptRejectDialog(
                            title: 'Approve',
                            description:
                                'By approving these clock in and out times, you confirm that you have reviewed the [contractor name]’s  hours. Once approved, the times will be finalized.',
                            onPressedAccept: () {},
                            acceptButtonText: 'Approve',
                            onPressedReject: () {
                              context.router.maybePop();
                            },
                          ).acceptRejectDialog(context);
                        },
                        borderRadius: 7,
                        buttonFontWeight: FontWeight.w600,
                        buttonFontSize: 12,
                        buttonText: 'Approve',
                      ),
                    ),
                    SizedBox(
                      width: getSize(25),
                    ),
                    Expanded(
                      child: CommonButton(
                        height: 34,
                        backgroundColor: Color(0xFFF5F5F5),
                        borderColor: Color(0xFFF5F5F5),
                        buttonTextColor: AppColors.black,
                        onPressed: () {
                          EditClockTimeDialog().editClockTimeDialog(context);
                        },
                        buttonFontWeight: FontWeight.w600,
                        buttonFontSize: 12,
                        borderRadius: 7,
                        buttonText: 'Edit',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getSize(15)),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getSize(10),
                    horizontal: getSize(15),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(getSize(10)),
                  ),
                  child: Row(
                    //ainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: getSize(20),
                        backgroundColor: AppColors.green,
                        child: CircleAvatar(
                          radius: getSize(19),
                          backgroundImage: NetworkImage(
                            'https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg',
                          ),
                        ),
                      ),
                      SizedBox(width: getSize(10)),
                      BaseText(
                        text: 'Rochel Foose',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: getSize(5)),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: getSize(14),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: getSize(8),
                          horizontal: getSize(16),
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.green.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(getSize(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              SvgImageConstant.chat,
                              height: getSize(14),
                              width: getSize(14),
                              colorFilter: ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcATop,
                              ),
                            ),
                            SizedBox(width: getSize(3)),
                            BaseText(
                              text: 'Chat',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
