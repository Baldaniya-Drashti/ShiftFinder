// ignore_for_file: prefer_const_constructors_in_immutables, deprecated_member_use, avoid_print, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/education_dto/education_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addEducationDetailScreen')
class AddEducationDetail extends StatelessWidget {
  bool isFromSplash = false;
  EducationDTO? educationObj;

  AddEducationDetail({super.key, this.isFromSplash = false, this.educationObj});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EducationDetailBloc>()
        ..add(EducationDetailEvent.educationObjEvent(educationObj)),
      child: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: Scaffold(
          appBar: CommonAppBar(
            isShowBackBtn: !isFromSplash,
            onBackPressed: () {
              context.router.maybePop();
            },
            title: StringConstant.education,
          ),
          body: BlocConsumer<EducationDetailBloc, EducationDetailState>(
            listener: (context, state) {
              state.failureOrSuccessOption.fold(
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
                    Navigator.pop(context, true);
                  },
                ),
              );
            },
            builder: (context, state) {
              return (state.isSubmitting)
                  ? CenterLoadingIndicator(isOnlyLoader: true)
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            autovalidateMode:
                                state.showAddEducationErrorMessages
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                            child: Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    programField(context, state),
                                    paddingBetweenFields(),
                                    completionYearField(context, state),
                                    paddingBetweenFields(),
                                    graduatingField(context, state),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: getSize(40), top: getSize(10)),
                            child: CommonButton(
                              isSubmitting: state.isSubmitting,
                              onPressed: () {
                                context
                                    .read<EducationDetailBloc>()
                                    .add(EducationDetailEvent.onAddBtnPressed(
                                      educationObj != null,
                                      id: educationObj?.id,
                                    ));
                              },
                              buttonText: (educationObj != null)
                                  ? StringConstant.update
                                  : StringConstant.add,
                            ),
                          ),
                        ],
                      ),
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

  Widget programField(BuildContext context, EducationDetailState state) {
    return CustomTextField(
      labelText: StringConstant.programCompleted,
      isLabelPadding: true,
      hintText: StringConstant.programCompleted,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      initialValue: state.selectedProgram.getValue(),
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.capOutline,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) => context
          .read<EducationDetailBloc>()
          .add(EducationDetailEvent.addProgramChanged(value)),
      validator: (_, context) =>
          context.read<EducationDetailBloc>().state.selectedProgram.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddCompletedProgram,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget completionYearField(BuildContext context, EducationDetailState state) {
    return CustomTextField(
      labelText: StringConstant.yearOfCompletion,
      isLabelPadding: true,
      readOnly: true,
      onTap: () {
        showYearPicker(context, state);
      },
      hintText: (state.yearOfCompletion.getValue()!.isNotEmpty)
          ? state.yearOfCompletion.getValue()
          : StringConstant.yearOfCompletion,
      hintAsValue:
          (state.yearOfCompletion.getValue()!.isNotEmpty) ? true : false,
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
      validator: (_, context) =>
          context.read<EducationDetailBloc>().state.yearOfCompletion.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectCompletionYear,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget graduatingField(BuildContext context, EducationDetailState state) {
    return CustomTextField(
      labelText: StringConstant.graduatingInstitution,
      isLabelPadding: true,
      hintText: StringConstant.graduatingInstitution,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      initialValue: state.selectedGraduation.getValue(),
      textCapitalization: TextCapitalization.words,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.institute,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) => context
          .read<EducationDetailBloc>()
          .add(EducationDetailEvent.addInstituteChanged(value)),
      validator: (_, context) => context
          .read<EducationDetailBloc>()
          .state
          .selectedGraduation
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseAddGradutionInstitute,
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }

  Future<void> showYearPicker(
      BuildContext context, EducationDetailState state) async {
    await showDialog(
      context: context,
      builder: (_) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor, // header background color
              onPrimary: AppColors.black, // header text color
              onSurface: AppColors.black,
            ),
          ),
          child: AlertDialog(
            title: const BaseText(
              text: "Select Year",
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              width: getSize(500),
              height: getSize(400),
              child: YearPicker(
                firstDate: DateTime(1950, 1),
                lastDate: DateTime(DateTime.now().year, 1),
                initialDate: DateTime.now(),
                selectedDate: (state.yearOfCompletion.getValue()!.isNotEmpty)
                    ? DateTime(int.parse(state.yearOfCompletion.getValue()!))
                    : DateTime(DateTime.now().year),
                onChanged: (DateTime dateTime) {
                  Navigator.pop(context, dateTime);
                },
              ),
            ),
          ),
        );
      },
    ).then((value) {
      if (value != null && value is DateTime) {
        print("onback value---> $value");

        context.read<EducationDetailBloc>().add(
              EducationDetailEvent.addCompletionYearChanged(
                  value.year.toString()),
            );
      }
    });
  }
}
