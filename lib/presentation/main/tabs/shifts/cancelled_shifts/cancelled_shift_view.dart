import 'package:auto_route/auto_route.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/enum.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/dropdown/custom_dropdown_textfield.dart';

class CancelledShiftView extends StatelessWidget {
  const CancelledShiftView({super.key});

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
                text: StringConstant.sortBy,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: getSize(8),
            ),
            // sortByYou(context, state),
            sortingField(context, state),
            SizedBox(
              height: getSize(8),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(20)),
              child: BaseText(
                text: StringConstant.sortBy,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: getSize(8),
            ),
            locationAddressTextField(context, state),
            SizedBox(
              height: getSize(12),
            ),
            if (state.currentCancelFilter.id == 1) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16).copyWith(top: 0),
                  child: PaginatedListView(
                    onRefresh: () {},
                    onLoading: () {},
                    refreshController: RefreshController(),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 5,
                      separatorBuilder: (context, index) => SizedBox(
                        height: getSize(12),
                      ),
                      itemBuilder: (context, index) => _CanceledByYouListTile(),
                    ),
                  ),
                ),
              )
            ] else ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16).copyWith(top: 0),
                  child: PaginatedListView(
                    onRefresh: () {},
                    onLoading: () {},
                    refreshController: RefreshController(),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 5,
                      separatorBuilder: (context, index) => SizedBox(
                        height: getSize(12),
                      ),
                      itemBuilder: (context, index) =>
                          _WithdrawnByContractorTile(),
                    ),
                  ),
                ),
              )
            ]
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
        valueController: state.cancelledShiftSortByLocationController,
        // list: state.locationList,
        list: [],
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
            vertical: getSize(16),
          ),
          child: SvgPicture.asset(
            SvgImageConstant.locationIcon,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
            height: getSize(15),
            width: getSize(15),
          ),
        ),
      ),
    );
  }

  /*Widget sortByYou(
    BuildContext context,
    ShiftsBlocState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: CustomDropdownTextfield(
        onChanged: (p0) {
          final data = p0 as DropDownValueModel;
          context.read<ShiftsBloc>().add(ShiftsBlocEvent.onChangeSortBy(
              SingleValueDropDownController(data: data)));
        },
        valueController: state.cancelledShiftSortByController,
        list: [
          DropDownValueModel(name: "Cancelled by You", value: 1),
          DropDownValueModel(name: "Withdrawn by contractor", value: 2),
        ],
        hintText: StringConstant.cancle,
      ),
    );
  }*/

  Widget sortingField(
    BuildContext context,
    ShiftsBlocState state,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: CustomDropdownField(
          onChanged: (value) {
            print("jbvdjvdjb--> $value");
            if (value != null) {
              context.read<ShiftsBloc>().add(
                  ShiftsBlocEvent.onCancelTypeSorting(value ?? SkillDTO()));
            }
          },
          hintText: StringConstant.location,
          value: null,
          // value: state.currentFilledFilter,
          items: CommonList.cancelSortingList.map((val) {
            return DropdownMenuItem<SkillDTO>(
              value: val,
              child: BaseText(
                text: val.name ?? "",
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _CanceledByYouListTile extends StatelessWidget {
  const _CanceledByYouListTile();

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(getSize(20)),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(getSize(14)),
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
                              text: "CT Technologist",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            BaseText(
                              text: "(Healthcare - 2DFG125)",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
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
                        SvgPicture.asset(SvgImageConstant.location,
                            color: Colors.black, height: 24, width: 24),
                        SizedBox(
                          width: getSize(6),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BaseText(
                                text:
                                    "4517 Washington Manchester, Kentucky 39495",
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
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
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        height: 14,
                        width: 14,
                        SvgImageConstant.calendar,
                        colorFilter: ColorFilter.mode(
                            AppColors.black.withOpacity(0.7), BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: getSize(6),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                            text: "Shift Date",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          Text.rich(
                            style: TextStyle(fontSize: 12),
                            TextSpan(
                              text: "12 May, ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: "2024",
                                    style: TextStyle(
                                        color:
                                            AppColors.black.withOpacity(0.5))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        height: 14,
                        width: 14,
                        SvgImageConstant.clock,
                        colorFilter: ColorFilter.mode(
                            AppColors.black.withOpacity(0.7), BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: getSize(6),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                            text: "Time",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          BaseText(
                            text: '09:15 AM to 07:30 PM',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: getSize(14),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        height: 14,
                        width: 14,
                        SvgImageConstant.dollorRound,
                        colorFilter: ColorFilter.mode(
                            AppColors.black.withOpacity(0.7), BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: getSize(6),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                            text: "Compassion",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          BaseText(
                            text: '\$150',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CommonButton(
                    height: 34,
                    onPressed: () {
                      context.router.push(
                        PageRouteInfo(
                          ViewHomeShiftDetails.name,
                          args: ViewHomeShiftDetailsArgs(
                              postId: 485,
                              route: ShiftDetailRoute.employerCancelledShift),
                        ),
                      );
                    },
                    buttonText: "View Detail",
                    backgroundColor: AppColors.scaffoldColor,
                    borderRadius: 7,
                    buttonTextColor: Colors.black,
                    buttonFontSize: 12,
                    buttonFontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(
              height: getSize(15),
            ),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(getSize(7)),
              color: AppColors.scaffoldColor,
              child: InkWell(
                onTap: () {
                  context.router.push(
                    PageRouteInfo(ViewApplicantProfile.name),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getSize(15), vertical: getSize(10)),
                  child: Row(
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
                      SizedBox(
                        width: getSize(12),
                      ),
                      Expanded(
                          child: BaseText(
                        text: "Rochel Foose",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                      SvgPicture.asset(
                        SvgImageConstant.rightArrow,
                        height: getSize(13),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _WithdrawnByContractorTile extends StatelessWidget {
  const _WithdrawnByContractorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(getSize(20)),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(getSize(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              text: "CT Technologist",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            BaseText(
                              text: "(Healthcare - 2DFG125)",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
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
                        SvgPicture.asset(SvgImageConstant.location,
                            color: Colors.black, height: 24, width: 24),
                        SizedBox(
                          width: getSize(6),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BaseText(
                                text:
                                    "4517 Washington Manchester, Kentucky 39495",
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
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
              buttonText: "View shift Details",
              height: 34,
              borderRadius: 7.0,
              buttonFontSize: 12,
              buttonTextColor: AppColors.black,
              buttonFontWeight: FontWeight.w600,
              backgroundColor: AppColors.green.withOpacity(0.1),
            ),
            SizedBox(
              height: getSize(12),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        height: 14,
                        width: 14,
                        SvgImageConstant.calendar,
                        colorFilter: ColorFilter.mode(
                            AppColors.black.withOpacity(0.7), BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: getSize(6),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                            text: "Shift Date",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          Text.rich(
                            style: TextStyle(fontSize: 12),
                            TextSpan(
                              text: "12 May, ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: "2024",
                                    style: TextStyle(
                                        color:
                                            AppColors.black.withOpacity(0.5))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        height: 14,
                        width: 14,
                        SvgImageConstant.clock,
                        colorFilter: ColorFilter.mode(
                            AppColors.black.withOpacity(0.7), BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: getSize(6),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                            text: "Time",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          BaseText(
                            text: '09:15 AM to 07:30 PM',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: getSize(14),
            ),
            BaseText(
              text: "Reason",
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: getSize(8),
            ),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.scaffoldColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BaseText(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                ),
              ),
            ),
            SizedBox(
              height: getSize(14),
            ),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(getSize(7)),
              color: AppColors.scaffoldColor,
              child: InkWell(
                onTap: () {
                  context.router.push(
                    PageRouteInfo(ViewApplicantProfile.name),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getSize(15), vertical: getSize(10)),
                  child: Row(
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
                      SizedBox(
                        width: getSize(12),
                      ),
                      Expanded(
                          child: BaseText(
                        text: "Rochel Foose",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                      SvgPicture.asset(
                        SvgImageConstant.rightArrow,
                        height: getSize(13),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
