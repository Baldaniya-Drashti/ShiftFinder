import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
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
              borderRadius: BorderRadius.circular(getSize(20)),
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
                          radius: 24,
                          backgroundColor: AppColors.darkGreen,
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
                            SizedBox(
                              height: getSize(3),
                            ),
                            BaseText(
                              text: "CT Technologist",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
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
                                fontWeight: FontWeight.w600,
                                fontSize: getSize(13),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              BaseText(
                                text: "10.2 Km Away",
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.green,
                                fontSize: getSize(12),
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
              onPressed: () {},
              buttonText: "View Profile",
              backgroundColor: AppColors.scaffoldColor,
              borderRadius: getSize(16),
              buttonTextColor: Colors.black,
              buttonFontSize: getSize(16),
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
                      SvgPicture.asset(SvgImageConstant.calendar, height: 20, width: 20, color: AppColors.black.withOpacity(0.6)),
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
                              fontSize: getSize(13),
                              textColor: AppColors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w600,
                            ),
                            Text.rich(
                              style: TextStyle(fontSize: getSize(14)),
                              TextSpan(
                                text: "12 May, ",
                                style: TextStyle(fontWeight: FontWeight.w600),
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
                      SvgPicture.asset(SvgImageConstant.clock, height: 20, width: 20, color: AppColors.black.withOpacity(0.6)),
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
                              fontSize: getSize(13),
                              textColor: AppColors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w600,
                            ),
                            BaseText(
                              text: "09:15 AM to 07:30 PM",
                              fontSize: getSize(14),
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
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
              borderRadius: BorderRadius.all(Radius.circular(getSize(16))),
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
                          onTap: () {},
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
      child: ElevatedButton.icon(
        icon: Center(
            child: SvgPicture.asset(
          icon,
          height: 18,
          width: 18,
        )),
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        label: BaseText(
          text: label,
          fontWeight: FontWeight.w600,
          fontSize: getSize(13),
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
          height: 40,
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
            icon: SvgPicture.asset(
              color: AppColors.black,
              SvgImageConstant.downArrow,
              height: 8,
              width: 6,
            ),
            iconSize: 8,
            value: value,
            decoration: InputDecoration(
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
