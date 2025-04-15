// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_chip_display.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_item.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_selectable_dropdown.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addContractorSkillsForm')
class AddContractorSkillsForm extends StatelessWidget {
  bool isFromSplash = false;
  bool isUpdate;

  AddContractorSkillsForm(
      {super.key, this.isFromSplash = false, this.isUpdate = false});

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
        ..add(
            AddContractorSkillFormEvent.getAllDropDownList(isUpdate: isUpdate)),
      child:
          BlocConsumer<AddContractorSkillFormBloc, AddContractorSkillFormState>(
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
                    .push(PageRouteInfo(AddExperienceDetailScreen.name,
                        args: AddExperienceDetailScreenArgs(
                          isUpdate: isUpdate,
                          isRoleForceUpdate: state.isRoleListUpdated,
                          isSpecialityForceUpdate:
                              state.isSpecialityListUpdated,
                        )))
                    .then((value) {
                  if (value == true) {
                    Navigator.pop(context, true);
                  }
                });
              },
            ),
          );
        },
        builder: (context, state) {
          return PopScope(
            canPop: (isUpdate &&
                !state.isRoleListUpdated &&
                !state.isSpecialityListUpdated),
            child: GestureDetector(
              onTap: () {
                AppFocus.unfocus(context);
              },
              child: Scaffold(
                appBar: CommonAppBar(
                  isShowBackBtn: !isFromSplash,
                  onBackPressed: () {
                    if (isUpdate && state.isRoleListUpdated) {
                      AppDialog.showInfo(
                          context, StringConstant.forceRoleUpdateDesc);
                    } else if (isUpdate && state.isSpecialityListUpdated) {
                      AppDialog.showInfo(
                          context, StringConstant.forceSpecialityUpdateDesc);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  title: StringConstant.completeProfile,
                ),
                body: (state.isLoading)
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
                                (isUpdate)
                                    ? Image.asset(
                                        PngImageConstants
                                            .update_post_contractor,
                                      )
                                    : Image.asset(
                                        PngImageConstants
                                            .healthcare_post_contractor,
                                      ),
                                paddingBetweenFields(),
                                roleDropDown(context, state),
                                paddingBetweenFields(),
                                specialityDropDown(context, state),
                                paddingBetweenFields(),
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
                                    buttonText: (isUpdate)
                                        ? StringConstant.update
                                        : StringConstant.txtContinue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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

  Widget roleDropDown(BuildContext context, AddContractorSkillFormState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiSelectDialogField(
          items: state.roleList
              .map((item) =>
                  MultiSelectItem<String>(item.name ?? "", item.name ?? ""))
              .toList(),
          initialValue: state.roleTypeChipList.getValue(),
          title: StringConstant.role,
          labelText: StringConstant.role,
          selectedColor: AppColors.black,
          isShowOtherValue: false,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          chipDisplay: MultiSelectChipDisplay(
            chipColor: AppColors.transparent,
            onDelete: (value) {
              context.read<AddContractorSkillFormBloc>().add(
                  AddContractorSkillFormEvent.removeRoleTypeChips(
                      value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            StringConstant.selectRoles,
            style: TextStyle(
                fontSize: 14, color: AppColors.black.withValues(alpha: 0.50)),
          ),
          onConfirm: (selectedList, otherValues) {
            context
                .read<AddContractorSkillFormBloc>()
                .add(AddContractorSkillFormEvent.confirmRoleList(
                  List<String>.from(selectedList),
                  List<String>.from(otherValues),
                ));
          },
        ),
        if (state.showErrorMessages &&
            state.roleTypeChipList.getValue().isEmpty)
          commonErrorText(StringConstant.pleaseSelectAtLeastOneRole)
      ],
    );
  }

  Widget specialityDropDown(
      BuildContext context, AddContractorSkillFormState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiSelectDialogField(
          items: state.specialityList
              .map((item) =>
                  MultiSelectItem<String>(item.name ?? "", item.name ?? ""))
              .toList(),
          title: StringConstant.specialties,
          labelText: StringConstant.specialties,
          initialValue: state.requiredSpecialityChipList.getValue(),
          otherInitialValue: state.specialityOther,
          selectedColor: AppColors.black,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          chipDisplay: MultiSelectChipDisplay(
            chipColor: AppColors.transparent,
            onDelete: (value) {
              context.read<AddContractorSkillFormBloc>().add(
                  AddContractorSkillFormEvent.removeRequiredSpecialitichips(
                      value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            StringConstant.specialties,
            style: TextStyle(
                fontSize: 14, color: AppColors.black.withValues(alpha: 0.50)),
          ),
          onConfirm: (selectedList, otherValues) {
            context
                .read<AddContractorSkillFormBloc>()
                .add(AddContractorSkillFormEvent.confirmSpecialityList(
                  List<String>.from(selectedList),
                  List<String>.from(otherValues),
                ));
          },
        ),
        if (state.showErrorMessages &&
            state.requiredSpecialityChipList.getValue().isEmpty &&
            state.specialityOther.isEmpty)
          commonErrorText(StringConstant.pleaseSelectAtLeastOneSpeciality)
      ],
    );
  }

  Widget preferredSoftwareSkillsDropDownChipSet(
      BuildContext context, AddContractorSkillFormState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiSelectDialogField(
          initialValue: state.requiredSoftwareSkillChipList.getValue(),
          otherInitialValue: state.softwareSkillOther,
          items: state.softwareList
              .map((item) =>
                  MultiSelectItem<String>(item.name ?? "", item.name ?? ""))
              .toList(),
          title: StringConstant.softwareSkillSet,
          labelText: StringConstant.softwareSkillSet,
          selectedColor: AppColors.black,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          chipDisplay: MultiSelectChipDisplay(
            chipColor: AppColors.transparent,
            onDelete: (value) {
              context.read<AddContractorSkillFormBloc>().add(
                  AddContractorSkillFormEvent.removePreferedSoftwareSkillchips(
                      value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            StringConstant.softwareSkillSet,
            style: TextStyle(
                fontSize: 14, color: AppColors.black.withValues(alpha: 0.50)),
          ),
          onConfirm: (selectedList, otherValues) {
            context
                .read<AddContractorSkillFormBloc>()
                .add(AddContractorSkillFormEvent.confirmSoftwareSkill(
                  List<String>.from(selectedList),
                  List<String>.from(otherValues),
                ));
          },
        ),
        if (state.showErrorMessages &&
            state.requiredSoftwareSkillChipList.getValue().isEmpty &&
            state.softwareSkillOther.isEmpty)
          commonErrorText(StringConstant.pleaseSelectAtLeastOneSkillSet)
      ],
    );
  }

  Widget languageDropDownChipSet(
      BuildContext context, AddContractorSkillFormState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiSelectDialogField(
          items: state.languageList
              .map((item) =>
                  MultiSelectItem<String>(item.name ?? "", item.name ?? ""))
              .toList(),
          title: StringConstant.languagesKnown,
          labelText: StringConstant.languagesKnown,
          selectedColor: AppColors.black,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          chipDisplay: MultiSelectChipDisplay(
            chipColor: AppColors.transparent,
            onDelete: (value) {
              context.read<AddContractorSkillFormBloc>().add(
                  AddContractorSkillFormEvent.removeLanguageChips(
                      value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            StringConstant.languagesKnown,
            style: TextStyle(
                fontSize: 14, color: AppColors.black.withValues(alpha: 0.50)),
          ),
          initialValue: state.languageChipList.getValue(),
          otherInitialValue: state.languageOther,
          onConfirm: (selectedList, otherValues) {
            context
                .read<AddContractorSkillFormBloc>()
                .add(AddContractorSkillFormEvent.confirmLanguageList(
                  List<String>.from(selectedList),
                  List<String>.from(otherValues),
                ));
          },
        ),
        if (state.showErrorMessages &&
            state.languageChipList.getValue().isEmpty &&
            state.languageOther.isEmpty)
          commonErrorText(StringConstant.pleaseSelectAtLeastOneLanguage)
      ],
    );
  }
}
