import 'package:auto_route/auto_route.dart';
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
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
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
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getSize(18))
                              .copyWith(top: getSize(10)),
                          child: BaseText(
                            text: StringConstant.sortBy,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        sortingField(context, state),
                        Expanded(
                          child: PaginatedListView(
                            onRefresh: () => context.read<ShiftsBloc>().add(
                                ShiftsBlocEvent.fetchFilledShiftList(
                                    refresh: true)),
                            onLoading: () => context.read<ShiftsBloc>().add(
                                ShiftsBlocEvent.fetchFilledShiftList(
                                    refresh: false)),
                            refreshController: context
                                .read<ShiftsBloc>()
                                .filledRefreshController,
                            isNoDataFound: state.noDataFound,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => Gap(16),
                              itemCount: state.filledShiftList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  vertical: getSize(10),
                                  horizontal: getSize(10)),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return shiftBox(
                                    context, state.filledShiftList[index]);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
      },
    );
  }

  shiftBox(BuildContext context, EmployerShiftDto shift) {
    return Container(
      padding: EdgeInsets.all(getSize(10)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey.withOpacity(0.2),
            blurRadius: getSize(20),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          userDetail(context, shift),
          SizedBox(height: getSize(10)),
          if (shift.shift_type != null &&
              shift.shift_type == 2 &&
              shift.remaining_shift != null &&
              shift.remaining_shift! > 0)
            remainingTime(context, shift),
          dateAndTime(context, shift),
          (shift.total_user == 1)
              ? Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getSize(10),
                    horizontal: getSize(15),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(getSize(10)),
                  ),
                  child: InkWell(
                    onTap: () {
                      context.router.push(
                        PageRouteInfo(
                          ViewApplicantProfile.name,
                          args: ViewApplicantProfileArgs(
                            id: shift.user?.user_id ?? -1,
                            postId: shift.id ?? -1,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.transparent,
                          radius: getSize(20),
                          backgroundImage: (shift.user != null &&
                                  shift.user!.profile != null &&
                                  shift.user!.profile!.isNotEmpty)
                              ? NetworkImage(shift.user?.profile ?? "")
                              : null,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getSize(10), right: getSize(5)),
                          child: BaseText(
                            text:
                                "${shift.user?.first_name ?? ""} ${shift.user?.last_name ?? ""}",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: getSize(14),
                        ),
                        Spacer(),
                        CommonButton(
                          height: 35,
                          width: 85,
                          borderRadius: 5,
                          onPressed: () {
                            showUnderDevelopment(context);
                          },
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.15),
                          buttonText: "",
                          customWidget: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                SvgImageConstant.chat,
                                color: AppColors.black,
                                height: getSize(15),
                                width: getSize(15),
                              ),
                              SizedBox(width: getSize(5)),
                              BaseText(
                                text: StringConstant.chat,
                                fontWeight: FontWeight.w600,
                                fontSize: getFontSize(12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getSize(10),
                    horizontal: getSize(15),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(getSize(10)),
                  ),
                  child: InkWell(
                    onTap: () {
                      context.router.push(PageRouteInfo(
                          FilledHiredContractorList.name,
                          args: FilledHiredContractorListArgs(
                              postId: shift.id ?? -1)));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.transparent,
                          radius: getSize(20),
                          child: SvgPicture.asset(
                            SvgImageConstant.threePersonCircle,
                          ),
                        ),
                        SizedBox(width: getSize(10)),
                        BaseText(
                          text:
                              "${StringConstant.allHiredContractors} (${shift.hired_user}/${shift.total_user})",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: getSize(16),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget userDetail(BuildContext context, EmployerShiftDto shift) {
    final industry = CommonList.industryList
        .firstWhere((element) => element.id == shift.industry);
    return Container(
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
                radius: getSize(25),
                backgroundColor: Colors.transparent,
                child: Image.asset(PngImageConstants.nurse2),
              ),
              SizedBox(width: getSize(15)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: BaseText(
                            text: shift.roles_list_name ?? "",
                            fontSize: 16,
                            maxLines: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            DeleteShiftDialog(
                              showCADDesc: shift.isCad ?? false,
                              showDelete: shift.isdelete ?? false,
                              postId: shift.id ?? -1,
                            ).deleteShiftDialog(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: getSize(28),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(getSize(5)),
                            ),
                            width: getSize(28),
                            child: SvgPicture.asset(
                              height: 16,
                              SvgImageConstant.delete,
                              colorFilter: ColorFilter.mode(
                                  AppColors.black, BlendMode.srcATop),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getSize(3)),
                    BaseText(
                      text:
                          '(${industry.title ?? ""} - ${shift.listing_id ?? ""})',
                      fontSize: 12,
                      textColor: AppColors.black.withOpacity(0.8),
                    ),
                    BaseText(
                      text: shift.location?.facility_type?.name ?? "",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
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
          GestureDetector(
            onTap: () {
              final location = shift.location;
              final latitude = location?.latitude;
              final longitude = location?.longitude;
              if (latitude != null && longitude != null) {
                context.router.push(
                  PageRouteInfo(
                    ShowGoogleMap.name,
                    args: ShowGoogleMapArgs(
                      latitude: latitude,
                      longitude: longitude,
                    ),
                  ),
                );
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgImageConstant.location,
                  colorFilter: ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcATop,
                  ),
                ),
                SizedBox(width: getSize(5)),
                Expanded(
                  child: BaseText(
                    text: shift.location?.location ?? "",
                    fontSize: 10,
                    maxLines: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget remainingTime(BuildContext context, EmployerShiftDto shift) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getSize(10),
        horizontal: getSize(15),
      ),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Row(
        children: [
          BaseText(
            text: StringConstant.remainingShifts,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          Spacer(),
          BaseText(
            text: (shift.remaining_shift! > 9)
                ? "${shift.remaining_shift ?? 0}"
                : "0${shift.remaining_shift}",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget dateAndTime(BuildContext context, EmployerShiftDto shift) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (shift.shift_type == 1)
                  ? displayDateBreak(
                      context,
                      boldValue: convertTimeStampToDate(shift.start_date ?? -1),
                      timidValue: convertTimeStampToDate(shift.start_date ?? -1,
                          isYear: true),
                      title: StringConstant.shiftDate,
                      svgPrefixIcon: SvgImageConstant.calendar,
                    )
                  : displayDateBreak(
                      context,
                      boldValue:
                          "${shift.total_shifts ?? 0} ${((shift.total_shifts ?? 0) > 1) ? "Shifts" : "Shift"}",
                      timidValue: "",
                      title: StringConstant.totalShifts,
                      svgPrefixIcon: SvgImageConstant.calendar,
                    ),
              displayDateBreak(
                context,
                boldValue: "\$${shift.formatted_payables ?? 0.0}",
                timidValue: "",
                title: StringConstant.estimatedPayables,
                svgPrefixIcon: SvgImageConstant.dollorRound,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 13,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              (shift.shift_type == 1 && shift.total_user == 1)
                  ? displayTime(
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
                    )
                  : (shift.shift_type == 1)
                      ? displayDateBreak(
                          context,
                          boldValue: shift.unpaid_break ?? "",
                          timidValue: "",
                          title: StringConstant.unpaidBreak,
                          svgPrefixIcon: SvgImageConstant.clock,
                        )
                      : displayDateBreak(
                          context,
                          boldValue:
                              convertTimeStampToDate(shift.start_date ?? -1),
                          timidValue: convertTimeStampToDate(
                            shift.start_date ?? -1,
                            isYear: true,
                          ),
                          title: StringConstant.shiftStartDate,
                          svgPrefixIcon: SvgImageConstant.calendar,
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
                      ViewHomeShiftDetails.name,
                      args: ViewHomeShiftDetailsArgs(
                        postId: shift.id ?? -1,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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
        mainAxisAlignment: MainAxisAlignment.end,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black,
                  ),
                  BaseText(
                    text: ' to ',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.black,
                  ),
                  BaseText(
                    text: endDate,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black,
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
              onPressed: onBtnPressed ?? () {},
              // width: 160,
              height: 34,
              borderRadius: 5,
              buttonFontSize: 12,
              buttonFontWeight: FontWeight.w600,
              buttonText: StringConstant.viewDetails,
              buttonTextColor: AppColors.black,
              backgroundColor: AppColors.scaffoldColor,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  svgPrefixIcon,
                  color: AppColors.black,
                  height: getSize(20),
                  width: getSize(16),
                ),
                SizedBox(width: getSize(10)),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: title,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.black.withOpacity(0.7),
                      ),
                      highLightText(
                          boldValue: boldValue, timidValue: timidValue),
                    ],
                  ),
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
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: boldValue,
          style: TextStyle(
            fontSize: getFontSize(13),
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          children: [
            TextSpan(
              text: timidValue,
              style: TextStyle(
                fontSize: getFontSize(13),
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
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: getSize(10), horizontal: getSize(10)),
      child: CustomDropdownField(
        onChanged: (value) {
          if (value != null) {
            context
                .read<ShiftsBloc>()
                .add(ShiftsBlocEvent.onFilledSorting(value ?? LocationDTO()));
          }
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
              maxLines: 1,
              textColor: AppColors.black,
            ),
          );
        }).toList(),
      ),
    );
  }
}
