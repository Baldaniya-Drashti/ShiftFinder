import 'package:auto_route/auto_route.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_shift/employer_shift_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/delete_shift_dialog.dart';

@RoutePage(name: 'FilledShiftsView')
class FilledShiftsView extends StatelessWidget {
  const FilledShiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftsBloc, ShiftsBlocState>(
      builder: (context, state) {
        return state.getDataLoading
            ? CenterLoadingIndicator(isOnlyLoader: true)
            : state.errorApi
                ? Center(
                    child: BaseText(text: StringConstant.somethindWentWrong))
                : Column(
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
                      SizedBox(height: getSize(8)),
                      sortingField(context, state),
                      SizedBox(height: getSize(12)),
                      Expanded(
                        child: PaginatedListView(
                          onRefresh: () => ShiftsBlocEvent.fetchFilledShiftList(
                              refresh: true),
                          onLoading: () => ShiftsBlocEvent.fetchFilledShiftList(
                              refresh: false),
                          refreshController: context
                              .read<ShiftsBloc>()
                              .filledRefreshController,
                          isNoDataFound: state.noDataFound,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Gap(16),
                            itemCount: state.filledShiftList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: getSize(10),
                                vertical: getSize(12.5)),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final industry = CommonList.industryList
                                  .firstWhere((element) =>
                                      element.id ==
                                      state.filledShiftList[index].industry);

                              return Container(
                                padding: EdgeInsets.all(getSize(10)),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.circular(getSize(20)),
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
                                        borderRadius:
                                            BorderRadius.circular(getSize(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: getSize(25),
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Image.asset(
                                                    PngImageConstants.nurse2),
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
                                                          text: state
                                                                  .filledShiftList[
                                                                      index]
                                                                  .roles_list_name ??
                                                              "",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            DeleteShiftDialog()
                                                                .deleteShiftDialog(
                                                                    context);
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: getSize(28),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          getSize(
                                                                              5)),
                                                            ),
                                                            width: getSize(28),
                                                            child: SvgPicture
                                                                .asset(
                                                              height: 16,
                                                              SvgImageConstant
                                                                  .delete,
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      AppColors
                                                                          .black,
                                                                      BlendMode
                                                                          .srcATop),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height: getSize(3)),
                                                    BaseText(
                                                      text:
                                                          '(${industry.title ?? ""} - ${state.filledShiftList[index].listing_id ?? ""})',
                                                      fontSize: 12,
                                                      textColor: AppColors.black
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
                                            color: AppColors.black
                                                .withOpacity(0.2),
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
                                                text: state
                                                        .filledShiftList[index]
                                                        .location
                                                        ?.location ??
                                                    "",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: getSize(10)),
                                    dateAndTime(
                                        context, state.filledShiftList[index]),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: getSize(10),
                                        horizontal: getSize(15),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.scaffoldColor,
                                        borderRadius:
                                            BorderRadius.circular(getSize(10)),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          context.router.push(
                                            PageRouteInfo(
                                                ViewApplicantProfile.name),
                                          );
                                        },
                                        child: Row(
                                          //ainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              radius: getSize(20),
                                              backgroundColor: AppColors.green,
                                              child: CircleAvatar(
                                                radius: getSize(19),
                                                backgroundImage: NetworkImage(
                                                    state
                                                            .filledShiftList[
                                                                index]
                                                            .user
                                                            ?.profileImage ??
                                                        ""),
                                              ),
                                            ),
                                            SizedBox(width: getSize(10)),
                                            BaseText(
                                              text:
                                                  '${state.filledShiftList[index].user?.firstName ?? ""} ${state.filledShiftList[index].user?.lastName ?? ""}',
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
                                                color: AppColors.green
                                                    .withOpacity(0.15),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        getSize(8)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    SvgImageConstant.chat,
                                                    height: getSize(14),
                                                    width: getSize(14),
                                                    colorFilter:
                                                        ColorFilter.mode(
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
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
      },
    );
  }

  Widget dateAndTime(BuildContext context, EmployerShiftDto shift) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            displayDateBreak(
              context,
              // boldValue: "12 May,",
              // timidValue: "2024",
              boldValue: convertTimeStampToDate(shift.start_date ?? -1),
              timidValue:
                  convertTimeStampToDate(shift.start_date ?? -1, isYear: true),
              title: StringConstant.shiftDate,
              svgPrefixIcon: SvgImageConstant.calendar,
            ),
            displayTime(
              title: StringConstant.time,
              startDate: (shift.start_time != null)
                  ? DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          (shift.start_time ?? 0) * 1000))
                  : "",
              endDate: (shift.end_time != null)
                  ? DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          (shift.end_time ?? 0) * 1000))
                  : "",
              svgPrefixIcon: SvgImageConstant.clock,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            displayDateBreak(
              context,
              boldValue: "\$${shift.estimated_payables ?? ""}",
              timidValue: "",
              title: StringConstant.estimatedPayables,
              svgPrefixIcon: SvgImageConstant.dollorRound,
            ),
            displayDateBreak(
              context,
              boldValue: "",
              timidValue: "",
              title: "",
              svgPrefixIcon: "",
              showBtn: true,
              onBtnPressed: () {
                context.router.push(
                  PageRouteInfo(
                    ViewContractorShift.name,
                    args: ViewContractorShiftArgs(
                      postId: shift.id ?? -1,
                      isTotalApplicants: true,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget displayTime({
    required String title,
    required String startDate,
    required String endDate,
    required String svgPrefixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            svgPrefixIcon,
            color: AppColors.black,
            height: getSize(20),
            width: getSize(16),
          ),
          SizedBox(width: getSize(10)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: StringConstant.time,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                textColor: AppColors.black.withOpacity(0.7),
              ),
              Row(
                children: [
                  BaseText(
                    text: startDate,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black.withOpacity(0.7),
                  ),
                  BaseText(
                    text: ' to ',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.black.withOpacity(0.7),
                  ),
                  BaseText(
                    text: endDate,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String convertTimeStampToDate(int timestamp,
      {bool isYear = false, bool isTime = false}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    if (isTime) {
      return DateFormat('hh:mm a').format(dateTime);
    } else {
      if (isYear) {
        return DateFormat('yyyy').format(dateTime);
      } else {
        return DateFormat('d MMM, ').format(dateTime);
      }
    }
  }

  Widget displayDateBreak(BuildContext context,
      {required String title,
      required String boldValue,
      required String timidValue,
      required String svgPrefixIcon,
      bool showBtn = false,
      void Function()? onBtnPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: (showBtn)
          ? CommonButton(
              onPressed: onBtnPressed ??
                  () {
                    /*if (post.shift_detail != null) {
                          context.router.push(PageRouteInfo(ViewDates.name,
                              args: ViewDatesArgs(
                                  shiftDetail: post.shift_detail!)));
                        }*/
                  },
              width: 160,
              height: 34,
              borderRadius: 5,
              buttonFontSize: 12,
              buttonFontWeight: FontWeight.w600,
              buttonText: StringConstant.viewDetails,
              buttonTextColor: AppColors.black,
              backgroundColor: AppColors.scaffoldColor,
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  svgPrefixIcon,
                  color: AppColors.black,
                  height: getSize(20),
                  width: getSize(16),
                ),
                SizedBox(width: getSize(10)),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      text: title,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.black.withOpacity(0.7),
                    ),
                    highLightText(boldValue: boldValue, timidValue: timidValue),
                  ],
                ),
              ],
            ),
    );
  }

  Widget highLightText(
      {required String boldValue,
      required String timidValue,
      String? thirdValue}) {
    return RichText(
        text: TextSpan(
      text: boldValue,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      children: [
        TextSpan(
          text: timidValue,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black.withOpacity(0.5),
          ),
        ),
        TextSpan(
          text: thirdValue ?? "",
        ),
      ],
    ));
  }

  Widget sortingField(
    BuildContext context,
    ShiftsBlocState state,
  ) {
    /*return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: CustomDropdownTextfield(
        valueController: state.singleValueDropDownController,
        list: state.locationList,
        hintText: StringConstant.location,
        onChanged: (p0) {
          print(p0);
          final data = p0 as DropDownValueModel;
          context.read<ShiftsBloc>().add(ShiftsBlocEvent.onChangeSortBy(
              SingleValueDropDownController(data: data)));
        },
        prefixIcon: Center(
          widthFactor: 1,
          child: SvgPicture.asset(
            SvgImageConstant.locationIcon,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
            height: 16,
            width: 16,
          ),
        ),
      ),
    );*/
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: CustomDropdownField(
          onChanged: (value) {
            // if (value != null) {
            context
                .read<ShiftsBloc>()
                .add(ShiftsBlocEvent.onFilledSorting(value ?? LocationDTO()));
            // }
          },
          hintText: StringConstant.location,
          value: (state.currentFilledFilter.location != null &&
                  state.currentFilledFilter.location!.isNotEmpty)
              ? state.currentFilledFilter
              : null,
          items: state.locationList.map((val) {
            return DropdownMenuItem<LocationDTO>(
              value: val,
              child: BaseText(
                text: val.location ?? "",
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
