// ignore_for_file: avoid_print, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/employer/healthcare_post/multi_shift.dart';
import 'package:shift/presentation/employer/healthcare_post/single_shift.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'healthcarePostShift')
class HealthcarePostShift extends StatelessWidget {
  int postId;
  HealthcarePostDTO? updateShift;
  PostShiftDTO post;
  final bool fromSaveTemplate;

  HealthcarePostShift({super.key, required this.postId, this.updateShift, required this.post, this.fromSaveTemplate = false});

  @override
  Widget build(BuildContext context) {
    Log.debug("fromSaveTemplate ${fromSaveTemplate}");
    print("Post getting from previous---> ${jsonEncode(updateShift)}");
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: BlocProvider(
          create: (context) => getIt<PostShiftBloc>()
            ..add(PostShiftEvent.changeShiftType("Single",
                postId: postId, post: post, updateShift: updateShift, fromSaveTemplate: fromSaveTemplate)),
          child: BlocBuilder<PostShiftBloc, PostShiftState>(
            builder: (context, state) {
              return Scaffold(
                appBar: CommonAppBar(
                  onBackPressed: () {
                    Navigator.pop(context);
                  },
                  title: state.fromSaveTemplate
                      ? "Edit Template"
                      : (state.updateShift.id != null && state.updateShift.shift_detail != null)
                          ? (state.updateShift.shift_detail!.shift_type == 1)
                              ? StringConstant.singleShift
                              : (state.updateShift.shift_detail!.same_or_different_time == 1)
                                  ? StringConstant.sameTimeForAllDates
                                  : StringConstant.differentTimeForEachDate
                          : StringConstant.healthcare,
                ),
                body: LayoutBuilder(builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: state.updateShift.id == null,
                            child: CustomDropdwonWithTextField(
                              hintText: "",
                              isLabelPadding: true,
                              showTextfield: false,
                              labelText: StringConstant.shiftType,
                              value: PostShiftBloc.shiftTypeList
                                  .firstWhere(
                                    (shift) => shift.id == state.shiftType,
                                    orElse: () => SkillDTO(id: 1, name: "Single"),
                                  )
                                  .name,
                              items: PostShiftBloc.shiftTypeList.map((val) {
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
                                      .add(PostShiftEvent.changeShiftType(value, postId: postId, post: null, updateShift: null));
                                }
                              },
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraint.maxHeight),
                            child:
                                /*(state.shiftType == 3)
                                ? Center(
                                    child: BaseText(
                                      text: StringConstant.longTerm,
                                      fontSize: 25,
                                    ),
                                  ): */
                                (state.shiftType == 2)
                                    ? MultiPostShift(
                                        shiftType: state.shiftType,
                                        postId: postId,
                                        post: post,
                                        updateShift: updateShift,
                                        fromSaveTemplate: fromSaveTemplate,

                                      )
                                    : SinglePostShift(
                                        shiftType: state.shiftType,
                                        postId: postId,
                                        post: post,
                                        updateShift: updateShift,
                                        fromSaveTemplate: fromSaveTemplate,
                                      ),
                          ),
                        ],
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
}
