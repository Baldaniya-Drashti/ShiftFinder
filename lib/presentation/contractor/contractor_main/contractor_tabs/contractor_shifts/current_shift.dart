import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/contractor_main/shift/current_shift_dto/current_shift_dto.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class CurrentShift extends StatefulWidget {
  const CurrentShift({super.key});

  @override
  State<CurrentShift> createState() => _CurrentShiftState();
}

class _CurrentShiftState extends State<CurrentShift> {
  @override
  void initState() {
    super.initState();
    context
        .read<ContractorShiftBloc>()
        .add(ContractorShiftEvent.getCurrentShiftDetailAPI(true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
      builder: (context, state) {
        return (state.isLoading)
            ? CenterLoadingIndicator(isOnlyLoader: true)
            : ListView.builder(
                itemCount: state.currentShiftList.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                itemBuilder: (context, index) {
                  final shift = state.currentShiftList[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: getSize(12)),
                    padding: EdgeInsets.all(getSize(10)),
                    width: getSize(355),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(getSize(20)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.2),
                          blurRadius: 25,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        userDetail(context, shift),
                        paddingBetweenFields(),
                        numberOfVacancy(
                            value:
                                // "${shift.shift_detail?.number_of_vacancie ?? 0}"),
                                "${(shift.shift_detail?.number_of_vacancie.toString().length == 2) ? shift.shift_detail?.number_of_vacancie : "0${shift.shift_detail?.number_of_vacancie}"}"),
                        paddingBetweenFields(),
                        dateAndTime(context, shift),
                        paddingBetweenFields(),
                        clockIn(context, index, state),
                        paddingBetweenFields(),
                        clockOut(),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 10),
    );
  }

  Widget dateAndTime(BuildContext context, CurrentShiftDTO shift) {
    return Column(
      children: [
        Row(
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
              startDate: "07:15 AM",
              endDate: "18:30 AM",
              svgPrefixIcon: SvgImageConstant.clock,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            displayDateBreak(
              context,
              boldValue:
                  "\$${shift.shift_detail?.payables?.total_amount_payable ?? ""}",
              timidValue: "",
              title: StringConstant.estimatedPayables,
              svgPrefixIcon: SvgImageConstant.dollorRound,
            ),
            displayDateBreak(
              context,
              boldValue: "",
              timidValue: "",
              showBtn: true,
              title: "",
              svgPrefixIcon: "",
            ),
          ],
        ),
      ],
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

  Widget clockIn(BuildContext context, int index, ContractorShiftState state) {
    bool isClockInValid =
        (state.currentShiftList[index].selectedClockInTime != null &&
            state.currentShiftList[index].selectedClockInTime!.isNotEmpty);
    return CustomTextField(
      labelText: StringConstant.clockIn,
      hintText: (isClockInValid)
          ? state.currentShiftList[index].selectedClockInTime
          : StringConstant.clockIn,
      hintAsValue: isClockInValid,
      fillColor: AppColors.grey04,
      readOnly: true,
      onTap: () async {
        final clockInTime = await showTimePicker(context);
        if (clockInTime.isNotEmpty) {
          context.read<ContractorShiftBloc>().add(
              ContractorShiftEvent.setClockIn(
                  index: index, clockInTime: clockInTime));
        }
      },
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(16),
          vertical: getSize(16),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.clock,
          height: getSize(16),
          width: getSize(16),
          color: AppColors.primaryColor,
        ),
      ),
      suffixIcon: CommonButton(
        onPressed: () {
          submitTime(
            context,
            title: StringConstant.clockIn,
            infoMessage: StringConstant.clockInConfirmationDesc,
            onSubmit: () {},
          );
        },
        borderRadius: 10,
        buttonFontSize: 10,
        height: 33,
        width: 73,
        buttonText: StringConstant.submit,
      ),
    );
  }

  Future<String> showTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData.light().copyWith(
              timePickerTheme: TimePickerThemeData(
                dayPeriodColor: AppColors.primaryColor,
                dayPeriodTextColor: AppColors.black,
              ),
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onSurface: AppColors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(),
              ),
            ),
            child: TimePickerDialog(
              initialTime: TimeOfDay.fromDateTime(DateTime.now()),
            ),
          );
        });

    if (pickedTime != null) {
      print("Selected Time:  ${pickedTime.format(context)}");
      return pickedTime.format(context);
    } else {
      return "";
    }
  }

  submitTime(BuildContext context,
      {required String title,
      required String infoMessage,
      required void Function()? onSubmit}) {
    AppDialog.showDelete(
      context,
      title: title,
      infoMessage: infoMessage,
      onCancelClick: () {
        context.router.maybePop();
      },
      onDeleteClick: onSubmit,
    );
  }

  Widget clockOut() {
    return CustomTextField(
      labelText: StringConstant.clockOut,
      hintText: StringConstant.clockOut,
      fillColor: AppColors.grey04,
      readOnly: true,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(16),
          vertical: getSize(16),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.clock,
          height: getSize(16),
          width: getSize(16),
          color: AppColors.primaryColor,
        ),
      ),
      suffixIcon: CommonButton(
        onPressed: () {},
        borderRadius: 10,
        buttonFontSize: 10,
        height: 33,
        width: 73,
        backgroundColor: AppColors.primaryColor.withOpacity(0.5),
        buttonText: StringConstant.submitted,
      ),
    );
  }

  Widget displayDateBreak(
    BuildContext context, {
    required String title,
    required String boldValue,
    required String timidValue,
    required String svgPrefixIcon,
    bool showBtn = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: (showBtn)
          ? CommonButton(
              onPressed: () {
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
              highLightText(
                  boldValue: "$startDate to $endDate", timidValue: ""),
            ],
          )
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
            leading: SvgPicture.asset(
              SvgImageConstant.female,
              width: getSize(36.28),
              height: getSize(43.41),
              color: AppColors.primaryColor,
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

  Widget numberOfVacancy({
    required String value,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(12),
          vertical: getSize(10),
        ),
        margin: EdgeInsets.symmetric(vertical: getSize(5)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
        child: paybaleTitleRate(
            title: StringConstant.numberOfVacancies, value: value));
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
}
