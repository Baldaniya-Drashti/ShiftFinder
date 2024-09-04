// // ignore_for_file: must_be_immutable

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart';
// import 'package:shift/domain/core/math_utils.dart';
// import 'package:shift/domain/core/png_image_constants.dart';
// import 'package:shift/domain/core/string_constant.dart';
// import 'package:shift/domain/core/svg_image_constants.dart';
// import 'package:shift/injection.dart';
// import 'package:shift/presentation/common/utils/app_focus.dart';
// import 'package:shift/presentation/common/widgets/base_text.dart';
// import 'package:shift/presentation/core/style/app_colors.dart';
// import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
// import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
// import 'package:shift/presentation/core/widgets/inputs/custom_chip_list.dart';
// import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
// import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
// import 'package:shift/presentation/main/widgets/home_app_bar.dart';

// @RoutePage(name: 'healthCarePostForm')
// class HealthCarePostForm extends StatelessWidget {
//   HealthCarePostForm({super.key});

//   final List<String> requiredSpecialtiesList = [
//     'Anesthesiology',
//     'Behavioral Health',
//     'Urology',
//     'Perinatal',
//     'NICU',
//     'Other',
//   ];

//   final List<String> preferredSoftwareSkillList = [
//     "Visual Studio code",
//     "Android Studio",
//     "Sublime Text",
//     "Bluefish",
//     "Notepad++",
//     "OTHER",
//   ];

//   TextEditingController otherSpecialitiesController = TextEditingController();
//   TextEditingController otherPreferredSkillsController =
//       TextEditingController();
//   bool isMultiLocation = true;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<HealthcarePostBloc>(),
//       child: GestureDetector(
//         onTap: () {
//           AppFocus.unfocus(context);
//         },
//         child: Scaffold(
//             appBar: CommonAppBar(
//               onBackPressed: () {
//                 context.router.maybePop();
//               },
//               title: StringConstant.healthcare,
//             ),
//             body: BlocConsumer<HealthcarePostBloc, HealthcarePostState>(
//               listener: (context, state) {},
//               builder: (context, state) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(horizontal: getSize(20)),
//                   child: Form(
//                     autovalidateMode: state.showErrorMessages
//                         ? AutovalidateMode.always
//                         : AutovalidateMode.disabled,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             PngImageConstants.healthcare_post_employer,
//                           ),
//                           paddingBetweenFields(),
//                           roleDropDown(context, state),
//                           paddingBetweenFields(),
//                           requiredSpecialityDropDownChipset(context, state),
//                           paddingBetweenFields(),
//                           preferredSoftwareSkillsDropDownChipSet(
//                               context, state),
//                           paddingBetweenFields(),
//                           languageRequirementsDropDown(context, state),
//                           paddingBetweenFields(),
//                           (isMultiLocation)
//                               ? locationDropDown(context, state)
//                               : locationTextField(context, state),
//                           paddingBetweenFields(),
//                           rateHourDropDown(context, state),
//                           Padding(
//                             padding:
//                                 EdgeInsets.symmetric(vertical: getSize(50)),
//                             child: CommonButton(
//                               onPressed: () {
//                                 context.read<HealthcarePostBloc>().add(
//                                     const HealthcarePostEvent
//                                         .continueBtnPressed());
//                               },
//                               buttonText: StringConstant.txtContinue,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             )),
//       ),
//     );
//   }

//   Widget roleDropDown(BuildContext context, HealthcarePostState state) {
//     return CustomDropdwonWithTextField(
//       labelText: StringConstant.role,
//       isLabelPadding: true,
//       showTextfield: false,
//       items: const [
//         "Registered Nurse",
//         "Registered Practical Nurse",
//         "PSW (Personal Support Worker)",
//         "Nurse Practitioner",
//         "Anaesthesiology Assistant",
//       ].map((val) {
//         return DropdownMenuItem(
//           value: val,
//           child: BaseText(
//             text: val,
//             fontSize: 14,
//             textColor: AppColors.black,
//           ),
//         );
//       }).toList(),
//       validator: (p0) =>
//           context.read<HealthcarePostBloc>().state.roleType.value.fold(
//                 (f) => f.maybeMap(
//                   empty: (value) => StringConstant.pleaseSelectRoleType,
//                   orElse: () => null,
//                 ),
//                 (_) => null,
//               ),
//       onChanged: (value) {
//         if (value != null) {
//           context.read<HealthcarePostBloc>().add(
//                 HealthcarePostEvent.roleTypeChanged(value),
//               );
//         }
//       },
//       hintText: StringConstant.selectRoles,
//     );
//   }

//   Widget languageRequirementsDropDown(
//       BuildContext context, HealthcarePostState state) {
//     return CustomDropdwonWithTextField(
//       labelText: StringConstant.languageRequirements,
//       isLabelPadding: true,
//       showTextfield: false,
//       items: const [
//         "English",
//         "Hindi",
//         "Gujarati",
//         "Bengali",
//         "Marathi",
//         "Punjabi",
//         "Tamil",
//         "Kannad",
//         "Other",
//       ].map((val) {
//         return DropdownMenuItem(
//           value: val,
//           child: BaseText(
//             text: val,
//             fontSize: 14,
//             textColor: AppColors.black,
//           ),
//         );
//       }).toList(),
//       validator: (p0) => context
//           .read<HealthcarePostBloc>()
//           .state
//           .selectedLanguage
//           .value
//           .fold(
//             (f) => f.maybeMap(
//               empty: (value) => StringConstant.pleaseSelectLanguageRequirement,
//               orElse: () => null,
//             ),
//             (_) => null,
//           ),
//       onChanged: (value) {
//         if (value != null) {
//           context.read<HealthcarePostBloc>().add(
//                 HealthcarePostEvent.selectedLanguageChanged(value),
//               );
//         }
//       },
//       hintText: StringConstant.languageRequirements,
//     );
//   }

//   Widget rateHourDropDown(BuildContext context, HealthcarePostState state) {
//     return CustomTextField(
//       labelText: StringConstant.rateHour,
//       isLabelPadding: true,
//       isPrefixValueShow: true,
//       hintText: "\$ ${StringConstant.rateHour}",
//       errorMaxLines: 2,
//       onChanged: (value) {
//         context
//             .read<HealthcarePostBloc>()
//             .add(HealthcarePostEvent.rateHourChanged(value));
//       },
//       validator: (p0, p1) =>
//           context.read<HealthcarePostBloc>().state.rateHour.value.fold(
//                 (f) => f.maybeMap(
//                   empty: (value) => StringConstant.pleaseEnterRateHour,
//                   orElse: () => null,
//                 ),
//                 (_) => null,
//               ),
//     );
//   }

//   Widget locationDropDown(BuildContext context, HealthcarePostState state) {
//     return CustomDropdwonWithTextField(
//       labelText: StringConstant.location,
//       isLabelPadding: true,
//       showTextfield: false,
//       isOptional: true,
//       optionalWidget: GestureDetector(
//         onTap: () {
//           AppDialog.showInfo(
//             context,
//             StringConstant.missingLocationInfoDesc,
//             insetPadding: EdgeInsets.symmetric(
//               horizontal: getSize(30),
//             ),
//           );
//         },
//         child: SvgPicture.asset(
//           SvgImageConstant.infoCircle,
//         ),
//       ),
//       items: const [
//         "1 Royal Ln. Mesa, New Jersey 45463",
//         "264 Royal Ln. Mesa,45463",
//         "2864 New Jersey 45463",
//         "64 Royal Ln. Mesa, New Jersey 45463",
//         "9 New Jersey 45463",
//         "62 Royal La. CASA, Jersey 45463",
//         "74 Royal Mesa, New Jersey 45463",
//       ].map((val) {
//         return DropdownMenuItem(
//           value: val,
//           child: BaseText(
//             text: val,
//             fontSize: 14,
//             textColor: AppColors.black,
//           ),
//         );
//       }).toList(),
//       validator: (
//         p0,
//       ) =>
//           context.read<HealthcarePostBloc>().state.location.value.fold(
//                 (f) => f.maybeMap(
//                   empty: (value) => StringConstant.pleaseEnterLocation,
//                   orElse: () => null,
//                 ),
//                 (_) => null,
//               ),
//       onChanged: (value) {
//         if (value != null) {
//           context.read<HealthcarePostBloc>().add(
//                 HealthcarePostEvent.locationChanged(value),
//               );
//         }
//       },
//       hintText: StringConstant.location,
//       childDroDwonHintText: StringConstant.selectUnitIfAny,
//       showDropDown: state.location.isValid(),
//       childDropDownItems: const [
//         "X-ray",
//       ],
//       childDropDownOnChanged: (value) {
//         if (value != null) {
//           context.read<HealthcarePostBloc>().add(
//                 HealthcarePostEvent.locationUnitSelectionChanged(value),
//               );
//         }
//       },
//     );
//   }

//   Widget locationTextField(
//     BuildContext context,
//     HealthcarePostState state,
//   ) {
//     return CustomTextField(
//       labelText: StringConstant.location,
//       isLabelPadding: true,
//       isOptional: true,
//       readOnly: true,
//       optionalWidget: GestureDetector(
//         onTap: () {
//           AppDialog.showInfo(
//             context,
//             StringConstant.missingLocationInfoDesc,
//             insetPadding: EdgeInsets.symmetric(
//               horizontal: getSize(30),
//             ),
//           );
//         },
//         child: SvgPicture.asset(
//           SvgImageConstant.infoCircle,
//         ),
//       ),
//       hintText: StringConstant.location,
//       textCapitalization: TextCapitalization.words,
//       errorMaxLines: 2,
//       onChanged: (value) {
//         context
//             .read<HealthcarePostBloc>()
//             .add(HealthcarePostEvent.locationChanged(value));
//       },
//       validator: (p0, p1) =>
//           context.read<HealthcarePostBloc>().state.location.value.fold(
//                 (f) => f.maybeMap(
//                   empty: (value) => StringConstant.pleaseEnterLocation,
//                   orElse: () => null,
//                 ),
//                 (_) => null,
//               ),
//     );
//   }

//   Widget paddingBetweenFields({double? height}) {
//     return SizedBox(
//       height: getSize(height ?? 15),
//     );
//   }

//   Widget requiredSpecialityDropDownChipset(
//       BuildContext context, HealthcarePostState state) {
//     // final List<String> _selectedOptions = [];
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         CustomDropdwonWithTextField(
//           isLabelPadding: true,
//           isOptional: true,
//           fieldController: otherSpecialitiesController,
//           labelText: StringConstant.specialties,
//           hintText: StringConstant.requiredSpecialties,
//           showTextfield: state.requiredSpecialityChip.toLowerCase() == "other",
//           fieldHintText: StringConstant.addYourSpecializations,
//           items: requiredSpecialtiesList.map((val) {
//             return DropdownMenuItem(
//               value: val,
//               child: BaseText(
//                 text: val,
//                 fontSize: 14,
//                 textColor: AppColors.black,
//               ),
//             );
//           }).toList(),
//           value: (state.requiredSpecialityChip.isEmpty)
//               ? null
//               : state.requiredSpecialityChip,
//           onChanged: (newValue) {
//             if (newValue != null) {
//               context.read<HealthcarePostBloc>().add(
//                   HealthcarePostEvent.addRequiredSpecialitichips(newValue));
//             }
//           },
//           suffixIcon: CommonButton(
//             height: getSize(27),
//             width: getSize(59),
//             borderRadius: getSize(10),
//             buttonText: StringConstant.add,
//             buttonFontSize: 10,
//             onPressed: () {
//               context.read<HealthcarePostBloc>().add(
//                     HealthcarePostEvent.addRequiredSpecialitichips(
//                       otherSpecialitiesController.text,
//                       isOtherValue: true,
//                     ),
//                   );
//               otherSpecialitiesController.clear();
//             },
//           ),
//         ),

//         CustomChipSet(
//           chipList: state.requiredSpecialityChipList,
//           onDelete: (value) {
//             context
//                 .read<HealthcarePostBloc>()
//                 .add(HealthcarePostEvent.removeRequiredSpecialitichips(value));
//           },
//         ),
//         // Wrap(
//         //   spacing: 10.0,
//         //   runSpacing: 4.0,
//         //   children: _selectedOptions.map((String option) {
//         //     return Chip(
//         //       backgroundColor: AppColors.scaffoldColor,
//         //       shape: RoundedRectangleBorder(
//         //         borderRadius: BorderRadius.circular(10),
//         //       ),
//         //       label: BaseText(
//         //         text: option,
//         //         fontSize: 12,
//         //         fontWeight: FontWeight.w500,
//         //       ),
//         //       onDeleted: () {
//         //         setState(() {
//         //           _selectedOptions.remove(option);
//         //         });
//         //       },
//         //     );
//         //   }).toList(),
//         // ),
//       ],
//     );
//   }

//   Widget preferredSoftwareSkillsDropDownChipSet(
//       BuildContext context, HealthcarePostState state) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         CustomDropdwonWithTextField(
//           isLabelPadding: true,
//           isOptional: true,
//           fieldController: otherPreferredSkillsController,
//           labelText: StringConstant.softwareSkills,
//           hintText: StringConstant.preferredSoftwareSkills,
//           showTextfield:
//               state.requiredSoftwareSkillChip.toLowerCase() == "other",
//           fieldHintText: StringConstant.addYourSoftwareSkills,
//           items: preferredSoftwareSkillList.map((val) {
//             return DropdownMenuItem(
//               value: val,
//               child: BaseText(
//                 text: val,
//                 fontSize: 14,
//                 textColor: AppColors.black,
//               ),
//             );
//           }).toList(),
//           value: (state.requiredSoftwareSkillChip.isEmpty)
//               ? null
//               : state.requiredSoftwareSkillChip,
//           onChanged: (newValue) {
//             if (newValue != null) {
//               context.read<HealthcarePostBloc>().add(
//                   HealthcarePostEvent.addPreferedSoftwareSkillchips(newValue));
//             }
//           },
//           suffixIcon: CommonButton(
//             height: getSize(27),
//             width: getSize(59),
//             borderRadius: getSize(10),
//             buttonText: StringConstant.add,
//             buttonFontSize: 10,
//             onPressed: () {
//               context
//                   .read<HealthcarePostBloc>()
//                   .add(HealthcarePostEvent.addPreferedSoftwareSkillchips(
//                     otherPreferredSkillsController.text,
//                     isOtherValue: true,
//                   ));

//               otherPreferredSkillsController.clear();
//             },
//           ),
//         ),
//         CustomChipSet(
//           chipList: state.requiredSoftwareSkillChipList,
//           onDelete: (value) {
//             context.read<HealthcarePostBloc>().add(
//                 HealthcarePostEvent.removePreferedSoftwareSkillchips(value));
//           },
//         ),
//       ],
//     );
//   }
// }

// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_chip_list.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_chip_display.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_item.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_selectable_dropdown.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'healthCarePostForm')
class HealthCarePostForm extends StatelessWidget {
  int? postId;
  bool isFromSplash = false;

  HealthCarePostForm({super.key, this.postId, this.isFromSplash = false});

  TextEditingController otherSpecialitiesController = TextEditingController();
  TextEditingController otherRoleController = TextEditingController();
  TextEditingController otherPreferredSkillsController =
      TextEditingController();
  TextEditingController languageController = TextEditingController();
  bool isMultiLocation = true;

  @override
  Widget build(BuildContext context) {
    print("Post id--> $postId");
    return BlocProvider(
      create: (context) => getIt<HealthcarePostBloc>()
        ..add(HealthcarePostEvent.getAllDropDownList(postId ?? -1)),
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
              title: StringConstant.healthcare,
            ),
            body: BlocConsumer<HealthcarePostBloc, HealthcarePostState>(
              listener: (context, state) {
                /* state.authFailureOrSuccessOption.fold(
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
                      context.router.push(PageRouteInfo(
                        HealthcarePostShift.name,
                        args: HealthcarePostShiftArgs(postId: r.id ?? -1),
                      ));
                    },
                  ),
                );*/
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
                                  PngImageConstants.healthcare_post_employer,
                                ),
                                paddingBetweenFields(),
                                roleDropDown(context, state),
                                paddingBetweenFields(),
                                requiredSpecialityDropDownChipset(
                                    context, state),
                                paddingBetweenFields(),
                                preferredSoftwareSkillsDropDownChipSet(
                                    context, state),
                                paddingBetweenFields(),
                                languageDropDownChipSet(context, state),
                                paddingBetweenFields(),
                                locationDropDown(context, state),
                                paddingBetweenFields(),
                                rateHourDropDown(context, state),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getSize(50)),
                                  child: CommonButton(
                                    isSubmitting: state.isSubmitting,
                                    onPressed: () {
                                      context.read<HealthcarePostBloc>().add(
                                          HealthcarePostEvent
                                              .continueBtnPressed(context));
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

  Widget roleDropDown(BuildContext context, HealthcarePostState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.role,
      isLabelPadding: true,
      showTextfield: false,
      value: (state.roleType.getValue()!.isNotEmpty)
          ? state.roleType.getValue()
          : null,
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
      validator: (p0) =>
          context.read<HealthcarePostBloc>().state.roleType.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectRoleType,
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
      hintText: StringConstant.selectRoles,
    );
  }

  Widget preferredSoftwareSkillsDropDownChipSet(
      BuildContext context, HealthcarePostState state) {
    print(
        "state.requiredSoftwareSkillChipList---> ${state.requiredSoftwareSkillChipList}");
    /*return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomDropdwonWithTextField(
          isLabelPadding: true,
          isOptional: true,
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
          // validator: (val) {
          //   if (val != null && val.toLowerCase() == "other") {
          //     return null;
          //   } else {
          //     return context
          //         .read<HealthcarePostBloc>()
          //         .state
          //         .requiredSoftwareSkillChipList
          //         .value
          //         .fold(
          //           (f) => f.maybeMap(
          //             empty: (value) =>
          //                 StringConstant.pleaseSelectAtLeastOneSkillSet,
          //             orElse: () => null,
          //           ),
          //           (_) => null,
          //         );
          //   }
          // },
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
              print("Other skill--> ${otherPreferredSkillsController.text}");
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
        if (state.requiredSoftwareSkillChip.toLowerCase() == "other" &&
            state.showSoftwareSkillError)
          commonErrorText(StringConstant.pleaseAddOtherTypeOfSoftwareSkill),
        CustomChipSet(
          chipList:
              (state.requiredSoftwareSkillChipList.getValue()).cast<String>(),
          onDelete: (value) {
            context.read<HealthcarePostBloc>().add(
                HealthcarePostEvent.removePreferedSoftwareSkillchips(value));
          },
        ),
      ],
    );*/
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiSelectDialogField(
          isOptional: true,
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
              print("On delete called!");
              context.read<HealthcarePostBloc>().add(
                  HealthcarePostEvent.removePreferedSoftwareSkillchips(
                      value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            StringConstant.softwareSkillSet,
            style: TextStyle(
                fontSize: 14, color: AppColors.black.withOpacity(0.50)),
          ),
          onConfirm: (selectedList, otherValues) {
            context
                .read<HealthcarePostBloc>()
                .add(HealthcarePostEvent.confirmSoftwareSkill(
                  List<String>.from(selectedList),
                  List<String>.from(otherValues),
                ));
          },
        ),
        /*if (state.showErrorMessages &&
            state.requiredSoftwareSkillChipList.getValue().isEmpty &&
            state.softwareSkillOther.isEmpty)
          commonErrorText(StringConstant.pleaseSelectAtLeastOneSkillSet)*/
      ],
    );
  }

  Widget requiredSpecialityDropDownChipset(
      BuildContext context, HealthcarePostState state) {
    /*return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomDropdwonWithTextField(
          isLabelPadding: true,
          isOptional: true,
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
          // validator: (val) {
          //   if (val != null && val.toLowerCase() == "other") {
          //     return null;
          //   } else {
          //     return context
          //         .read<HealthcarePostBloc>()
          //         .state
          //         .requiredSpecialityChipList
          //         .value
          //         .fold(
          //           (f) => f.maybeMap(
          //             empty: (value) =>
          //                 StringConstant.pleaseSelectAtLeastOneSpeciality,
          //             orElse: () => null,
          //           ),
          //           (_) => null,
          //         );
          //   }
          // },
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
              context
                  .read<HealthcarePostBloc>()
                  .add(HealthcarePostEvent.addRequiredSpecialitichips(
                    otherSpecialitiesController.text,
                    isOtherValue: true,
                  ));

              otherSpecialitiesController.clear();
            },
          ),
        ),
        if (state.requiredSpecialityChip.toLowerCase() == "other" &&
            state.showSpecialityError)
          commonErrorText(StringConstant.pleaseAddOtherTypeOfSpeciality),
        CustomChipSet(
          chipList:
              (state.requiredSpecialityChipList.getValue()).cast<String>(),
          onDelete: (value) {
            context
                .read<HealthcarePostBloc>()
                .add(HealthcarePostEvent.removeRequiredSpecialitichips(value));
          },
        ),
      ],
    );*/
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiSelectDialogField(
          isOptional: true,
          items: state.specialityList
              .map((item) =>
                  MultiSelectItem<String>(item.name ?? "", item.name ?? ""))
              .toList(),
          title: StringConstant.specialties,
          labelText: StringConstant.specialties,
          selectedColor: AppColors.black,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          chipDisplay: MultiSelectChipDisplay(
            chipColor: AppColors.transparent,
            onDelete: (value) {
              print("On delete called!");
              context.read<HealthcarePostBloc>().add(
                  HealthcarePostEvent.removeRequiredSpecialitichips(
                      value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            StringConstant.specialties,
            style: TextStyle(
                fontSize: 14, color: AppColors.black.withOpacity(0.50)),
          ),
          onConfirm: (selectedList, otherValues) {
            print("----> $selectedList");
            print("----> $otherValues");
            context
                .read<HealthcarePostBloc>()
                .add(HealthcarePostEvent.confirmSpecialityList(
                  List<String>.from(selectedList),
                  List<String>.from(otherValues),
                ));
          },
        ),
        /* if (state.showErrorMessages &&
            state.requiredSpecialityChipList.getValue().isEmpty &&
            state.specialityOther.isEmpty)
          commonErrorText(StringConstant.pleaseSelectAtLeastOneSpeciality)*/
      ],
    );
  }

  Widget languageDropDownChipSet(
      BuildContext context, HealthcarePostState state) {
    /*return Column(
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
                  .read<HealthcarePostBloc>()
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
                  .read<HealthcarePostBloc>()
                  .add(HealthcarePostEvent.addLanguageChips(newValue));
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
                  .add(HealthcarePostEvent.addLanguageChips(
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
                .read<HealthcarePostBloc>()
                .add(HealthcarePostEvent.removeLanguageChips(value));
          },
        ),
      ],
    );*/
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
              context.read<HealthcarePostBloc>().add(
                  HealthcarePostEvent.removeLanguageChips(value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            StringConstant.languagesKnown,
            style: TextStyle(
                fontSize: 14, color: AppColors.black.withOpacity(0.50)),
          ),
          initialValue: state.languageChipList.getValue(),
          otherInitialValue: state.languageOther,
          onConfirm: (selectedList, otherValues) {
            print("----> $selectedList");
            print("----> $otherValues");
            context
                .read<HealthcarePostBloc>()
                .add(HealthcarePostEvent.confirmLanguageList(
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

  Widget rateHourDropDown(BuildContext context, HealthcarePostState state) {
    return CustomTextField(
      labelText: StringConstant.rateHour,
      isLabelPadding: true,
      isPrefixValueShow: true,
      errorMaxLines: 2,
      initialValue: (state.rateHour.getValue()!.isNotEmpty)
          ? state.rateHour.getValue()
          : null,
      hintText: StringConstant.rateHour,
      keyboardType:
          TextInputType.numberWithOptions(decimal: true, signed: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      prefixIcon: Padding(
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
      prefixIconConstraints:
          BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      onChanged: (value) {
        context
            .read<HealthcarePostBloc>()
            .add(HealthcarePostEvent.rateHourChanged(value));
      },
      validator: (p0, p1) =>
          context.read<HealthcarePostBloc>().state.rateHour.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterRateHour,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget locationDropDown(BuildContext context, HealthcarePostState state) {
    print("state.location.getValue()--> ${state.location.getValue()}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomLocationDropdDown(
          labelText: StringConstant.location,
          isLabelPadding: true,
          showTextfield: false,
          isOptional: true,
          value: (state.location.getValue()!.isNotEmpty)
              ? state.location.getValue()
              : null,
          optionalWidget: GestureDetector(
            onTap: () {
              AppDialog.showInfo(
                context,
                StringConstant.missingLocationInfoDesc,
                insetPadding: EdgeInsets.symmetric(
                  horizontal: getSize(30),
                ),
              );
            },
            child: SvgPicture.asset(
              SvgImageConstant.infoCircle,
            ),
          ),
          items: state.locationList.map((val) {
            return DropdownMenuItem<String>(
              value: val.location,
              child: BaseText(
                text: val.location ?? "",
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
          validator: (
            p0,
          ) =>
              context.read<HealthcarePostBloc>().state.location.value.fold(
                    (f) => f.maybeMap(
                      empty: (value) => StringConstant.pleaseEnterLocation,
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
          onChanged: (value) {
            // print("SELECTED LOCATION----> ${value}");
            // LocationDTO selectedValue = value;
            if (value != null) {
              context.read<HealthcarePostBloc>().add(
                    HealthcarePostEvent.locationChanged(value.toString()),
                  );
            }
          },
          hintText: StringConstant.location,
          childDroDwonHintText: StringConstant.selectUnitIfAny,
          // showDropDown:   state.location.isValid(),
          showDropDown: (state.unitList.isNotEmpty && state.location.isValid()),
          childDropDownItems: state.unitList.map((val) {
            return DropdownMenuItem<String>(
              value: val.number_or_name,
              child: BaseText(
                text: val.number_or_name ?? "",
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
          childDropDownOnChanged: (value) {
            if (value != null) {
              context.read<HealthcarePostBloc>().add(
                    HealthcarePostEvent.locationUnitSelectionChanged(value),
                  );
            }
          },
        ),
        if (state.location.isValid() &&
            state.unitList.isNotEmpty &&
            state.showLocationError &&
            state.selectedLocationUnit.isEmpty)
          commonErrorText(StringConstant.pleaseSelectLocationUnit),
      ],
    );
  }
}
