// ignore_for_file: must_be_immutable, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_chip_list.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_speciality_box.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addContractorSkillsForm')
class AddContractorSkillsForm extends StatelessWidget {
  bool isFromSplash = false;

  AddContractorSkillsForm({super.key, this.isFromSplash = false});

  // final List<String> requiredSpecialtiesList = [
  //   'Anesthesiology',
  //   'Behavioral Health',
  //   'Urology',
  //   'Perinatal',
  //   'NICU',
  //   'Other',
  // ];

  // final List<String> preferredSoftwareSkillList = [
  //   "Visual Studio code",
  //   "Android Studio",
  //   "Sublime Text",
  //   "Bluefish",
  //   "Notepad++",
  //   "OTHER",
  // ];

  TextEditingController otherSpecialitiesController = TextEditingController();
  TextEditingController otherRoleController = TextEditingController();
  TextEditingController otherPreferredSkillsController =
      TextEditingController();
  TextEditingController languageController = TextEditingController();
  bool isMultiLocation = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddContractorSkillFormBloc>()
        ..add(const AddContractorSkillFormEvent.getAllDropDownList()),
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
              title: StringConstant.completeProfile,
            ),
            body: BlocConsumer<AddContractorSkillFormBloc,
                AddContractorSkillFormState>(
              listener: (context, state) {
                state.authFailureOrSuccessOption.fold(
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
                          .push(const PageRouteInfo(EducationListScreen.name));
                    },
                  ),
                );
              },
              builder: (context, state) {
                return (state.isLoading)
                    ? CenterLoadingIndicator()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                        child: Form(
                          autovalidateMode: state.showErrorMessages
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Image.asset(
                                  PngImageConstants.healthcare_post_contractor,
                                ),
                                paddingBetweenFields(),
                                roleDropDown(context, state),
                                paddingBetweenFields(),
                                requiredSpecialityDropDownChipset(
                                    context, state),
                                preferredSoftwareSkillsDropDownChipSet(
                                    context, state),
                                paddingBetweenFields(),
                                languageDropDownChipSet(context, state),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getSize(50)),
                                  child: CommonButton(
                                    isSubmitting: state.isSubmitting,
                                    onPressed: () {
                                      context
                                          .read<AddContractorSkillFormBloc>()
                                          .add(const AddContractorSkillFormEvent
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

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget roleDropDown(BuildContext context, AddContractorSkillFormState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomDropdwonWithTextField(
          labelText: StringConstant.role,
          isLabelPadding: true,
          showTextfield: false,
          items: state.roleList.map((val) {
            return DropdownMenuItem<String>(
              value: val.name,
              child: BaseText(
                text: val.name ?? "",
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
          validator: (p0) => context
              .read<AddContractorSkillFormBloc>()
              .state
              .roleTypeChipList
              .value
              .fold(
                (f) => f.maybeMap(
                  empty: (value) => "Please add at least one role",
                  orElse: () => null,
                ),
                (_) => null,
              ),
          value: (state.roleTypeChip.isEmpty) ? null : state.roleTypeChip,
          onChanged: (value) {
            if (value != null) {
              context
                  .read<AddContractorSkillFormBloc>()
                  .add(AddContractorSkillFormEvent.addRoleTypeChips(value));
            }
          },
          hintText: StringConstant.selectRoles,
        ),
        CustomChipSet(
          chipList: (state.roleTypeChipList.getValue()).cast<String>(),
          spacing: 10,
          onDelete: (value) {
            context
                .read<AddContractorSkillFormBloc>()
                .add(AddContractorSkillFormEvent.removeRoleTypeChips(value));
          },
        ),

        /*CustomDropdwonWithTextField(
          isLabelPadding: true,
          fieldController: otherRoleController,
          labelText: StringConstant.role,
          hintText: StringConstant.role,
          showTextfield: state.roleTypeChip.toLowerCase() == "other",
          fieldHintText: StringConstant.selectRoles,
          items: state.roleList.map((val) {
            return DropdownMenuItem<String>(
              value: val.name,
              child: BaseText(
                text: val.name ?? "",
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
          value: (state.roleTypeChip.isEmpty) ? null : state.roleTypeChip,
          validator: (val) {
            if (val != null && val.toLowerCase() == "other") {
              return null;
            } else {
              return context
                  .read<AddContractorSkillFormBloc>()
                  .state
                  .roleTypeChipList
                  .value
                  .fold(
                    (f) => f.maybeMap(
                      empty: (value) =>
                          StringConstant.pleaseSelectAtLeastOneRole,
                      orElse: () => null,
                    ),
                    (_) => null,
                  );
            }
          },
          onChanged: (newValue) {
            if (newValue != null) {
              context
                  .read<AddContractorSkillFormBloc>()
                  .add(AddContractorSkillFormEvent.addRoleTypeChips(newValue));
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
                  .read<AddContractorSkillFormBloc>()
                  .add(AddContractorSkillFormEvent.addRoleTypeChips(
                    otherRoleController.text,
                    isOtherValue: true,
                  ));

              otherRoleController.clear();
            },
          ),
        ),
        if (state.roleTypeChip.toLowerCase() == "other" &&
            state.showRoleTypeError)
          commonErrorText(StringConstant.pleaseAddOtherTypeOfRole),
        CustomChipSet(
          chipList: (state.roleTypeChipList.getValue()).cast<String>(),
          onDelete: (value) {
            context
                .read<AddContractorSkillFormBloc>()
                .add(AddContractorSkillFormEvent.removeRoleTypeChips(value));
          },
        ),
    */
      ],
    );
  }

  Widget preferredSoftwareSkillsDropDownChipSet(
      BuildContext context, AddContractorSkillFormState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomDropdwonWithTextField(
          isLabelPadding: true,
          fieldController: otherPreferredSkillsController,
          labelText: StringConstant.softwareSkillSet,
          hintText: StringConstant.softwareSkillSet,
          showTextfield:
              state.requiredSoftwareSkillChip.toLowerCase() == "other",
          fieldHintText: StringConstant.addYourSoftwareSkills,
          items: state.softwareList.map((val) {
            return DropdownMenuItem<String>(
              value: val.name,
              child: BaseText(
                text: val.name ?? "",
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
          value: (state.requiredSoftwareSkillChip.isEmpty)
              ? null
              : state.requiredSoftwareSkillChip,
          validator: (val) {
            if (val != null && val.toLowerCase() == "other") {
              return null;
            } else {
              return context
                  .read<AddContractorSkillFormBloc>()
                  .state
                  .requiredSoftwareSkillChipList
                  .value
                  .fold(
                    (f) => f.maybeMap(
                      empty: (value) =>
                          StringConstant.pleaseSelectAtLeastOneSkillSet,
                      orElse: () => null,
                    ),
                    (_) => null,
                  );
            }
          },
          onChanged: (newValue) {
            if (newValue != null) {
              context.read<AddContractorSkillFormBloc>().add(
                  AddContractorSkillFormEvent.addPreferedSoftwareSkillchips(
                      newValue));
            }
          },
          suffixIcon: CommonButton(
            height: getSize(27),
            width: getSize(59),
            borderRadius: getSize(10),
            buttonText: StringConstant.add,
            buttonFontSize: 10,
            onPressed: () {
              context.read<AddContractorSkillFormBloc>().add(
                      AddContractorSkillFormEvent.addPreferedSoftwareSkillchips(
                    otherPreferredSkillsController.text,
                    isOtherValue: true,
                  ));

              otherPreferredSkillsController.clear();
            },
          ),
        ),
        if (state.requiredSoftwareSkillChip.toLowerCase() == "other" &&
            state.showSoftwareSkillError)
          commonErrorText(StringConstant.pleaseAddOtherTypeOfSoftwareSkill),
        CustomChipSet(
          chipList:
              (state.requiredSoftwareSkillChipList.getValue()).cast<String>(),
          onDelete: (value) {
            context.read<AddContractorSkillFormBloc>().add(
                AddContractorSkillFormEvent.removePreferedSoftwareSkillchips(
                    value));
          },
        ),
      ],
    );
  }

  Widget requiredSpecialityDropDownChipset(
      BuildContext context, AddContractorSkillFormState state) {
    print("SPECIALITY LIST--> ${state.specialityList}");
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomDropdwonWithTextField(
          isLabelPadding: true,
          fieldController: otherSpecialitiesController,
          labelText: StringConstant.specialties,
          hintText: StringConstant.specialties,
          showTextfield: state.requiredSpecialityChip.toLowerCase() == "other",
          fieldHintText: StringConstant.addYourSpecializations,
          items: state.specialityList.map((val) {
            return DropdownMenuItem<String>(
              value: val.name,
              child: BaseText(
                text: val.name ?? "",
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
          value: (state.requiredSpecialityChip.isEmpty)
              ? null
              : state.requiredSpecialityChip,
          validator: (val) {
            if (val != null && val.toLowerCase() == "other") {
              return null;
            } else {
              return context
                  .read<AddContractorSkillFormBloc>()
                  .state
                  .requiredSpecialityChipList
                  .value
                  .fold(
                    (f) => f.maybeMap(
                      empty: (value) =>
                          StringConstant.pleaseSelectAtLeastOneSpeciality,
                      orElse: () => null,
                    ),
                    (_) => null,
                  );
            }
          },
          onChanged: (newValue) {
            if (newValue != null) {
              context.read<AddContractorSkillFormBloc>().add(
                  AddContractorSkillFormEvent.addRequiredSpecialitichips(
                      newValue));
            }
          },
          suffixIcon: CommonButton(
            height: getSize(27),
            width: getSize(59),
            borderRadius: getSize(10),
            buttonText: StringConstant.add,
            buttonFontSize: 10,
            onPressed: () {
              context.read<AddContractorSkillFormBloc>().add(
                    AddContractorSkillFormEvent.addRequiredSpecialitichips(
                      otherSpecialitiesController.text,
                      isOtherValue: true,
                    ),
                  );
              otherSpecialitiesController.clear();
            },
          ),
        ),
        if (state.requiredSpecialityChip.toLowerCase() == "other" &&
            state.showSpecialityError)
          commonErrorText(StringConstant.pleaseAddOtherTypeOfSpeciality),
        specialityBox(state),
      ],
    );
  }

  Widget languageDropDownChipSet(
      BuildContext context, AddContractorSkillFormState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomDropdwonWithTextField(
          isLabelPadding: true,
          fieldController: languageController,
          labelText: StringConstant.languagesKnown,
          hintText: StringConstant.languagesKnown,
          showTextfield: state.languageChip.toLowerCase() == "other",
          fieldHintText: StringConstant.addYourLanguage,
          items: state.languageList.map((val) {
            return DropdownMenuItem<String>(
              value: val.name,
              child: BaseText(
                text: val.name ?? "",
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
          // items: const [
          //   "English",
          //   "Hindi",
          //   "Gujarati",
          //   "Bengali",
          //   "Marathi",
          //   "Punjabi",
          //   "Tamil",
          //   "Kannad",
          //   "Other",
          // ],
          value: (state.languageChip.isEmpty) ? null : state.languageChip,
          validator: (val) {
            if (val != null && val.toLowerCase() == "other") {
              return null;
            } else {
              return context
                  .read<AddContractorSkillFormBloc>()
                  .state
                  .languageChipList
                  .value
                  .fold(
                    (f) => f.maybeMap(
                      empty: (value) =>
                          StringConstant.pleaseSelectAtLeastOneLanguage,
                      orElse: () => null,
                    ),
                    (_) => null,
                  );
            }
          },
          onChanged: (newValue) {
            print("valllll-> $newValue");
            if (newValue != null) {
              context
                  .read<AddContractorSkillFormBloc>()
                  .add(AddContractorSkillFormEvent.addLanguageChips(newValue));
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
                  .read<AddContractorSkillFormBloc>()
                  .add(AddContractorSkillFormEvent.addLanguageChips(
                    languageController.text,
                    isOtherValue: true,
                  ));
              languageController.clear();
            },
          ),
        ),
        if (state.languageChip.toLowerCase() == "other" &&
            state.showLanguageError)
          commonErrorText(StringConstant.pleaseAddOtherTypeOfLanguage),
        CustomChipSet(
          chipList: (state.languageChipList.getValue()).cast<String>(),
          onDelete: (value) {
            context
                .read<AddContractorSkillFormBloc>()
                .add(AddContractorSkillFormEvent.removeLanguageChips(value));
          },
        ),
      ],
    );
  }

  Widget specialityBox(AddContractorSkillFormState state) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          top: getSize(15),
        ),
        itemCount: state.requiredSpecialityChipList.getValue().length,
        itemBuilder: (context, index) {
          var selectedObj = state.requiredSpecialityChipList.getValue()[index];
          print("PRINT SPECC--> ${selectedObj}");

          return CustomeSpecialityBox(
            selectedValue: selectedObj.name ?? "",
            hintText: StringConstant.addYourExperience,
            onDelete: () {
              context.read<AddContractorSkillFormBloc>().add(
                    AddContractorSkillFormEvent.removeRequiredSpecialitichips(
                        index),
                  );
            },
            experienceOnChanged: (value) {
              if (value != null) {
                ///
                context.read<AddContractorSkillFormBloc>().add(
                    AddContractorSkillFormEvent.addSpecialityExperienceList(
                        value, index));
              }
            },
            showError: ((selectedObj.specialityExperience == null ||
                        selectedObj.specialityExperience == "") &&
                    state.showSpeExperienceError)
                ? true
                : false,
            errorText: StringConstant.experienceMustBeSelected,
            value: (selectedObj.specialityExperience != null &&
                    selectedObj.specialityExperience!.isNotEmpty)
                ? selectedObj.specialityExperience
                : null,
            items: state.experienceList.map((val) {
              return DropdownMenuItem<String>(
                value: val.name,
                child: BaseText(
                  text: val.name ?? "",
                  fontSize: 14,
                  textColor: AppColors.black,
                ),
              );
            }).toList(),
          );
        });
  }
}
