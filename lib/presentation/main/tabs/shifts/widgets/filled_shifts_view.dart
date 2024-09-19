import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dropdown/custom_dropdown_textfield.dart';

@RoutePage(name: 'FilledShiftsView')
class FilledShiftsView extends StatelessWidget {
  const FilledShiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftsBloc, ShiftsBlocState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getSize(15),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(20)),
              child: BaseText(
                text: 'Sort by',
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: getSize(8),
            ),
            locationAddressTextField(context, state),
            Expanded(
              child: ListView.builder(
                itemCount: 50,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(20),
                  vertical: getSize(12.5),
                ),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical:
                            getSize(index == 0 || index == 49 ? 0 : 12.5)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            BaseText(
                                              text: "CT Technologist",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            Spacer(),
                                            Container(
                                              alignment: Alignment.center,
                                              height: getSize(28),
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        getSize(5)),
                                              ),
                                              width: getSize(28),
                                              child: SvgPicture.asset(
                                                SvgImageConstant.delete,
                                                colorFilter: ColorFilter.mode(
                                                    AppColors.black,
                                                    BlendMode.srcATop),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: getSize(3)),
                                        BaseText(
                                          text: '(Healthcare - 2DFG125)',
                                          fontSize: 12,
                                          textColor: const Color.fromARGB(
                                                  255, 55, 46, 46)
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
                                    text:
                                        '4517 Washington Manchester, Kentucky 39495',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
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
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: getSize(8),
                                  // horizontal: getSize(20),
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.scaffoldColor,
                                  borderRadius:
                                      BorderRadius.circular(getSize(7)),
                                ),
                                child: BaseText(
                                  text: 'View shift Details',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getSize(10)),
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
                              //   getRevokingWidget(),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(SvgImageConstant.chat)
                                  ],
                                ),
                              )
                              //revokingWidget()
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget locationAddressTextField(
    BuildContext context,
    ShiftsBlocState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: CustomDropdownTextfield(
        valueController: state.singleValueDropDownController,
        list: state.locationList,
        hintText: 'Location',
        validator: (p0) {
          if (p0 == null || p0.isEmpty) {
            return 'Please select location';
          } else {
            return null;
          }
        },
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getSize(14),
            vertical: getSize(14),
          ),
          child: SvgPicture.asset(
            SvgImageConstant.locationIcon,
          ),
        ),
      ),
    );
  }
}
