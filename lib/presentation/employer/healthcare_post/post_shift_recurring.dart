// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'postShiftRecurring')
class PostShiftRecurring extends StatelessWidget {
  int shiftType;
  HealthcarePostDTO? updateShift;
  PostShiftDTO post;

  PostShiftRecurring(
      {super.key,
      required this.shiftType,
      required this.updateShift,
      required this.post});

  @override
  Widget build(BuildContext context) {
    print("updatedShift--->  ${jsonEncode(updateShift?.shift_detail?.teams)}");
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: BlocProvider(
          create: (context) => getIt<PostShiftBloc>()
            ..add(PostShiftEvent.getTeamsListEvent(
                post: post, updateShift: updateShift)),
          child: BlocConsumer<PostShiftBloc, PostShiftState>(
            listener: (context, state) {
              state.recurringFailureOrSuccessOption.fold(
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
                    context.router
                        .push(PageRouteInfo(ReviewPostShiftDetail.name,
                            args: ReviewPostShiftDetailArgs(
                              post: r,
                              updatedPost: (state.updateShift.id != null &&
                                      state.updateShift.id != -1)
                                  ? state.post
                                  : null,
                              isUpdate: (state.updateShift.id != null &&
                                      state.updateShift.id != -1)
                                  ? true
                                  : false,
                            )));
                  },
                ),
              );
            },
            builder: (context, state) {
              return Scaffold(
                appBar: CommonAppBar(
                  title: StringConstant.healthcare,
                  onBackPressed: () {
                    Navigator.pop(context);
                  },
                ),
                body: (state.isLoading)
                    ? CenterLoadingIndicator(isOnlyLoader: true)
                    : LayoutBuilder(builder: (context, constraint) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: Form(
                              autovalidateMode: (state.recurringErrorMessage)
                                  ? AutovalidateMode.always
                                  : AutovalidateMode.disabled,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getSize(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (shiftType == 1) ...[
                                          recurringCheckBox(context, state),
                                          paddingBetweenFields(),
                                          Visibility(
                                              visible: state.isToBeRecurring,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  recurringStartDateField(
                                                      context, state),
                                                  paddingBetweenFields(),
                                                  recurringEndDateField(
                                                      context, state),
                                                  paddingBetweenFields(),
                                                  recurrenceModeDropDown(
                                                      context, state),
                                                  if (state
                                                          .recurringErrorMessage &&
                                                      !state.recurrenceMode
                                                          .isValid())
                                                    commonErrorText(StringConstant
                                                        .pleaseSelectRecurrenceMode),
                                                  paddingBetweenFields(),
                                                  if (state.recurrenceMode
                                                          .getValue() ==
                                                      "Weekly") ...[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: getSize(18),
                                                          bottom: getSize(5)),
                                                      child: BaseText(
                                                        text: StringConstant
                                                            .selectTheDaysForRecurring,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    weeklyRecurringCheckBox(
                                                        context, state),
                                                    if (state
                                                            .recurringErrorMessage &&
                                                        !state
                                                            .recurrenceWeekList
                                                            .isValid())
                                                      commonErrorText(StringConstant
                                                          .pleaseSelectRecurrenceMode),
                                                    paddingBetweenFields(),
                                                  ],
                                                ],
                                              )),
                                        ],
                                        disclaimer(context, state),
                                        paddingBetweenFields(),
                                        sharePostCheckBox(context, state),
                                        paddingBetweenFields(),
                                        Visibility(
                                            visible: state.isShareWithTeams,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                selectTeamsList(context, state),
                                                if (state
                                                        .recurringErrorMessage &&
                                                    !state.selectedTeamList
                                                        .isValid())
                                                  commonErrorText(StringConstant
                                                      .pleaseSelectAtLeastOneTeam),
                                                paddingBetweenFields(),
                                              ],
                                            )),
                                        templateCheckBox(context, state),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: getSize(20)),
                                      child: CommonButton(
                                        onPressed: () {
                                          int? difference;
                                          DateTime? startDate =
                                              state.recurringStartDate.isValid()
                                                  ? DateTime.parse(state
                                                          .recurringStartDate
                                                          .getValue() ??
                                                      "")
                                                  : null;

                                          DateTime? endDate =
                                              state.recurringEndDate.isValid()
                                                  ? DateTime.parse(state
                                                          .recurringEndDate
                                                          .getValue() ??
                                                      "")
                                                  : null;

                                          if (startDate != null &&
                                              endDate != null) {
                                            difference = endDate
                                                .difference(startDate)
                                                .inDays;
                                          }
                                          if (difference != null &&
                                              difference > 20) {
                                            confirmationDialog(context, state,
                                                noOfShift: difference);
                                          } else {
                                            context.read<PostShiftBloc>().add(
                                                PostShiftEvent
                                                    .recurringButtonEvent(
                                                        context,
                                                        updateShift
                                                                ?.shift_detail
                                                                ?.id ??
                                                            -1));
                                          }
                                        },
                                        buttonText: StringConstant.txtContinue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  confirmationDialog(BuildContext context, PostShiftState state,
      {required int noOfShift}) {
    AppDialog.showDelete(
      context,
      title: StringConstant.confirmationRequired,
      infoMessage:
          "${StringConstant.confirmationRecurringDesc1} $noOfShift ${StringConstant.confirmationRecurringDesc2}",
      deleteBtnText: StringConstant.confirm,
      cancelText: StringConstant.cancle,
      onCancelClick: () {
        context.router.maybePop();
      },
      onDeleteClick: () {
        context.router.maybePop();
        context.read<PostShiftBloc>().add(PostShiftEvent.recurringButtonEvent(
            context, updateShift?.shift_detail?.id ?? -1));
      },
    );
  }

  Widget recurringCheckBox(
    BuildContext context,
    PostShiftState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          bool value = state.isToBeRecurring;
          value = !value;
          context
              .read<PostShiftBloc>()
              .add(PostShiftEvent.recurringCheck(value));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: state.isToBeRecurring,
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
                        .add(PostShiftEvent.recurringCheck(value));
                  }
                },
              ),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Flexible(
              child: BaseText(
                text: StringConstant.idLikeThisShiftToBeRecurring,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget disclaimer(BuildContext context, PostShiftState state) {
    return CustomTextField(
      labelText: StringConstant.disclaimer,
      hintText: StringConstant.typeHere,
      isOptional: true,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      initialValue: state.disclaimerNote,
      onChanged: (value) {
        context
            .read<PostShiftBloc>()
            .add(PostShiftEvent.disclaimerChanged(value));
      },
      validator: null,
    );
  }

  Widget sharePostCheckBox(
    BuildContext context,
    PostShiftState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          bool value = state.isShareWithTeams;
          value = !value;

          if (value == true && state.teamList.isEmpty) {
            showError(message: StringConstant.toShareThisPostDesc)
                .show(context);
          } else {
            context
                .read<PostShiftBloc>()
                .add(PostShiftEvent.shareWithTeamsCheck(value));
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: state.isShareWithTeams,
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
                    if (value == true && state.teamList.isEmpty) {
                      showError(message: StringConstant.toShareThisPostDesc)
                          .show(context);
                    } else {
                      context
                          .read<PostShiftBloc>()
                          .add(PostShiftEvent.shareWithTeamsCheck(value));
                    }
                  }
                },
              ),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Expanded(
              child: BaseText(
                text: StringConstant.shareThisPostingWithTheTeam,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                AppDialog.showInfo(
                  context,
                  StringConstant.teamInfoDesc,
                  maxLines: 10,
                );
              },
              child: SvgPicture.asset(
                SvgImageConstant.infoCircle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget templateCheckBox(
    BuildContext context,
    PostShiftState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          bool value = state.isSaveAsTemplate;
          value = !value;
          context
              .read<PostShiftBloc>()
              .add(PostShiftEvent.saveAsTemplateCheck(value));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: state.isSaveAsTemplate,
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
                        .add(PostShiftEvent.saveAsTemplateCheck(value));
                  }
                },
              ),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Expanded(
              child: BaseText(
                text: StringConstant.saveThisAsATemplateForFuturePosting,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                AppDialog.showInfo(
                  context,
                  StringConstant.saveTemplateInfoDesc,
                  maxLines: 10,
                );
              },
              child: SvgPicture.asset(
                SvgImageConstant.infoCircle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget recurringStartDateField(BuildContext context, PostShiftState state) {
    return CustomTextField(
      labelText: StringConstant.startDateForRecurrence,
      hintText: (state.recurringStartDate.isValid())
          ? DateFormat('d MMM, yyyy')
              .format(DateTime.parse(state.recurringStartDate.getValue() ?? ""))
          : StringConstant.startDateForRecurrence,
      hintAsValue: (state.recurringStartDate.isValid()) ? true : false,
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
      onTap: () {
        print(
            "START FIRST DATE---> ${DateTime.fromMillisecondsSinceEpoch((double.parse(post.date!).toInt()) * 1000)}");
        DocumentExpiryDatePicker.customDatePicker(
          context,
          firstDate: (post.date != null && post.date!.isNotEmpty)
              ? DateTime.fromMillisecondsSinceEpoch(
                      (double.parse(post.date!).toInt()) * 1000)
                  .add(Duration(days: 1))
              : DateTime.now(),
          onPickedDate: (pickedDate) {
            context
                .read<PostShiftBloc>()
                .add(PostShiftEvent.recurringStartDateChanged(
                  pickedDate.toString(),
                ));
          },
          onCancelClick: () {},
          selectedDate: (state.recurringStartDate.isValid())
              ? DateTime.parse(state.recurringStartDate.getValue() ?? "")
              : DateTime.fromMillisecondsSinceEpoch(
                      (double.parse(post.date!).toInt()) * 1000)
                  .add(Duration(days: 1)),
        );
      },
      validator: (_, context) =>
          context.read<PostShiftBloc>().state.recurringStartDate.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectStartDate,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget recurrenceModeDropDown(BuildContext context, PostShiftState state) {
    /*bool isRangeMoreThanWeek = false;
    DateTime? startDate = state.recurringStartDate.isValid()
        ? DateTime.parse(state.recurringStartDate.getValue() ?? "")
        : null;

    DateTime? endDate = state.recurringEndDate.isValid()
        ? DateTime.parse(state.recurringEndDate.getValue() ?? "")
        : null;

    if (startDate != null && endDate != null) {
      int difference = endDate.difference(startDate).inDays;
      if (difference >= 7) {
        isRangeMoreThanWeek = true;
        print("isRengeMoreThanWeek---> $isRangeMoreThanWeek");
      }
    }*/

    print("isRangeMoreThanWeek----> ${state.isRangeMoreThanWeek}");
    return CustomDropdwonWithTextField(
      labelText: StringConstant.recurrenceMode,
      hintText: StringConstant.recurrenceMode,
      showTextfield: false,
      isLabelPadding: true,
      value: (state.recurrenceMode.isValid())
          ? state.recurrenceMode.getValue()
          : null,
      items: (state.isRangeMoreThanWeek)
          ? CommonList.recurrenceModeList.map((val) {
              return DropdownMenuItem<String>(
                value: val,
                child: BaseText(
                  text: val,
                  fontSize: 14,
                  textColor: AppColors.black,
                ),
              );
            }).toList()
          : CommonList.recurrenceModeOnlyDaily.map((val) {
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
              .add(PostShiftEvent.recurrenceModeChanged(value, context));
        }
      },
    );
  }

  Widget recurringEndDateField(BuildContext context, PostShiftState state) {
    final firstDate = (state.recurringStartDate.isValid())
        ? DateTime.parse(state.recurringStartDate.getValue() ?? "")
            .add(Duration(days: 1))
        : (post.date != null && post.date!.isNotEmpty)
            ? DateTime.fromMillisecondsSinceEpoch(
                    (double.parse(post.date!).toInt()) * 1000)
                .add(Duration(days: 1))
            : DateTime.now();

    final initialDate = (state.recurringEndDate.isValid())
        ? DateTime.parse(state.recurringEndDate.getValue() ?? "")
        : (state.recurringStartDate.isValid())
            ? DateTime.parse(state.recurringStartDate.getValue() ?? "")
                .add(Duration(days: 1))
            : DateTime.fromMillisecondsSinceEpoch(
                    (double.parse(post.date!).toInt()) * 1000)
                .add(Duration(days: 1));

    return CustomTextField(
      labelText: StringConstant.endDateForRecurrence,
      hintText: (state.recurringEndDate.isValid())
          ? DateFormat('d MMM, yyyy')
              .format(DateTime.parse(state.recurringEndDate.getValue() ?? ""))
          : StringConstant.endDateForRecurrence,
      hintAsValue: (state.recurringEndDate.isValid()) ? true : false,
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
      onTap: () {
        DocumentExpiryDatePicker.customDatePicker(
          context,
          // firstDate: DateTime.now(),
          firstDate: firstDate,
          onPickedDate: (pickedDate) {
            context
                .read<PostShiftBloc>()
                .add(PostShiftEvent.recurringEndDateChanged(
                  pickedDate.toString(),
                ));
          },
          onCancelClick: () {},
          selectedDate: initialDate,
        );
      },
      validator: (_, context) =>
          context.read<PostShiftBloc>().state.recurringEndDate.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectEndDate,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget weeklyRecurringCheckBox(
    BuildContext context,
    PostShiftState state,
  ) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(10),
        ),
        decoration: BoxDecoration(
            color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: CommonList.weekList.length,
            itemBuilder: (context, index) {
              final weekList = CommonList.weekList;
              bool isDayCheck = state.recurrenceWeekList
                  .getValue()
                  .any((item) => item.id == index);

              return GestureDetector(
                onTap: () {
                  context.read<PostShiftBloc>().add(
                      PostShiftEvent.recurrenceWeeksChanged(weekList[index]));
                },
                child: Container(
                  color: AppColors.transparent,
                  padding: EdgeInsets.symmetric(vertical: getSize(5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: getSize(40),
                        width: getSize(36.67),
                        child: Checkbox(
                          value: isDayCheck,
                          visualDensity: VisualDensity.compact,
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
                              context.read<PostShiftBloc>().add(
                                  PostShiftEvent.recurrenceWeeksChanged(
                                      weekList[index]));
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: getSize(15),
                      ),
                      Flexible(
                        child: BaseText(
                          text: weekList[index].name ?? "",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  Widget selectTeamsList(
    BuildContext context,
    PostShiftState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(18), bottom: getSize(5)),
          child: BaseText(
            text: StringConstant.selectTeams,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: getSize(20),
            // vertical: getSize(10),
          ),
          decoration: BoxDecoration(
              color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: getSize(250)),
            child: ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: state.teamList.length,
                itemBuilder: (context, index) {
                  final teamList = state.teamList;
                  bool isTeamCheck =
                      state.selectedTeamList.getValue().any((item) {
                    print("is team check---> ${item.id == teamList[index].id}");

                    return item.id == teamList[index].id;
                  });
                  // print("is team check---> ${state.selectedTeamList}}");
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: getSize(5)),
                    child: GestureDetector(
                      onTap: () {
                        print("Teams selected index--> ${teamList[index].id}");
                        context.read<PostShiftBloc>().add(
                            PostShiftEvent.selectTeamEvent(teamList[index]));
                      },
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        minVerticalPadding: 0,
                        leading: SvgPicture.asset(
                          SvgImageConstant.threePersonWithPlus,
                          height: getSize(24),
                          width: getSize(24),
                        ),
                        dense: true,

                        title: BaseText(
                          text: teamList[index].name ?? '',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        trailing: Container(
                          color: Colors.transparent,
                          // height: getSize(0),
                          // width: getSize(26.67),
                          // padding: EdgeInsets.all(getSize(10)),
                          child: Checkbox(
                            value: isTeamCheck,
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
                                context.read<PostShiftBloc>().add(
                                    PostShiftEvent.selectTeamEvent(
                                        teamList[index]));
                              }
                            },
                          ),
                        ),
                        // ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
