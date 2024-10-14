import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/my_calendar_view_bloc/my_calendar_view_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/contractor_main/shift/current_shift_dto/current_shift_dto.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_multi_date_picker.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'MyCalendarView')
class MyCalendarView extends StatelessWidget {
  const MyCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyCalendarViewBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.myCalendar,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                numberOfShift(
                  svgPrefixIcon: SvgImageConstant.clockWithOuterLine,
                  title: "${StringConstant.totalNumberOfShifts} - 04",
                  // "${StringConstant.totalNumberOfShifts} - ${(shift.length < 10) ? "0${shift.length}" : shift.length}",
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      getSize(15), getSize(20), getSize(10), getSize(10)),
                  child: BaseText(
                    text: StringConstant
                        .selectEachShiftDateToViewTheUpcomingShift,
                    fontSize: 12,
                  ),
                ),
                calendarView(),
                shiftDetail(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget numberOfShift({
    required String svgPrefixIcon,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(43),
            width: getSize(35),
            child: SvgPicture.asset(
              svgPrefixIcon,
              color: AppColors.primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: SvgPicture.asset(
              SvgImageConstant.verticalLine,
              height: getSize(50),
            ),
          ),
          BaseText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget calendarView() {
    return CustomMultiDatePicker(
      value: [],
      /*dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Color? dynamicColor = getColorForDate(date, state);
        return Container(
          decoration: decoration?.copyWith(
            color: dynamicColor,
          ),
          child: Center(
            child: Text(
              MaterialLocalizations.of(context).formatDecimal(date.day),
              style: textStyle,
            ),
          ),
        );
      },
      */
      /*selectableDayPredicate: (date) {
        final dateExist = isDateExist(selectedDates, date);
        print("dateExist---> $dateExist");

        return dateExist;
      },*/
      onValueChanged: (value) {
        print("setDateUnavailableEvent called!");
        // context.read<SendProposalBloc>().add(SendProposalEvent.setDateUnavailableEvent(value));
      },
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 10),
    );
  }

  Widget shiftDetail(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getSize(10)),
      margin: EdgeInsets.symmetric(vertical: getSize(10)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(20)),
      ),
      child: Column(
        children: [
          userDetail(context, CurrentShiftDTO()),
          paddingBetweenFields(),
          dateAndTime(context, CurrentShiftDTO()),
          paddingBetweenFields(),
          CommonButton(
            onPressed: () {
              context.router.push(
                PageRouteInfo(
                  ViewContractorShift.name,
                  args: ViewContractorShiftArgs(
                    // postId: state.contractorDashboardList[index].id ?? -1,
                    postId: -1,
                    isTotalApplicants: true,
                    fromDashboard: true,
                  ),
                ),
              );
            },
            height: getSize(40),
            borderRadius: 7,
            backgroundColor: AppColors.scaffoldColor,
            buttonTextColor: AppColors.black,
            buttonFontSize: 12,
            buttonText: StringConstant.viewShiftDetails,
          ),
        ],
      ),
    );
  }

  Widget userDetail(BuildContext context, CurrentShiftDTO shift) {
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
              height: getSize(40),
              width: getSize(40),
            ),
            isThreeLine: true,
            title: BaseText(
              text: shift.roles_list_name ?? "",
              textColor: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: shift.company_name ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                BaseText(
                  text:
                      "(${getIndustry(shift.industry_id ?? 0)}  - ${shift.listing_id ?? ''})",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                showUnderDevelopment(context);
              },
              child: SvgPicture.asset(
                SvgImageConstant.chatWithBG,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            minTileHeight: getSize(43.41),
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
                        text: shift.location?.location ?? "",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: shift.distance ?? "",
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

  String getIndustry(int id) {
    OnBoardingDTO industry = CommonList.industryList.firstWhere(
      (item) => item.id == id,
      orElse: () => OnBoardingDTO(),
    );
    return industry.title ?? "";
  }

  Widget paybaleTitleRate(
      {required String title,
      required String value,
      bool isFirst = false,
      isLast = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BaseText(
          text: title,
          fontSize: 12,
          fontWeight: (isLast) ? FontWeight.w600 : FontWeight.w400,
          textColor: AppColors.black.withOpacity(0.7),
        ),
        BaseText(
          text: value,
          fontSize: (isLast) ? 18 : 14,
          fontWeight: (isLast) ? FontWeight.w600 : FontWeight.w400,
          textColor: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget dateAndTime(BuildContext context, CurrentShiftDTO shift) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        displayDateBreak(
          context,
          // boldValue: "12 May,",
          // timidValue: "2024",
          boldValue: convertTimeStampToDate(shift.shift_detail?.date ?? -1),
          timidValue: convertTimeStampToDate(shift.shift_detail?.date ?? -1,
              isYear: true),
          title: StringConstant.shiftDate,
          svgPrefixIcon: SvgImageConstant.calendar,
        ),
        displayTime(
          title: StringConstant.time,
          startDate: (shift.shift_detail?.start_time != null)
              ? DateFormat('hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      (shift.shift_detail?.start_time ?? 0) * 1000))
              : "",
          endDate: (shift.shift_detail?.end_time != null)
              ? DateFormat('hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      (shift.shift_detail?.end_time ?? 0) * 1000))
              : "",
          svgPrefixIcon: SvgImageConstant.clock,
        ),
      ],
    );
  }

  Widget displayDateBreak(
    BuildContext context, {
    required String title,
    required String boldValue,
    required String timidValue,
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
}
