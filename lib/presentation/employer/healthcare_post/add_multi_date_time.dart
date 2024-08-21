// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_time_picker_dropdown.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addMultiDateTime')
class AddMultiDateTime extends StatelessWidget {
  PostShiftDTO post;
  HealthcarePostDTO? updateShift;
  final bool fromSaveTemplate;
  final bool fromReview;
  final bool isCreate;

  MultiShiftDTO selectedObj;

  AddMultiDateTime(
      {super.key,
      this.fromSaveTemplate = false,
      this.fromReview = false,
      this.isCreate = true,
      required this.selectedObj,
      this.updateShift,
      required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostShiftBloc>()
        ..add(PostShiftEvent.initMultiDifferentDateEvent(
          selectedObj.multi_date ?? [],
          updateShift: updateShift,
          post: post,
          fromSaveTemplate: fromSaveTemplate,
          fromReview: fromReview,
        )),
      child: BlocConsumer<PostShiftBloc, PostShiftState>(
        listener: (context, state) {
          state.singleShiftFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(context);
              },
              (r) {
                /*context.router.push(PageRouteInfo(
                  PostShiftRecurring.name,
                  args: PostShiftRecurringArgs(
                      shiftType: state.shiftType,
                      healthcarePost: r,
                      post: post),
                ));*/
              },
            ),
          );
        },
        builder: (context, state) {
          Log.success("===${state.multiDateTimeList.length}");
          return Scaffold(
            appBar: CommonAppBar(
              title: StringConstant.addTime,
              onBackPressed: () {
                Navigator.pop(context);
              },
            ),
            body: (state.isLoading)
                ? CenterLoadingIndicator()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // unpaidBreakDropDown(context, state),
                        // if (state.singleShiftErrorMessages &&
                        //     !state.unpaidBreak.isValid())
                        //   commonErrorText(
                        //       StringConstant.pleaseSelectUnpaidBreakTime),
                        // paddingBetweenFields(),
                        totalPaybleHours(state),
                        paddingBetweenFields(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (state.multiDateTimeList.isNotEmpty)
                                  ListView.builder(
                                      itemCount: state.multiDateTimeList.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        print(
                                            "Get updatedd list----> ${state.multiDateTimeList.length}");
                                        return startEndTime(context, state,
                                            state.multiDateTimeList[index],
                                            index: index);
                                      }),
                                if (!(state.multiDateTimeList.every((dto) =>
                                        dto.totalPaybleHours != null &&
                                        dto.totalPaybleHours!.isNotEmpty)) &&
                                    state.singleShiftErrorMessages)
                                  commonErrorText(
                                    StringConstant
                                        .pleaseSelectStartAndEndTimeForEachDate,
                                  ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getSize(30)),
                                  child: CommonButton(
                                    onPressed: () {
                                      context.read<PostShiftBloc>().add(
                                              PostShiftEvent
                                                  .differentTimeShiftSubmitted(
                                            selectedObj,
                                            context,
                                            fromSaveTemplate,
                                            fromReview: fromReview,
                                            isCreate: isCreate,
                                          ));
                                    },
                                    buttonText: StringConstant.txtContinue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget disableTime(PostShiftState state, int index) {
    String shiftTime = CustomDateTimeFormat.getShiftTime(
      InputEmptyOrNot(state.multiDateTimeList[index].startHour ?? ""),
      InputEmptyOrNot(state.multiDateTimeList[index].startMinute ?? ""),
      InputEmptyOrNot(state.multiDateTimeList[index].endHour ?? ""),
      InputEmptyOrNot(state.multiDateTimeList[index].endMinute ?? ""),
    );

    return Container(
      padding:
          EdgeInsets.symmetric(vertical: getSize(20), horizontal: getSize(18)),
      decoration: BoxDecoration(
          color: AppColors.grey04,
          borderRadius: BorderRadius.circular(getSize(10))),
      child: CustomTextField(
        isLabelPadding: false,
        labelText: StringConstant.shiftTime,
        labelStyle: TextStyle(color: AppColors.black.withOpacity(0.7)),
        readOnly: true,
        hintText: shiftTime,
        hintAsValue: true,
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget unpaidBreakDropDown(
      BuildContext context, PostShiftState state, int index) {
    final breakTime = state.multiDateTimeList[index].unpaidBreak;

    return CustomDropdwonWithTextField(
      labelText: StringConstant.unpaidBreak,
      hintText: StringConstant.unpaidBreak,
      showTextfield: false,
      isLabelPadding: false,
      dropDownReadOnly: (updateShift?.id != null &&
              fromSaveTemplate == false &&
              (fromReview == false || isCreate == false))
          ? true
          : false,
      dropDownIcon: (state.updateShift.id != null &&
              fromSaveTemplate == false &&
              (fromReview == false || isCreate == false))
          ? Container()
          : null,
      value: (breakTime != null && breakTime.isNotEmpty) ? breakTime : null,
      items: state.breakList.map((val) {
        return DropdownMenuItem<String>(
          value: val.name,
          child: BaseText(
            text: val.name ?? "",
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          // context.read<PostShiftBloc>().add(PostShiftEvent.unpaidBreakChanged(value));
          context.read<PostShiftBloc>().add(
              PostShiftEvent.unpaidBreakListChanged(
                  value, index, selectedObj.multi_date![index].date ?? ""));
        }
      },
    );
  }

  Widget totalPaybleHours(PostShiftState state) {
    print("total Hours--> ${state.totalPaybleHours}");
    return CustomTextField(
      labelText: StringConstant.totalPayableHours,
      hintText: state.totalPaybleHours,
      hintAsValue: true,
      readOnly: true,
      fillColor: AppColors.grey04,
    );
  }

  Widget paybleHours(PostShiftState state, int index) {
    final payableHours = state.multiDateTimeList[index].totalPaybleHours;

    return CustomTextField(
      labelText: StringConstant.payableHours,
      hintText: (payableHours != null && payableHours.isNotEmpty)
          ? payableHours
          : "00h 00min",
      isLabelPadding: false,
      hintAsValue: true,
      readOnly: true,
      fillColor: AppColors.grey04,
    );
  }

  Widget startEndTime(
      BuildContext context, PostShiftState state, DateTimeDTO currentObj,
      {required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              getSize(20), getSize(10), getSize(20), getSize(5)),
          child: BaseText(
            text: (currentObj.date != null && currentObj.date!.isNotEmpty)
                ? DateFormat('d MMM, yyyy')
                    .format(DateTime.parse(currentObj.date ?? ""))
                : "",
            textColor: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        // (state.updateShift.id != null)
        //     ? disableTime(state, index)
        //     :
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(20), vertical: getSize(20)),
          decoration: BoxDecoration(
              color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              startTime(context, state, index),
              paddingBetweenFields(),
              endTime(context, state, index),
              paddingBetweenFields(),
              unpaidBreakDropDown(context, state, index),
              paddingBetweenFields(),
              paybleHours(state, index),
              (PostShiftBloc.timeIsPast(
                state,
                InputEmptyOrNot(currentObj.startHour ?? ""),
                InputEmptyOrNot(currentObj.startMinute ?? ""),
                shiftType: 2,
                multiDate: currentObj,
              ))
                  ? commonErrorText(
                      StringConstant
                          .shiftStartTimeMustBeAFutureTimeAndAtLeastTwoHoursAfterTheCurrentTime,
                      padding: EdgeInsets.only(top: getSize(10)))
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Widget startTime(BuildContext context, PostShiftState state, int index) {
    final hour = state.multiDateTimeList[index].startHour;
    final minute = state.multiDateTimeList[index].startMinute;
    return CustomTimePickerDropdown(
      labelText: StringConstant.startTime,
      dropDownIcon: (state.updateShift.id != null &&
              fromSaveTemplate == false &&
              (fromReview == false || isCreate == false))
          ? Container()
          : null,
      dropDownReadOnly: (state.updateShift.id != null &&
              fromSaveTemplate == false &&
              (fromReview == false || isCreate == false))
          ? true
          : false,
      isLabelPadding: false,
      hourValue: (hour != null && hour.isNotEmpty) ? hour : null,
      minuteValue: (minute != null && minute.isNotEmpty) ? minute : null,
      hourOnChanged: (value) {
        if (value != null) {
          context.read<PostShiftBloc>().add(PostShiftEvent.startHourListChanged(
              value, index, selectedObj.multi_date![index].date ?? ""));
        }
      },
      minOnChanged: (value) {
        if (value != null) {
          context.read<PostShiftBloc>().add(
              PostShiftEvent.startMinuteListChanged(
                  value, index, selectedObj.multi_date![index].date ?? ""));
        }
      },
    );
  }

  Widget endTime(BuildContext context, PostShiftState state, int index) {
    final hour = state.multiDateTimeList[index].endHour;
    final minute = state.multiDateTimeList[index].endMinute;
    return CustomTimePickerDropdown(
      labelText: StringConstant.endTime,
      isLabelPadding: false,
      dropDownIcon: (state.updateShift.id != null &&
              fromSaveTemplate == false &&
              (fromReview == false || isCreate == false))
          ? Container()
          : null,
      dropDownReadOnly: (state.updateShift.id != null &&
              fromSaveTemplate == false &&
              (fromReview == false || isCreate == false))
          ? true
          : false,
      hourValue: (hour != null && hour.isNotEmpty) ? hour : null,
      minuteValue: (minute != null && minute.isNotEmpty) ? minute : null,
      hourOnChanged: (value) {
        if (value != null) {
          context.read<PostShiftBloc>().add(PostShiftEvent.endHourListChanged(
              value, index, selectedObj.multi_date![index].date ?? ""));
        }
      },
      minOnChanged: (value) {
        if (value != null) {
          context.read<PostShiftBloc>().add(PostShiftEvent.endMinuteListChanged(
              value, index, selectedObj.multi_date![index].date ?? ""));
        }
      },
    );
  }
}
