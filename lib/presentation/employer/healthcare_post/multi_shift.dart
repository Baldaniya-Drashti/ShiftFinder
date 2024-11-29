// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/employer/healthcare_post/different_time_for_each_date.dart';
import 'package:shift/presentation/employer/healthcare_post/same_time_for_multi_date.dart';

class MultiPostShift extends StatelessWidget {
  int shiftType;
  int postId;
  PostShiftDTO post;
  HealthcarePostDTO? updateShift;
  final bool fromSaveTemplate;

  MultiPostShift({
    super.key,
    this.updateShift,
    required this.shiftType,
    required this.postId,
    required this.post,
    this.fromSaveTemplate = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PostShiftBloc>()..add(PostShiftEvent.changeShiftType("Multi", postId: postId, post: post, updateShift: updateShift)),
      child: BlocConsumer<PostShiftBloc, PostShiftState>(
        listener: (context, state) {},
        builder: (context, state) {
          return (state.isLoading)
              ? CenterLoadingIndicator(isOnlyLoader: true)
              : Form(
                  autovalidateMode: (state.singleShiftErrorMessages) ? AutovalidateMode.always : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(visible: state.updateShift.id == null, child: sameOrDifferentRadio(context, state)),
                      paddingBetweenFields(),
                      (state.selectedMultiShiftType == 1)
                          ? SameTimeForMultiDate(fromSaveTemplate: fromSaveTemplate,)
                          : DifferentTimeForEachDate(
                              post: post,
                            ),
                    ],
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

  Widget sameOrDifferentRadio(BuildContext context, PostShiftState state) {
    print("selected multi shift type --> ${state.selectedMultiShiftType}");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getSize(20), vertical: getSize(10)),
      margin: EdgeInsets.only(top: getSize(15)),
      decoration: BoxDecoration(color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            value: StringConstant.sameTimeForAllDates,
            groupValue: (state.selectedMultiShiftType == 2) ? StringConstant.differentTimeForEachDate : StringConstant.sameTimeForAllDates,
            onChanged: (value) {
              context.read<PostShiftBloc>().add(PostShiftEvent.multiDateSameDiffTypeChanged(1));
            },
            title: BaseText(
              text: StringConstant.sameTimeForAllDates,
              fontSize: 12,
            ),
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeColor: AppColors.primaryColor,
          ),
          Divider(
            indent: getSize(10),
            endIndent: getSize(10),
            thickness: getSize(0.5),
            height: 0,
          ),
          RadioListTile(
            value: StringConstant.differentTimeForEachDate,
            groupValue: (state.selectedMultiShiftType == 2) ? StringConstant.differentTimeForEachDate : StringConstant.sameTimeForAllDates,
            onChanged: (value) {
              context.read<PostShiftBloc>().add(PostShiftEvent.multiDateSameDiffTypeChanged(2));
            },
            title: BaseText(
              text: StringConstant.differentTimeForEachDate,
              fontSize: 12,
            ),
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
