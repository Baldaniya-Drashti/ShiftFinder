// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_brace_in_string_interps, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_multi_date_picker.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';

class DifferentTimeForEachDate extends StatelessWidget {
  PostShiftDTO post;
  DifferentTimeForEachDate({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostShiftBloc, PostShiftState>(
      listener: (context, state) {
        if (state.isDifferentDateDataValid) {
          final data = MultiShiftDTO(
            commute_allowance_type:
                (state.selectedCommuteAllownce.getValue() == "Flat Rate")
                    ? 1
                    : (state.selectedCommuteAllownce.getValue() == "Hours")
                        ? 2
                        : 0,
            commute_allowance:
                (state.selectedCommuteAllownce.getValue() == "Flat Rate")
                    ? state.commuteRate.getValue()
                    : (state.selectedCommuteAllownce.getValue() == "Hours")
                        ? state.commuteHour.getValue()
                        : "",
            accommodation_allowance_type:
                (state.selectedAccomdationAllownce.getValue() == "Flat Rate")
                    ? 1
                    : (state.selectedAccomdationAllownce.getValue() == "Hours")
                        ? 2
                        : 0,
            accommodation_allowance:
                (state.selectedAccomdationAllownce.getValue() == "Flat Rate")
                    ? state.accomdationRate.getValue()
                    : (state.selectedAccomdationAllownce.getValue() == "Hours")
                        ? state.accomdationHour.getValue()
                        : "",
            individual_shift: (state.isIndividualPost) ? 1 : 0,
            shift_note: state.singleShiftNote,
            vacancie_type: (state.isMoreVacancy) ? 1 : 0,
            number_of_vacancie: (state.selectedVacancy.isValid())
                ? int.parse(
                    state.selectedVacancy.getValue() ?? "0",
                  )
                : null,
            multi_date: state.selectedMultiDates.getValue().map((date) {
              return DateTimeDTO(date: date.toIso8601String());
            }).toList(),
            post_id: state.postId,
            same_or_different_time: state.selectedMultiShiftType,
            shift_type: state.shiftType,
          );
          context.router
              .push(PageRouteInfo(
            AddMultiDateTime.name,
            args: AddMultiDateTimeArgs(
              selectedObj: data,
              post: post,
            ),
          ))
              .then((value) {
            context.read<PostShiftBloc>().add(PostShiftEvent.backEvent());
          });
        }
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: (state.singleShiftErrorMessages)
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              selectMultiDate(context, state),
              if (state.singleShiftErrorMessages &&
                  !(state.selectedMultiDates.isValid()))
                commonErrorText(
                  StringConstant.pleaseSelectAtLeastOneDate,
                ),
              paddingBetweenFields(),
              commuteAllownceDropDown(context, state),
              if (state.singleShiftErrorMessages &&
                  !(PostShiftBloc.isAllownceValid(
                      selectedValue: state.selectedCommuteAllownce,
                      hourValue: state.commuteHour,
                      rateValue: state.commuteRate)))
                commonErrorText(
                    StringConstant.pleaseSelectCommuteAllownceValue),
              paddingBetweenFields(),
              accommodationAllowanceDropDown(context, state),
              if (state.singleShiftErrorMessages &&
                  !(PostShiftBloc.isAllownceValid(
                      selectedValue: state.selectedAccomdationAllownce,
                      hourValue: state.accomdationHour,
                      rateValue: state.accomdationRate)))
                commonErrorText(
                    StringConstant.pleaseSelectAccomdationAllownceValue),
              paddingBetweenFields(),
              individualPostCheckBox(context, state),
              paddingBetweenFields(),
              shiftNotesField(context, state),
              paddingBetweenFields(),
              vacancyCheckBox(context, state),
              if (state.isMoreVacancy) ...[
                paddingBetweenFields(),
                numberOfVacancy(context, state),
                if (state.singleShiftErrorMessages &&
                    !(PostShiftBloc.isMoreVacancyValid(
                        isMoreVacancy: state.isMoreVacancy,
                        vacancyValue: state.selectedVacancy)))
                  commonErrorText(
                    StringConstant.pleaseAddNumberOfVacancies,
                  ),
              ],
              Padding(
                padding: EdgeInsets.only(top: getSize(50), bottom: getSize(30)),
                child: CommonButton(
                  onPressed: () {
                    /// After click go to next screen to select time for different dates
                    context
                        .read<PostShiftBloc>()
                        .add(PostShiftEvent.multidateContinueButtonPressed());
                  },
                  buttonText: StringConstant.txtContinue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget selectMultiDate(BuildContext context, PostShiftState state) {
    return CustomMultiDatePicker(
      value: state.selectedMultiDates.getValue(),
      onValueChanged: (value) {
        print("selected dates--> $value");
        context
            .read<PostShiftBloc>()
            .add(PostShiftEvent.multiDateSelectionChanged(value));
      },
    );
  }

  Widget commuteAllownceDropDown(BuildContext context, PostShiftState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.commuteAllowance,
      hintText: StringConstant.commuteAllowance,
      isLabelPadding: true,
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
    );
  }

  Widget accommodationAllowanceDropDown(
      BuildContext context, PostShiftState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.accommodationAllowance,
      hintText: StringConstant.accommodationAllowance,
      isLabelPadding: true,
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
    );
  }

  Widget shiftNotesField(BuildContext context, PostShiftState state) {
    return CustomTextField(
      labelText: StringConstant.addShiftNotes,
      hintText: StringConstant.typeHere,
      isOptional: true,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      initialValue: state.singleShiftNote,
      onChanged: (value) {
        context
            .read<PostShiftBloc>()
            .add(PostShiftEvent.singleShiftNotesChanged(value));
      },
    );
  }

  Widget individualPostCheckBox(BuildContext context, PostShiftState state) {
    return Container(
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
              value: state.isIndividualPost,
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
                      .add(PostShiftEvent.checkIsIndividualPost(value));
                }
              },
            ),
          ),
          SizedBox(
            width: getSize(15),
          ),
          Flexible(
            child: BaseText(
              text: StringConstant.postAsIndividualShifts,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget vacancyCheckBox(BuildContext context, PostShiftState state) {
    return Container(
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
    );
  }

  Widget numberOfVacancy(BuildContext context, PostShiftState state) {
    return CustomTextField(
      labelText: StringConstant.numberOfVacancies,
      hintText: StringConstant.numberOfVacancies,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        context
            .read<PostShiftBloc>()
            .add(PostShiftEvent.addVacancyChanged(value));
      },
    );
  }
}
