// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart';
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_time_picker_dropdown.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';

class SinglePostShift extends StatelessWidget {
  int shiftType;
  int postId;
  HealthcarePostDTO? updateShift;

  PostShiftDTO post;

  SinglePostShift(
      {super.key,
      this.updateShift,
      required this.shiftType,
      required this.postId,
      required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostShiftBloc>()
        ..add(PostShiftEvent.changeShiftType("Single",
            postId: postId, post: post, updateShift: updateShift)),
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
                // context.router.push(PageRouteInfo(
                //   PostShiftRecurring.name,
                //   args: PostShiftRecurringArgs(
                //     shiftType: shiftType,
                //     healthcarePost: r,
                //     post: post,
                //   ),
                // ));
              },
            ),
          );
        },
        builder: (context, state) {
          return (state.isLoading)
              ? CenterLoadingIndicator(isOnlyLoader: true)
              : Form(
                  autovalidateMode: (state.singleShiftErrorMessages)
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      paddingBetweenFields(),
                      dateField(context, state),
                      paddingBetweenFields(),
                      startTime(context, state),
                      paddingBetweenFields(),
                      endTime(context, state),
                      paddingBetweenFields(),
                      unpaidBreakDropDown(context, state),
                      if (state.singleShiftErrorMessages &&
                          (!state.unpaidBreak.isValid()))
                        commonErrorText(
                          StringConstant.pleaseSelectUnpaidBreakTime,
                        ),
                      paddingBetweenFields(),
                      totalPaybleHours(state),
                      paddingBetweenFields(),
                      commuteAllownceDropDown(context, state),
                      if (state.singleShiftErrorMessages &&
                          !(PostShiftBloc.isAllownceValid(
                              selectedValue: state.selectedCommuteAllownce,
                              hourValue: state.commuteHour,
                              rateValue: state.commuteRate)))
                        commonErrorText(
                          (double.tryParse(state.commuteRate.getValue()) !=
                                      null &&
                                  double.parse(state.commuteRate.getValue()) <=
                                      0)
                              ? StringConstant.flatRateShouldNotBeZero
                              : StringConstant.pleaseSelectCommuteAllownceValue,
                        ),
                      paddingBetweenFields(),
                      accommodationAllowanceDropDown(context, state),
                      if (state.singleShiftErrorMessages &&
                          !(PostShiftBloc.isAllownceValid(
                              selectedValue: state.selectedAccomdationAllownce,
                              hourValue: state.accomdationHour,
                              rateValue: state.accomdationRate)))
                        commonErrorText(
                          (double.tryParse(state.accomdationRate.getValue()) !=
                                      null &&
                                  double.parse(
                                          state.accomdationRate.getValue()) <=
                                      0)
                              ? StringConstant.flatRateShouldNotBeZero
                              : StringConstant
                                  .pleaseSelectAccomdationAllownceValue,
                        ),
                      paddingBetweenFields(),
                      shiftNotesField(context, state),
                      paddingBetweenFields(),
                      vacancyCheckBox(context, state),
                      if (state.isMoreVacancy) ...[
                        paddingBetweenFields(),
                        numberOfVacancy(context, state),
                        /*if (state.singleShiftErrorMessages &&
                            !(PostShiftBloc.isMoreVacancyValid(
                                isMoreVacancy: state.isMoreVacancy,
                                vacancyValue: state.selectedVacancy)))
                          commonErrorText(
                            StringConstant.pleaseAddNumberOfVacancies,
                          ),*/
                      ],
                      Padding(
                        padding: EdgeInsets.only(
                            top: getSize(50), bottom: getSize(30)),
                        child: CommonButton(
                          onPressed: () {
                            context.read<PostShiftBloc>().add(
                                PostShiftEvent.singleShiftSubmitted(context));
                          },
                          buttonText: StringConstant.txtContinue,
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget dateField(BuildContext context, PostShiftState state) {
    return CustomTextField(
      labelText: StringConstant.date,
      hintText: (state.signleShiftDate.isValid())
          ? DateFormat('d MMM, yyyy')
              .format(DateTime.parse(state.signleShiftDate.getValue() ?? ""))
          : StringConstant.date,
      hintAsValue: (state.signleShiftDate.isValid()) ? true : false,
      readOnly: true,
      errorInputBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.transparent),
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.calendar,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onTap: (state.updateShift.id != null)
          ? null
          : () {
              DocumentExpiryDatePicker.customDatePicker(
                context,
                firstDate: DateTime.now(),
                onPickedDate: (pickedDate) {
                  context
                      .read<PostShiftBloc>()
                      .add(PostShiftEvent.singleShiftDateChangedEvent(
                        pickedDate.toString(),
                      ));
                },
                onCancelClick: () {},
                selectedDate: DateTime.now(),
              );
            },
      validator: (_, context) =>
          context.read<PostShiftBloc>().state.signleShiftDate.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectDate,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget startTime(BuildContext context, PostShiftState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTimePickerDropdown(
          labelText: StringConstant.startTime,
          dropDownIcon: (state.updateShift.id != null) ? Container() : null,
          dropDownReadOnly: (state.updateShift.id != null) ? true : false,
          disableDropDownColor: AppColors.grey04,
          hourValue:
              (state.startHour.isValid()) ? state.startHour.getValue() : null,
          minuteValue: (state.startMinute.isValid())
              ? state.startMinute.getValue()
              : null,
          hourOnChanged: (value) {
            if (value != null) {
              context
                  .read<PostShiftBloc>()
                  .add(PostShiftEvent.startHourChanged(value));
            }
          },
          minOnChanged: (value) {
            if (value != null) {
              context
                  .read<PostShiftBloc>()
                  .add(PostShiftEvent.startMinuteChanged(value));
            }
          },
        ),
        (state.singleShiftErrorMessages &&
                (!isStartHourValid(state) && !isStartMinValid(state)))
            ? commonErrorText(
                StringConstant.pleaseSelectHourAndMinutesOfStartTime)
            : (state.singleShiftErrorMessages && !isStartHourValid(state))
                ? commonErrorText(
                    StringConstant.pleaseSelectHourAndMinutesOfStartTime)
                : (state.singleShiftErrorMessages && !isStartMinValid(state))
                    ? commonErrorText(
                        StringConstant.pleaseSelectHourAndMinutesOfStartTime)
                    : (state.singleShiftErrorMessages &&
                            PostShiftBloc.timeIsPast(
                                state, state.startHour, state.startMinute))
                        ? commonErrorText(
                            StringConstant.shiftStartTimeMustBeAFutureTime)
                        : Container(),
      ],
    );
  }

  bool isStartHourValid(PostShiftState state) {
    return (state.startHour.isValid());
  }

  bool isStartMinValid(PostShiftState state) {
    return (state.startMinute.isValid());
  }

  bool isEndHourValid(PostShiftState state) {
    return (state.endHour.isValid());
  }

  bool isEndMinValid(PostShiftState state) {
    return (state.endMinute.isValid());
  }

  Widget endTime(BuildContext context, PostShiftState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTimePickerDropdown(
          labelText: StringConstant.endTime,
          dropDownIcon: (state.updateShift.id != null) ? Container() : null,
          dropDownReadOnly: (state.updateShift.id != null) ? true : false,
          disableDropDownColor: AppColors.grey04,
          hourValue:
              (state.endHour.isValid()) ? state.endHour.getValue() : null,
          minuteValue:
              (state.endMinute.isValid()) ? state.endMinute.getValue() : null,
          hourOnChanged: (value) {
            if (value != null) {
              context
                  .read<PostShiftBloc>()
                  .add(PostShiftEvent.endHourChanged(value));
            }
          },
          minOnChanged: (value) {
            if (value != null) {
              context
                  .read<PostShiftBloc>()
                  .add(PostShiftEvent.endMinuteChanged(value));
            }
          },
        ),
        // if (state.singleShiftErrorMessages &&
        //     (!state.endHour.isValid() || !state.endMinute.isValid()))
        //   commonErrorText(
        //     StringConstant.pleaseSelectHourAndMinutesOfEndTime,
        //   ),
        (state.singleShiftErrorMessages &&
                (!isEndHourValid(state) && !isEndMinValid(state)))
            ? commonErrorText(
                StringConstant.pleaseSelectHourAndMinutesOfEndTime)
            : (state.singleShiftErrorMessages && !isEndHourValid(state))
                ? commonErrorText(
                    StringConstant.pleaseSelectHourAndMinutesOfEndTime)
                : (state.singleShiftErrorMessages && !isEndMinValid(state))
                    ? commonErrorText(
                        StringConstant.pleaseSelectHourAndMinutesOfEndTime)
                    : Container(),
      ],
    );
  }

  Widget unpaidBreakDropDown(BuildContext context, PostShiftState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.unpaidBreak,
      hintText: StringConstant.unpaidBreak,
      showTextfield: false,
      isLabelPadding: true,
      dropDownIcon: (state.updateShift.id != null) ? Container() : null,
      dropDownReadOnly: (state.updateShift.id != null) ? true : false,
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
    return CustomTextField(
      labelText: StringConstant.totalPayableHours,
      hintText: state.totalPaybleHours,
      hintAsValue: true,
      readOnly: true,
      fillColor: AppColors.grey04,
    );
  }

  Widget commuteAllownceDropDown(BuildContext context, PostShiftState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.commuteAllowance,
      hintText: StringConstant.commuteAllowance,
      isLabelPadding: true,
      fieldMaxLength: 5,
      showTextfield: (state.selectedCommuteAllownce.getValue() == "Flat Rate"),
      showDropDown: (state.selectedCommuteAllownce.getValue() == "Hours"),
      childDroDwonHintText: StringConstant.selectHours,
      fieldInputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      fieldKeyboardType: TextInputType.numberWithOptions(decimal: true),
      fieldHintText: "0.00",
      value: (state.selectedCommuteAllownce.isValid())
          ? state.selectedCommuteAllownce.getValue()
          : null,
      childDropDownValue:
          (state.commuteHour.isValid()) ? state.commuteHour.getValue() : null,
      fieldInitialValue:
          (state.commuteRate.isValid()) ? state.commuteRate.getValue() : null,
      fieldPrefixIcon: Padding(
          padding: EdgeInsets.only(
            left: getSize(20),
            top: getSize(14),
            bottom: getSize(14),
          ),
          child: BaseText(
            text: '\$ ',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black.withOpacity(0.7),
          )),
      fieldPrefixIconConstraints:
          BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      items: CommonList.commuteAllownceList.map((val) {
        return DropdownMenuItem<String>(
          value: val,
          child: BaseText(
            text: val,
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          context
              .read<PostShiftBloc>()
              .add(PostShiftEvent.commuteAllownceChanged(value));
        }
      },
      fieldOnChanged: (value) {
        context
            .read<PostShiftBloc>()
            .add(PostShiftEvent.commuteRateChanged(value));
      },
      childDropDownItems: state.accomdationHoursList.map((val) {
        return DropdownMenuItem<String>(
          value: val.name,
          child: BaseText(
            text: val.name ?? "",
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      childDropDownOnChanged: (value) {
        if (value != null) {
          context
              .read<PostShiftBloc>()
              .add(PostShiftEvent.commuteHoursChanged(value));
        }
      },
      isOptional: true,
      optionalWidget: GestureDetector(
        onTap: () {
          AppDialog.showInfo(context, StringConstant.singleCommuteInfoDesc,
              maxLines: 15);
        },
        child: Container(
          color: AppColors.transparent,
          padding: EdgeInsets.only(right: getSize(30)),
          child: SvgPicture.asset(
            SvgImageConstant.infoCircle,
          ),
        ),
      ),
    );
  }

  Widget accommodationAllowanceDropDown(
      BuildContext context, PostShiftState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.accommodationAllowance,
      hintText: StringConstant.accommodationAllowance,
      isLabelPadding: true,
      fieldMaxLength: 5,
      showTextfield:
          (state.selectedAccomdationAllownce.getValue() == "Flat Rate"),
      showDropDown: (state.selectedAccomdationAllownce.getValue() == "Hours"),
      childDroDwonHintText: StringConstant.selectHours,
      fieldInputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      value: (state.selectedAccomdationAllownce.isValid())
          ? state.selectedAccomdationAllownce.getValue()
          : null,
      childDropDownValue: (state.accomdationHour.isValid())
          ? state.accomdationHour.getValue()
          : null,
      fieldInitialValue: (state.accomdationRate.isValid())
          ? state.accomdationRate.getValue()
          : null,
      fieldKeyboardType: TextInputType.numberWithOptions(decimal: true),
      fieldHintText: "0.00",
      fieldPrefixIcon: Padding(
          padding: EdgeInsets.only(
            left: getSize(20),
            top: getSize(14),
            bottom: getSize(14),
          ),
          child: BaseText(
            text: '\$ ',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black.withOpacity(0.7),
          )),
      fieldPrefixIconConstraints:
          BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      items: CommonList.commuteAllownceList.map((val) {
        return DropdownMenuItem<String>(
          value: val,
          child: BaseText(
            text: val,
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          context
              .read<PostShiftBloc>()
              .add(PostShiftEvent.accomdationAllownceChanged(value));
        }
      },
      fieldOnChanged: (value) {
        context
            .read<PostShiftBloc>()
            .add(PostShiftEvent.accomdationRateChanged(value));
      },
      childDropDownItems: state.accomdationHoursList.map((val) {
        return DropdownMenuItem<String>(
          value: val.name,
          child: BaseText(
            text: val.name ?? "",
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      childDropDownOnChanged: (value) {
        if (value != null) {
          context
              .read<PostShiftBloc>()
              .add(PostShiftEvent.accomdationHoursChanged(value));
        }
      },
      isOptional: true,
      optionalWidget: GestureDetector(
        onTap: () {
          AppDialog.showInfo(context, StringConstant.singleAccomdationInfoDesc,
              maxLines: 15);
        },
        child: Container(
          color: AppColors.transparent,
          padding: EdgeInsets.only(right: getSize(30)),
          child: SvgPicture.asset(
            SvgImageConstant.infoCircle,
          ),
        ),
      ),
    );
  }

  Widget shiftNotesField(BuildContext context, PostShiftState state) {
    return CustomTextField(
      labelText: StringConstant.addShiftNotes,
      hintText: StringConstant.typeHere,
      // hintAsValue: (state.singleShiftNote.isNotEmpty) ? true : false,
      isOptional: true,
      maxLines: 3,
      maxLength: 500,
      keyboardType: TextInputType.multiline,
      initialValue: state.singleShiftNote,
      onChanged: (value) {
        context
            .read<PostShiftBloc>()
            .add(PostShiftEvent.singleShiftNotesChanged(value));
      },
    );
  }

  Widget vacancyCheckBox(BuildContext context, PostShiftState state) {
    print("singleShiftNote -> ${state.isMoreVacancy}");

    return GestureDetector(
      onTap: () {
        bool value = state.isMoreVacancy;
        value = !value;
        context
            .read<PostShiftBloc>()
            .add(PostShiftEvent.checkIsMoreVancancy(value));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(10),
        ),
        decoration: BoxDecoration(
            color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: state.isMoreVacancy,
                activeColor: AppColors.primaryColor,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  if (value != null) {
                    context
                        .read<PostShiftBloc>()
                        .add(PostShiftEvent.checkIsMoreVancancy(value));
                  }
                },
              ),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Flexible(
              child: BaseText(
                text: StringConstant.singleShiftVacancyDesc,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget numberOfVacancy(BuildContext context, PostShiftState state) {
    return CustomTextField(
      labelText: StringConstant.numberOfVacancies,
      hintText: StringConstant.numberOfVacancies,
      initialValue: state.selectedVacancy.getValue(),
      keyboardType: TextInputType.number,
      errorInputBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.transparent),
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      maxLength: 3,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        context
            .read<PostShiftBloc>()
            .add(PostShiftEvent.addVacancyChanged(value));
      },
      validator: (p0, p1) =>
          context.read<PostShiftBloc>().state.selectedVacancy.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddNumberOfVacancies,
                  invalidVacancy: (value) =>
                      StringConstant.numberOfVacanciesMustBeGreaterThanOne,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }
}
