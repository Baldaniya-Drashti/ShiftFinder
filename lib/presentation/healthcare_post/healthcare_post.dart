// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_chip_list.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'healthCarePostForm')
class HealthCarePostForm extends StatelessWidget {
  HealthCarePostForm({super.key});

  final List<String> requiredSpecialtiesList = [
    'Anesthesiology',
    'Behavioral Health',
    'Urology',
    'Perinatal',
    'NICU',
    'Other',
  ];

  final List<String> preferredSoftwareSkillList = [
    "Visual Studio code",
    "Android Studio",
    "Sublime Text",
    "Bluefish",
    "Notepad++",
    "OTHER",
  ];

  TextEditingController otherSpecialitiesController = TextEditingController();
  TextEditingController otherPreferredSkillsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HealthcarePostBloc>(),
      child: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () {
                context.router.back();
              },
              title: StringConstant.healthcare,
            ),
            body: BlocConsumer<HealthcarePostBloc, HealthcarePostState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  child: Form(
                    autovalidateMode: state.showErrorMessages
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            PngImageConstants.healthcare_post,
                          ),
                          paddingBetweenFields(),
                          roleDropDown(context, state),
                          paddingBetweenFields(),
                          requiredSpecialityDropDownChipset(context, state),
                          paddingBetweenFields(),
                          preferredSoftwareSkillsDropDownChipSet(
                              context, state),
                          paddingBetweenFields(),
                          languageRequirementsDropDown(context, state),
                          paddingBetweenFields(),
                          locationTextField(context, state),
                          paddingBetweenFields(),
                          rateHourDropDown(context, state),

                          /// chip example From here
                          paddingBetweenFields(),

                          /// To here
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: getSize(50)),
                            child: CommonButton(
                              onPressed: () {
                                context.read<HealthcarePostBloc>().add(
                                    const HealthcarePostEvent
                                        .continueBtnPressed());
                              },
                              buttonText: StringConstant.txtContinue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  Widget roleDropDown(BuildContext context, HealthcarePostState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.theRole,
      isLabelPadding: true,
      showTextfield: "".toLowerCase().contains("other"),
      items: const ["Project Manager", "Team Leader", "Employee"],
      validator: (p0) =>
          context.read<HealthcarePostBloc>().state.roleType.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => "Please select role Type",
                  orElse: () => null,
                ),
                (_) => null,
              ),
      onChanged: (value) {
        if (value != null) {
          context.read<HealthcarePostBloc>().add(
                HealthcarePostEvent.roleTypeChanged(value),
              );
        }
      },
      hintText: StringConstant.theRole,
    );
  }

  Widget languageRequirementsDropDown(
      BuildContext context, HealthcarePostState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.languageRequirements,
      isLabelPadding: true,
      showTextfield: "".toLowerCase().contains("other"),
      items: const [
        "English",
        "Hindi",
        "Gujarati",
        "Bengali",
        "Marathi",
        "Punjabi",
        "Tamil",
        "Kannad",
      ],
      validator: (p0) =>
          context.read<HealthcarePostBloc>().state.selectedLanguage.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => "Please select language requirement",
                  orElse: () => null,
                ),
                (_) => null,
              ),
      onChanged: (value) {
        if (value != null) {
          context.read<HealthcarePostBloc>().add(
                HealthcarePostEvent.selectedLanguageChanged(value),
              );
        }
      },
      hintText: StringConstant.languageRequirements,
    );
  }

  Widget rateHourDropDown(BuildContext context, HealthcarePostState state) {
    return CustomTextField(
      labelText: StringConstant.rateHour,
      isLabelPadding: true,
      hintText: StringConstant.rateHour,
      errorMaxLines: 2,
      onChanged: (value) {
        context
            .read<HealthcarePostBloc>()
            .add(HealthcarePostEvent.rateHourChanged(value));
      },
      validator: (p0, p1) =>
          context.read<HealthcarePostBloc>().state.rateHour.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => "Please enter Rate/Hour",
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget locationTextField(
    BuildContext context,
    HealthcarePostState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.location,
      isLabelPadding: true,
      hintText: StringConstant.location,
      textCapitalization: TextCapitalization.words,
      errorMaxLines: 2,
      onChanged: (value) {
        context
            .read<HealthcarePostBloc>()
            .add(HealthcarePostEvent.locationChanged(value));
      },
      validator: (p0, p1) =>
          context.read<HealthcarePostBloc>().state.location.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => "Please enter location",
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

  Widget requiredSpecialityDropDownChipset(
      BuildContext context, HealthcarePostState state) {
    // final List<String> _selectedOptions = [];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomDropdwonWithTextField(
          isLabelPadding: true,
          isOptional: true,
          fieldController: otherSpecialitiesController,
          labelText: StringConstant.requiredSpecialties,
          hintText: StringConstant.requiredSpecialties,
          showTextfield:
              state.requiredSpecialityChip.toLowerCase().contains("other"),
          items: requiredSpecialtiesList,
          value: (state.requiredSpecialityChip.isEmpty)
              ? null
              : state.requiredSpecialityChip,
          onChanged: (newValue) {
            if (newValue != null) {
              context.read<HealthcarePostBloc>().add(
                  HealthcarePostEvent.addRequiredSpecialitichips(newValue));
            }
          },
          suffixIcon: CommonButton(
            height: getSize(27),
            width: getSize(59),
            borderRadius: getSize(10),
            buttonText: StringConstant.add,
            buttonFontSize: 10,
            onPressed: () {
              context.read<HealthcarePostBloc>().add(
                    HealthcarePostEvent.addRequiredSpecialitichips(
                      otherSpecialitiesController.text,
                      isOtherValue: true,
                    ),
                  );
              otherSpecialitiesController.clear();
            },
          ),
        ),

        CustomChipSet(
          chipList: state.requiredSpecialityChipList,
          onDelete: (value) {
            context
                .read<HealthcarePostBloc>()
                .add(HealthcarePostEvent.removeRequiredSpecialitichips(value));
          },
        ),
        // Wrap(
        //   spacing: 10.0,
        //   runSpacing: 4.0,
        //   children: _selectedOptions.map((String option) {
        //     return Chip(
        //       backgroundColor: AppColors.scaffoldColor,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       label: BaseText(
        //         text: option,
        //         fontSize: 12,
        //         fontWeight: FontWeight.w500,
        //       ),
        //       onDeleted: () {
        //         setState(() {
        //           _selectedOptions.remove(option);
        //         });
        //       },
        //     );
        //   }).toList(),
        // ),
      ],
    );
  }

  Widget preferredSoftwareSkillsDropDownChipSet(
      BuildContext context, HealthcarePostState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomDropdwonWithTextField(
          isLabelPadding: true,
          isOptional: true,
          fieldController: otherPreferredSkillsController,
          labelText: StringConstant.preferredSoftwareSkills,
          hintText: StringConstant.preferredSoftwareSkills,
          showTextfield:
              state.requiredSoftwareSkillChip.toLowerCase().contains("other"),
          items: preferredSoftwareSkillList,
          value: (state.requiredSoftwareSkillChip.isEmpty)
              ? null
              : state.requiredSoftwareSkillChip,
          onChanged: (newValue) {
            if (newValue != null) {
              context.read<HealthcarePostBloc>().add(
                  HealthcarePostEvent.addPreferedSoftwareSkillchips(newValue));
            }
          },
          suffixIcon: CommonButton(
            height: getSize(27),
            width: getSize(59),
            borderRadius: getSize(10),
            buttonText: StringConstant.add,
            buttonFontSize: 10,
            onPressed: () {
              context
                  .read<HealthcarePostBloc>()
                  .add(HealthcarePostEvent.addPreferedSoftwareSkillchips(
                    otherPreferredSkillsController.text,
                    isOtherValue: true,
                  ));

              otherPreferredSkillsController.clear();
            },
          ),
        ),
        CustomChipSet(
          chipList: state.requiredSoftwareSkillChipList,
          onDelete: (value) {
            context.read<HealthcarePostBloc>().add(
                HealthcarePostEvent.removePreferedSoftwareSkillchips(value));
          },
        ),
      ],
    );
  }
}
