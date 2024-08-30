// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, must_be_immutable

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_time_picker_dropdown.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addMultiDateTime')
class AddMultiDateTime extends StatelessWidget {
  MultiShiftDTO selectedObj;
  AddMultiDateTime({super.key, required this.selectedObj});

  @override
  Widget build(BuildContext context) {
    print("Selected Obj--> ${jsonEncode(selectedObj)}");
    return BlocProvider(
      create: (context) => getIt<PostShiftBloc>()
        ..add(PostShiftEvent.initMultiDifferentDateEvent(
            selectedObj.multi_date ?? [])),
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
                context.router.push(PageRouteInfo(
                  PostShiftRecurring.name,
                  args: PostShiftRecurringArgs(
                      shiftType: state.shiftType, healthcarePost: r),
                ));
              },
            ),
          );
        },
        builder: (context, state) {
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
                        unpaidBreakDropDown(context, state),
                        if (state.singleShiftErrorMessages &&
                            !state.unpaidBreak.isValid())
                          commonErrorText(
                            StringConstant.pleaseSelectUnpaidBreakTime,
                          ),
                        paddingBetweenFields(),
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
                                                  selectedObj));
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

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget unpaidBreakDropDown(BuildContext context, PostShiftState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.unpaidBreak,
      hintText: StringConstant.unpaidBreak,
      showTextfield: false,
      isLabelPadding: true,
      value:
          (state.unpaidBreak.isValid()) ? state.unpaidBreak.getValue() : null,
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
          context
              .read<PostShiftBloc>()
              .add(PostShiftEvent.unpaidBreakChanged(value));
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

  Widget startEndTime(
      BuildContext context, PostShiftState state, DateTimeDTO currentObj,
      {required int index}) {
    print("multiDateTimeList--> ${state.multiDateTimeList}");

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
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(20), vertical: getSize(20)),
          decoration: BoxDecoration(
              color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              startTime(context, state, index),
              paddingBetweenFields(),
              endTime(context, state, index),
            ],
          ),
        ),
      ],
    );
  }

  Widget startTime(BuildContext context, PostShiftState state, int index) {
    return CustomTimePickerDropdown(
      labelText: StringConstant.startTime,
      isLabelPadding: false,
      hourValue:
          (state.startHour.isValid()) ? state.startHour.getValue() : null,
      minuteValue:
          (state.startMinute.isValid()) ? state.startMinute.getValue() : null,
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
    return CustomTimePickerDropdown(
      labelText: StringConstant.endTime,
      isLabelPadding: false,
      hourValue: (state.endHour.isValid()) ? state.endHour.getValue() : null,
      minuteValue:
          (state.endMinute.isValid()) ? state.endMinute.getValue() : null,
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
