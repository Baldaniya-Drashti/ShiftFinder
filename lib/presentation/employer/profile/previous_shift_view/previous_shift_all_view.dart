import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class PreviousShiftAllView extends StatelessWidget {
  const PreviousShiftAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(getSize(16)),
      child: Column(
        children: [
          _RatingDropdown(
            onChanged: (double value) {},
            value: 5.0,
          ),
          SizedBox(
            height: getSize(22),
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) => _PreviousShiftAllListTile(),
            separatorBuilder: (context, index) => SizedBox(
              height: getSize(18),
            ),
          )
        ],
      ),
    );
  }
}

class _PreviousShiftAllListTile extends StatelessWidget {
  const _PreviousShiftAllListTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(20)),
        color: AppColors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(getSize(15)),
        child: Column(
          children: [
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(getSize(10)),
              color: AppColors.scaffoldColor,
              child: Padding(
                padding: EdgeInsets.all(getSize(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          CircleAvatar(
                          radius: getSize(25),
                          backgroundColor: AppColors.green,
                          child: CircleAvatar(
                            radius: getSize(24),
                            backgroundImage: NetworkImage(
                              'https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getSize(12),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BaseText(
                              text: "Rochel Foose",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),

                            BaseText(
                              text: "CT Technologist",
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(SvgImageConstant.star),
                                SizedBox(width: getSize(8)),
                                BaseText(text: "4.5", fontSize: 12, fontWeight: FontWeight.w600),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: getSize(8),
                    ),
                    Divider(),
                    SizedBox(
                      height: getSize(3),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(SvgImageConstant.location, color: Colors.black, height: 24, width: 24),
                        SizedBox(
                          width: getSize(6),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BaseText(
                                text: "4517 Washington Manchester, Kentucky 39495",
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              BaseText(
                                text: "10.2 Km Away",
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.green,
                                fontSize: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getSize(12),
            ),
            CommonButton(
              height: 38,
              onPressed: () {
                context.router.push(
                  PageRouteInfo(
                    ViewApplicantProfile.name,
                  ),
                );
              },
              buttonText: "View Profile",
              backgroundColor: AppColors.scaffoldColor,
              borderRadius: 7,
              buttonTextColor: Colors.black,
              buttonFontSize: 12,
              buttonFontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: getSize(12),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      SvgPicture.asset(SvgImageConstant.calendar, height: 15, width: 15, color: AppColors.black.withOpacity(0.6)),
                      SizedBox(
                        width: getSize(8),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BaseText(
                              text: "Last Worked Date",
                              fontSize: getSize(10),
                              textColor: AppColors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                            ),
                            Text.rich(
                              style: TextStyle(fontSize: 12),
                              TextSpan(
                                text: "12 May, ",
                                style: TextStyle(fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(text: "2024", style: TextStyle(color: AppColors.black.withOpacity(0.5))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      SvgPicture.asset(SvgImageConstant.clock, height: 15, width: 15, color: AppColors.black.withOpacity(0.6)),
                      SizedBox(
                        width: getSize(8),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BaseText(
                              text: "Time",
                              fontSize: getSize(10),
                              textColor: AppColors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                            ),
                            BaseText(
                              text: '09:15 AM to 07:30 PM',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getSize(12),
            ),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(getSize(10))),
              color: AppColors.scaffoldColor,
              child: Padding(
                padding: EdgeInsets.all(getSize(16)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _IconButton(
                          label: "Add to Favorite",
                          icon: SvgImageConstant.heart1,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: getSize(8),
                        ),
                        _IconButton(
                          label: "Leave a Rating",
                          icon: SvgImageConstant.starOutlined,
                          onTap: () {
                            int selectedStar = 5;

                            AppDialog.showSuccess(
                              context,
                              image: Image.asset(PngImageConstants.leaveRating),
                              title: "Leave a Rating!",
                              otherContent: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: getSize(25),
                                  ),
                                  Center(
                                    widthFactor: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                        5 * 2,
                                        (index) {
                                          if (index % 2 == 0) return SizedBox(width: getSize(16));
                                          return SvgPicture.asset(
                                            SvgImageConstant.starOutlined,
                                            height: 35,
                                            width: 35,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              infoMessage:
                                  "Your feedback is valuable! Please rate [contractor name] to help showcase their performance and maintain service quality.",
                              onOkClick: () {},
                              buttonText: "Submit",
                            );
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    Row(
                      children: [
                        _IconButton(
                          label: "Remark",
                          icon: SvgImageConstant.medalStar,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: getSize(8),
                        ),
                        _IconButton(
                          label: "Block",
                          icon: SvgImageConstant.block,
                          onTap: () {
                            AppDialog.showDelete(
                              deleteBtnText: "Block",
                              deleteColor: AppColors.redAccent,
                              title: "Block",
                              context,
                              infoMessage:
                                  "Blocking [contractor name] will prevent them from seeing any future postings. Are you sure you want to proceed?",
                              onCancelClick: () {
                                Navigator.pop(context);
                              },
                              onDeleteClick: () {},
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  final String label;
  final String icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0.0,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(7))),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(getSize(8)),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(icon, height: getSize(14), width: getSize(14)),
                  SizedBox(
                    width: getSize(5),
                  ),
                  BaseText(
                    text: label,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return Expanded(
      child: ElevatedButton.icon(
        icon: Center(
          child: SvgPicture.asset(
            icon,
            height: 14,
            width: 14,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        label: BaseText(
          text: label,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _RatingDropdown extends StatelessWidget {
  const _RatingDropdown({
    super.key,
    required this.onChanged,
    required this.value,
  });

  final ValueSetter<double> onChanged;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseText(
          text: "Sort by",
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: getSize(7)),
        Container(

          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(getSize(10)),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGrey.withOpacity(0.2),
                blurRadius: 30,
              )
            ],
          ),
          child: DropdownButtonFormField(
            isDense: true,
            icon: SvgPicture.asset(
              color: AppColors.black,
              SvgImageConstant.downArrow,
              height: 8,
              width: 6,
            ),
            iconSize: 8,
            value: value,
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: getSize(12),
                horizontal: getSize(20),
              ),
            ),
            dropdownColor: AppColors.white,
            elevation: 5,
            items: [5.0, 4.0, 3.0, 2.0, 1.0]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(SvgImageConstant.star),
                        SizedBox(
                          width: getSize(8),
                        ),
                        BaseText(
                          text: e.toString(),
                          fontWeight: FontWeight.w600,
                          fontSize: getSize(15),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              onChanged(value!);
            },
          ),
        ),
      ],
    );
  }
}
