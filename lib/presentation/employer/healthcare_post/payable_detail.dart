// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_string_interpolations, must_be_immutable, avoid_print

import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/payable_dto.dart/payable_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'payableDetail')
class PayableDetail extends StatelessWidget {
  HealthcarePostDTO post;
  PostShiftDTO? updatedPost;
  bool isUpdate;
  final bool fromSaveTemplate;

  PayableDetail({super.key, required this.post, this.isUpdate = false, this.updatedPost, this.fromSaveTemplate = false});

  @override
  Widget build(BuildContext context) {
    Log.success("fromSaveTemplate ${fromSaveTemplate}");
    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (context) => getIt<PostShiftBloc>(),
        child: BlocConsumer<PostShiftBloc, PostShiftState>(
          listener: (context, state) {
            state.postShiftFailureOrSuccessOption.fold(
              () {},
              (either) => either.fold(
                (failure) {
                  showError(
                    message: failure.maybeMap(
                      showAPIResponseMessage: (value) => value.message,
                      networkError: (value) => 'Please check your internet connectivity',
                      orElse: () => "Server Error. Try again later.",
                    ),
                  ).show(context);
                },
                (r) {
                  AppDialog.showSuccess(
                    context,
                    title: StringConstant.allSet,
                    infoMessage: r,
                    onOkClick: () {
                      // context.router.maybePop();
                      context.router.popUntil(
                        (route) => route.isFirst,
                      );
                    },
                  );
                },
              ),
            );
            state.updatePostFailureOrSuccessOption.fold(
              () {},
              (either) => either.fold(
                (failure) {
                  showError(
                    message: failure.maybeMap(
                      showAPIResponseMessage: (value) => value.message,
                      networkError: (value) => 'Please check your internet connectivity',
                      orElse: () => "Server Error. Try again later.",
                    ),
                  ).show(context);
                },
                (r) {
                  AppDialog.showSuccess(
                    context,
                    title: StringConstant.allSet,
                    infoMessage: r.dioMessage ?? "",
                    onOkClick: () {
                      // context.router.maybePop();

                      context.router.popUntil(
                        (route) => route.isFirst,
                      );
                    },
                  );
                },
              ),
            );
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.scaffoldColor,
              appBar: CommonAppBar(
                onBackPressed: () {
                  Navigator.pop(context);
                },
                title: StringConstant.payables,
              ),
              body: (state.isLoading)
                  ? CenterLoadingIndicator()
                  : LayoutBuilder(builder: (context, constraint) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraint.maxHeight),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: getSize(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (post.shift_detail != null &&
                                        post.shift_detail!.shift_type == 1)
                                    ? singleShiftSlip()
                                    : (post.shift_detail != null &&
                                            post.shift_detail!
                                                    .same_or_different_time ==
                                                1)
                                        ? sameMultiShiftSlip()
                                        : differentMultiShiftSlip(),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getSize(20)),
                                  child: CommonButton(
                                    onPressed: () {
                                      AppDialog.showDelete(
                                        context,
                                        title: (isUpdate && !fromSaveTemplate)
                                            ? StringConstant.updateTheShift
                                            : StringConstant.postTheShift,
                                        infoMessage: (isUpdate && !fromSaveTemplate)
                                            ? StringConstant.updateShiftDesc
                                            : StringConstant.postShiftDesc,
                                        deleteBtnText: isUpdate && !fromSaveTemplate
                                            ? StringConstant.update
                                            : StringConstant.post,
                                        onCancelClick: () {
                                          Navigator.pop(context);
                                        },
                                        onDeleteClick: () {
                                          Navigator.pop(context);
                                          context.read<PostShiftBloc>().add(
                                                  PostShiftEvent
                                                      .postTheShiftEvent(
                                                post.id ?? -1,
                                                (isUpdate && !fromSaveTemplate) ? updatedPost : null,fromSaveTemplate,
                                              ));
                                        },
                                      );
                                    },
                                    buttonText: (isUpdate && !fromSaveTemplate)
                                        ? StringConstant.updateTheShift
                                        : StringConstant.postTheShift,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
            );
          },
        ),
      ),
    );
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
          fontWeight: FontWeight.w500,
          textColor: AppColors.black.withOpacity(0.7),
        ),
        BaseText(
          text: value,
          fontSize: (isLast) ? 14 : 12,
          fontWeight: (isLast) ? FontWeight.w600 : FontWeight.w500,
          textColor: (isFirst) ? AppColors.primaryColor : AppColors.black,
        ),
      ],
    );
  }

  Widget commonDivider() {
    return Divider(
      color: AppColors.black.withOpacity(0.2),
      thickness: getSize(0.5),
    );
  }

  Widget payableBox({
    required String title1,
    String? title2,
    required String value1,
    String? value2,
    String? title3,
    String? value3,
    String? totalPayableTitle,
    String? totalPayable,
    Color? backgroundColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.grey04,
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        dense: true,
        visualDensity: VisualDensity.compact,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paybaleTitleRate(
              title: title1,
              value: value1,
            ),
            if (title2 != null) ...[
              paddingBetweenFields(),
              paybaleTitleRate(
                title: title2,
                value: value2 ?? "",
              ),
            ],
            if (title3 != null) ...[
              paddingBetweenFields(),
              paybaleTitleRate(
                title: title3,
                value: value3 ?? "",
              ),
            ],
            if (totalPayable != null) ...[
              commonDivider(),
              paybaleTitleRate(
                title: totalPayableTitle ?? "",
                value: totalPayable,
                isLast: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget totalPayableBox({
    String? totalPayableTitle,
    String? totalPayable,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        dense: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paybaleTitleRate(
              title: totalPayableTitle ?? "",
              value: totalPayable ?? "",
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 10),
    );
  }

  Widget differentMultiShiftSlip() {
    final shift = post.shift_detail?.payables ?? PayableDTO();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        payableBox(
          title1: StringConstant.numberOfShifts,
          value1:
              "${(shift.number_of_shift.toString().length == 2) ? shift.number_of_shift : "0${shift.number_of_shift}"}",
        ),
        payableBox(
          title1: StringConstant.payableHours,
          title2: StringConstant.hourlyRate,
          value1: shift.total_payable_hour ?? "",
          value2: "\$${shift.rate_hour}",
          totalPayableTitle: StringConstant.totalWage,
          totalPayable: "\$${shift.total_wage}",
        ),
        payableBox(
          title1: StringConstant.commuteAllowance,
          title2: StringConstant.accommodationAllowance,
          value1: "\$${shift.commute_allowance}",
          value2: "\$${shift.accommodation_allowance}",
          // totalPayableTitle: StringConstant.allowanceForOneShift,
          // totalPayable: "\$${shift.total_one_allowance}",
          totalPayableTitle: StringConstant.totalAllowances,
          totalPayable: "\$${shift.total_allowance}",
        ),
        /* payableBox(
          title1: StringConstant.numberOfShifts,
          title2: StringConstant.totalAllowances,
          value1:
              "${(shift.number_of_shift.toString().length == 2) ? shift.number_of_shift ?? 0 : "0${shift.number_of_shift}"}",
          value2: "\$${shift.total_allowance}",
        ), */
        /* payableBox(
          title1: StringConstant.shiftFinderServiceFee,
          value1: "\$${shift.service_one_fee}",
          title2: StringConstant.numberOfShifts,
          value2:
              "${(shift.number_of_shift.toString().length == 2) ? shift.number_of_shift ?? 0 : "0${shift.number_of_shift}"}",
          totalPayableTitle: StringConstant.totalShiftFinderServiceFee,
          totalPayable: "\$${shift.service_one_fee}",
        ), */
        payableBox(
          title1: StringConstant.shiftFinderServiceFee,
          value1: "\$${shift.service_fee}",
          title2: StringConstant.thirdPartyProcessingFee,
          value2: "\$${shift.third_party_fee}",
          title3: StringConstant.tax,
          value3: "\$${shift.third_party_tax_fee}",
        ),
        payableBox(
          title1: StringConstant.numberOfVacancies,
          value1:
              "${(shift.number_of_vacancie.toString().length == 2) ? shift.number_of_vacancie ?? 0 : "0${shift.number_of_vacancie}"}",
        ),
        totalPayableBox(
          totalPayableTitle: StringConstant.estimatedTotalPayable,
          totalPayable: "\$${shift.total_amount_payable}",
        ),
        /* payableBox(
          title1: StringConstant.totalNumberOfDays,
          title2: StringConstant.totalPayableHours,
          title3: StringConstant.hourlyRate,
          // value1: "${post.shift_detail?.detail?.length} ?? 0",
          value1:
              "${(post.shift_detail?.detail?.length.toString().length == 2) ? post.shift_detail?.detail?.length ?? 0 : "0${post.shift_detail?.detail?.length}"}",
          value2: shift.total_payable_hour,
          value3: "\$${shift.rate_hour}",
          totalPayableTitle: StringConstant.totalWage,
          totalPayable: "\$${shift.total_wage}",
        ),
        payableBox(
          title1: StringConstant.totalCommuteAllowance,
          title2: StringConstant.totalAccommodationAllowance,
          value1: "\$${shift.commute_allowance}",
          value2: "\$${shift.accommodation_allowance}",
          totalPayableTitle: StringConstant.totalAllowance,
          totalPayable: "\$${shift.total_allowance}",
        ),
        payableBox(
          title1: StringConstant.shiftFinderServiceFee,
          value1: "\$${shift.service_fee}",
        ),
        payableBox(
          title1: StringConstant.sumOfAmounts,
          title2: StringConstant.numberOfVacancies,
          value1: "\$${shift.total_one_shift}",
          value2:
              "${(shift.number_of_vacancie.toString().length == 2) ? shift.number_of_vacancie ?? 0 : "0${shift.number_of_vacancie}"}",
        ),
        totalPayableBox(
          totalPayableTitle: StringConstant.totalAmount,
          totalPayable: "\$${shift.total_amount_payable}",
        ), */
      ],
    );
  }

  Widget sameMultiShiftSlip() {
    final shift = post.shift_detail?.payables ?? PayableDTO();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        payableBox(
          title1: StringConstant.numberOfShifts,
          value1:
              "${(shift.number_of_shift.toString().length == 2) ? shift.number_of_shift : "0${shift.number_of_shift}"}",
        ),
        payableBox(
          title1: StringConstant.payableHours,
          title2: StringConstant.hourlyRate,
          value1: shift.total_payable_hour ?? "",
          value2: "\$${shift.rate_hour}",
          totalPayableTitle: StringConstant.totalWage,
          totalPayable: "\$${shift.total_wage}",
        ),
        payableBox(
          title1: StringConstant.commuteAllowance,
          title2: StringConstant.accommodationAllowance,
          value1: "\$${shift.commute_allowance}",
          value2: "\$${shift.accommodation_allowance}",
          totalPayableTitle: StringConstant.totalAllowances,
          totalPayable: "\$${shift.total_one_allowance}",
        ),
        payableBox(
          title1: StringConstant.shiftFinderServiceFee,
          value1: "\$${shift.service_one_fee}",
          title2: StringConstant.thirdPartyProcessingFee,
          value2: "\$${shift.third_party_fee}",
          title3: StringConstant.tax,
          value3: "\$${shift.third_party_tax_fee}",
        ),
        payableBox(
          /*    title1: StringConstant.totalPayableForOneShift,
          value1: "\$${shift.total_one_shift}",
          title2: StringConstant.numberOfShifts,
          value2:
              "${(shift.number_of_shift.toString().length == 2) ? shift.number_of_shift ?? 0 : "0${shift.number_of_shift}"}",
          title3: StringConstant.numberOfVacancies,
          value3:
              "${(shift.number_of_vacancie.toString().length == 2) ? shift.number_of_vacancie ?? 0 : "0${shift.number_of_vacancie}"}", */
          title1: StringConstant.numberOfVacancies,
          value1:
              "${(shift.number_of_vacancie.toString().length == 2) ? shift.number_of_vacancie ?? 0 : "0${shift.number_of_vacancie}"}",
        ),
        totalPayableBox(
          totalPayableTitle: StringConstant.estimatedTotalAmount,
          totalPayable: "\$${shift.total_amount_payable}",
        ),
      ],
    );
  }

  Widget singleShiftSlip() {
    final shift = post.shift_detail?.payables ?? PayableDTO();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        payableBox(
          title1: StringConstant.numberOfShifts,
          value1:
              "${(shift.number_of_shift.toString().length == 2) ? shift.number_of_shift : "0${shift.number_of_shift}"}",
        ),
        payableBox(
          title1: StringConstant.payableHours,
          value1: shift.total_payable_hour ?? "",
          title2: StringConstant.hourlyRate,
          value2: "\$${shift.rate_hour}",
          totalPayableTitle: StringConstant.totalWage,
          totalPayable: "\$${shift.total_wage}",
        ),
        payableBox(
          title1: StringConstant.commuteAllowance,
          value1: "\$${shift.commute_allowance}",
          title2: StringConstant.accommodationAllowance,
          value2: "\$${shift.accommodation_allowance}",
          totalPayableTitle: StringConstant.totalAllowances,
          totalPayable: "\$${shift.total_one_allowance}",
        ),
        payableBox(
          title1: StringConstant.shiftFinderServiceFee,
          value1: "\$${shift.service_one_fee}",
          title2: StringConstant.thirdPartyProcessingFee,
          value2: "\$${shift.third_party_fee}",
          title3: StringConstant.tax,
          value3: "\$${shift.third_party_tax_fee}",
        ),
        payableBox(
          // title1: StringConstant.totalPayableForOneShift,
          // value1: "\$${shift.total_one_shift}",
          title1: StringConstant.numberOfVacancies,
          value1:
              "${(shift.number_of_vacancie.toString().length == 2) ? shift.number_of_vacancie ?? 0 : "0${shift.number_of_vacancie}"}",
        ),
        totalPayableBox(
          totalPayableTitle: StringConstant.estimatedTotalPayable,
          totalPayable: "\$${shift.total_amount_payable}",
        ),
      ],
    );
  }
}
