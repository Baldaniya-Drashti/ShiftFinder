import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
import 'package:shift/application/employer/employer_long_term_position_add_detail/employer_long_term_position_add_detail_bloc.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/date_picker_input_field.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_chip_display.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_item.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_selectable_dropdown.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/core/widgets/time_picker_input_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import '../../common/utils/file_picker_utils.dart';
import '../../core/widgets/buttons/common_button.dart';

@RoutePage(name: "EmployerLongTermPositionAddDetailView")
class EmployerLongTermPositionAddDetailView extends StatelessWidget {
  const EmployerLongTermPositionAddDetailView({
    super.key,
    required this.postShiftDTO,
    this.employer,
    this.postId,
    this.fromReview = false,
    this.isCreate = true,
    this.fromTemplate = false,
  });

  final PostShiftDTO postShiftDTO;
  final EmployerLongTermSuccessDto? employer;
  final int? postId;
  final bool fromReview;
  final bool isCreate;
  final bool fromTemplate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: (fromTemplate)
              ? StringConstant.editTemplate
              : CommonList.industryList
                      .firstWhere((item) => item.id == getCurrentIndustry())
                      .title ??
                  ""),
      body: BlocProvider(
        create: (context) => getIt<EmployerLongTermPositionAddDetailBloc>()
          ..add(
            EmployerLongTermPositionAddDetailEvent.onCreate(
                postShiftDTO, employer, postId),
          ),
        child: _EmployerLongTermPositionDetailContent(
          employer,
          fromReview: fromReview,
          isCreate: isCreate,
          fromTemplate: fromTemplate,
        ),
      ),
    );
  }
}

class _EmployerLongTermPositionDetailContent extends StatefulWidget {
  const _EmployerLongTermPositionDetailContent(
    this.data, {
    required this.fromReview,
    required this.fromTemplate,
    required this.isCreate,
  });

  final EmployerLongTermSuccessDto? data;
  final bool fromReview;
  final bool fromTemplate;
  final bool isCreate;

  @override
  State<_EmployerLongTermPositionDetailContent> createState() =>
      _EmployerLongTermPositionDetailContentState();
}

class _EmployerLongTermPositionDetailContentState
    extends State<_EmployerLongTermPositionDetailContent> {
  late final UpdateLongTermDetailController controller;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    controller = UpdateLongTermDetailController(widget.data);
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<EmployerLongTermPositionAddDetailBloc,
          EmployerLongTermPositionAddDetailState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(getSize(16)).copyWith(top: 0),
            child: Column(
              children: [
                BlocSelector<EmployerLongTermPositionAddDetailBloc,
                    EmployerLongTermPositionAddDetailState, DateTime?>(
                  selector: (state) {
                    return state.employerLongTermAddDetailDto.start_date;
                  },
                  builder: (context, startDate) {
                    return DatePickerInputField(
                      validator: (value, _) {
                        value = value?.trim() ?? "";
                        if (value.isEmpty) {
                          return StringConstant.pleaseSelectStartDate;
                        }
                        return null;
                      },
                      label: StringConstant.startDate,
                      hint: StringConstant.startDate,
                      firstDate: DateTime.now().add(Duration(days: 1)),
                      initialDate: startDate,
                      onPickedDate: (DateTime date) {
                        context
                            .read<EmployerLongTermPositionAddDetailBloc>()
                            .add(
                              EmployerLongTermPositionAddDetailEvent
                                  .selectStartDate(startDate: date),
                            );
                      },
                    );
                  },
                ),
                Gap(getSize(12)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc,
                    EmployerLongTermPositionAddDetailState, DateTime?>(
                  selector: (state) {
                    return state.employerLongTermAddDetailDto.end_date;
                  },
                  builder: (context, endDate) {
                    return DatePickerInputField(
                      validator: (value, _) {
                        value = value?.trim() ?? "";
                        if (value.isEmpty) {
                          return StringConstant.pleaseSelectEndDate;
                        }
                        return null;
                      },
                      label: StringConstant.endDate,
                      hint: StringConstant.endDate,
                      initialDate: (endDate != null) ? endDate : null,
                      firstDate:
                          (state.employerLongTermAddDetailDto.start_date !=
                                  null)
                              ? state.employerLongTermAddDetailDto.start_date!
                                  .add(Duration(days: 1))
                              : DateTime.now().add(Duration(days: 1)),
                      onPickedDate: (DateTime date) {
                        context
                            .read<EmployerLongTermPositionAddDetailBloc>()
                            .add(
                              EmployerLongTermPositionAddDetailEvent
                                  .selectEndDate(endaDate: date),
                            );
                      },
                    );
                  },
                ),
                Gap(getSize(12)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc,
                    EmployerLongTermPositionAddDetailState, DateTime?>(
                  selector: (state) =>
                      state.employerLongTermAddDetailDto.application_deadline,
                  builder: (context, applicationDeadline) {
                    return DatePickerInputField(
                      label: StringConstant.applicationDeadline,
                      hint: StringConstant.applicationDeadline,
                      validator: (value, _) {
                        value = value?.trim() ?? "";
                        if (value.isEmpty) {
                          return StringConstant
                              .pleaseSelectApplicationDeadlineDate;
                        }
                        return null;
                      },
                      initialDate: (applicationDeadline != null)
                          ? applicationDeadline
                          : null,
                      firstDate:
                          (state.employerLongTermAddDetailDto.start_date !=
                                  null)
                              ? state.employerLongTermAddDetailDto.start_date!
                                  .add(Duration(days: 1))
                              : null,
                      onPickedDate: (DateTime date) {
                        context
                            .read<EmployerLongTermPositionAddDetailBloc>()
                            .add(
                              EmployerLongTermPositionAddDetailEvent
                                  .selectApplicationDeadline(deadLine: date),
                            );
                      },
                    );
                  },
                ),
                Gap(getSize(12)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc,
                    EmployerLongTermPositionAddDetailState, TimeOfDay?>(
                  selector: (state) =>
                      state.employerLongTermAddDetailDto.estimated_weekly_hours,
                  builder: (context, estimatedHours) {
                    return TimePickerInputField(
                      label: StringConstant.estimatedWeeklyHours,
                      hint: "00h 00min",
                      validator: (value, _) {
                        value = value?.trim() ?? "";
                        if (value.isEmpty) {
                          return StringConstant.pleaseSelectEstimationHours;
                        }
                        return null;
                      },
                      initialTime: estimatedHours,
                      onPickedTime: (value) {
                        context
                            .read<EmployerLongTermPositionAddDetailBloc>()
                            .add(
                              EmployerLongTermPositionAddDetailEvent
                                  .selectEstimatedHour(estimatedHour: value),
                            );
                      },
                    );
                  },
                ),
                Gap(getSize(12)),
                BlocSelector<
                    EmployerLongTermPositionAddDetailBloc,
                    EmployerLongTermPositionAddDetailState,
                    ListInputEmptyOrNot>(
                  selector: (state) {
                    return state.requiredShiftScheduleChipList;
                  },
                  builder: (context, state) {
                    return _ShiftSchedule(initialValue: state.getValue());
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  labelText: StringConstant.jobDescription,
                  controller: controller._jobDescriptionController,
                  hintText: StringConstant.typeHerewithDots,
                  maxLines: 3,
                  validator: (value, context) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) {
                      return StringConstant.pleaseEnterJobDescription;
                    }
                    return null;
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  labelText: StringConstant.requirements,
                  controller: controller._requirementsController,
                  hintText: StringConstant.typeHerewithDots,
                  maxLines: 3,
                  validator: (value, context) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) {
                      return StringConstant.pleaseEnterRequirements;
                    }
                    return null;
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  labelText: StringConstant.responsibilities,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller._responsibilityController,
                  hintText: StringConstant.typeHerewithDots,
                  maxLines: 3,
                  validator: (value, _) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) {
                      return StringConstant.pleaseEnterResponsibilities;
                    }
                    return null;
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  labelText: StringConstant.qualifications,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller._qualificationController,
                  hintText: StringConstant.typeHerewithDots,
                  maxLines: 3,
                  validator: (value, _) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) {
                      return StringConstant.pleaseEnterQualification;
                    }
                    return null;
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  labelText: StringConstant.licensesCertifications,
                  controller: controller._licensesController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: StringConstant.typeHerewithDots,
                  maxLines: 3,
                  validator: (value, _) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) {
                      return StringConstant.pleaseEnterLicensesCertifications;
                    }
                    return null;
                  },
                ),
                Gap(getSize(16)),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      BaseText(
                        text: StringConstant.contractTerms,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(getSize(2)),
                      BaseText(
                        text: "(${StringConstant.optional})",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                Gap(getSize(8)),
                Material(
                  color: AppColors.grey04,
                  borderRadius: BorderRadius.circular(getSize(20)),
                  child: Padding(
                    padding: EdgeInsets.all(getSize(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(text: StringConstant.terms, fontSize: 14),
                        Gap(getSize(12)),
                        CustomTextField(
                          controller: controller._termsController,
                          hintText: StringConstant.typeHerewithDots,
                          maxLines: 3,
                        ),
                        Gap(getSize(16)),
                        BlocSelector<EmployerLongTermPositionAddDetailBloc,
                            EmployerLongTermPositionAddDetailState, String?>(
                          selector: (state) =>
                              state.employerLongTermAddDetailDto.terms_document,
                          builder: (context, documentPath) {
                            if (documentPath != null) {
                              return selectedImage(context, documentPath);
                            }
                            return _UploadDocument();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(getSize(16)),
                CustomTextField(
                  labelText: StringConstant.onboardingProcess,
                  controller: controller._onBoardingController,
                  hintText: StringConstant.typeHerewithDots,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: 3,
                  validator: (value, _) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) {
                      return StringConstant.pleaseEnterOnboardingProcess;
                    }
                    return null;
                  },
                ),
                Gap(getSize(16)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc,
                    EmployerLongTermPositionAddDetailState, bool>(
                  selector: (state) {
                    return state
                            .employerLongTermAddDetailDto.on_call_included ==
                        1;
                  },
                  builder: (context, onCallIncluded) {
                    return _buildCheckListTile(
                      context,
                      value: onCallIncluded,
                      onChanged: (value) {
                        context
                            .read<EmployerLongTermPositionAddDetailBloc>()
                            .add(
                              EmployerLongTermPositionAddDetailEvent
                                  .onChangeContractIncludeCall(
                                      onCallIncluded ? 0 : 1),
                            );
                      },
                      label: StringConstant.thisContractMayIncludeOnCall,
                    );
                  },
                ),
                Gap(getSize(16)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc,
                    EmployerLongTermPositionAddDetailState, bool>(
                  selector: (state) {
                    return state.employerLongTermAddDetailDto.vacancie_type ==
                        1;
                    // ||state.employerLongTermAddDetailDto.number_of_vacancie !=  null;
                  },
                  builder: (context, vacancyEnable) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildCheckListTile(
                          context,
                          value: vacancyEnable,
                          onChanged: (value) {
                            controller._vacancyController.clear();
                            context
                                .read<EmployerLongTermPositionAddDetailBloc>()
                                .add(
                                  EmployerLongTermPositionAddDetailEvent
                                      .addMoreVacancy(vacancyEnable ? 0 : 1),
                                );
                          },
                          label: StringConstant.singleShiftVacancyDesc,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                        ),
                        if (vacancyEnable) ...[
                          Gap(getSize(12)),
                          CustomTextField(
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: controller._vacancyController,
                            labelText: StringConstant.numberOfVacancies,
                            hintText: StringConstant.numberOfVacancies,
                            keyboardType: TextInputType.number,
                            errorInputBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.transparent),
                              borderRadius: BorderRadius.circular(getSize(10)),
                            ),
                            maxLength: 3,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value, _) {
                              if (!vacancyEnable) return null;
                              value = value?.trim() ?? "";
                              if (value.isEmpty) {
                                return StringConstant
                                    .pleaseAddNumberOfVacancies;
                              }
                              final newValue = int.tryParse(value);
                              if (newValue == null) {
                                return StringConstant.pleaseEnterValidValue;
                              }
                              if (newValue < 2) {
                                return StringConstant
                                    .numberOfVacanciesMustBeGreaterThanOne;
                              } else {
                                return null;
                              }
                            },
                          )
                        ],
                      ],
                    );
                  },
                ),
                Gap(getSize(16)),
                CommonButton(
                  onPressed: () {
                    final list = context
                        .read<EmployerLongTermPositionAddDetailBloc>()
                        .state
                        .requiredShiftScheduleChipList
                        .getValue();
                    if (_formKey.currentState?.validate() != true ||
                        list.isEmpty) {
                      showError(
                              message: StringConstant
                                  .someDetailsAreMissingOrInvalidPleaseCheck)
                          .show(context);
                      return;
                    }
                    final employer = context
                        .read<EmployerLongTermPositionAddDetailBloc>()
                        .state
                        .employerLongTermAddDetailDto;
                    final startDate = employer.start_date;
                    final endDate = employer.end_date;
                    if (startDate == null || endDate == null) return;
                    final difference = endDate.difference(startDate);
                    final months = difference.inDays % 365 ~/ 30;
                    if (months < 3) {
                      AppDialog.showCommonDialog(
                        context: context,
                        content: StringConstant.threeMonthPolicyDesc,
                        title: StringConstant.longTermPosition,
                        successLabel: StringConstant.ok,
                        action: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: getSize(32)),
                          child: CommonButton(
                            onPressed: () => context.router.maybePop(true),
                            buttonText: StringConstant.ok,
                          ),
                        ),
                      );
                      return;
                    }
                    context.read<EmployerLongTermPositionAddDetailBloc>().add(
                          EmployerLongTermPositionAddDetailEvent.onContinue(
                            context: context,
                            jobDescription: controller.jobDescription,
                            requirements: controller.requirements,
                            responsibilities: controller.responsibility,
                            qualification: controller.qualification,
                            licences: controller.licenses,
                            onboarding: controller.onBoarding,
                            terms: controller.terms,
                            numberOfVacancy: controller.vacancy,
                            fromReview: widget.fromReview,
                            isCreate: widget.isCreate,
                            fromTemplate: widget.fromTemplate,
                          ),
                        );
                  },
                  buttonText: StringConstant.txtContinue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCheckListTile(
    BuildContext context, {
    required bool value,
    required void Function(bool value) onChanged,
    required String label,
    EdgeInsets? padding,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Material(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(getSize(10)),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 0.9,
                child: Checkbox(
                  activeColor: AppColors.primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  side: BorderSide(
                      color: AppColors.black.withValues(alpha: .5), width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  value: value,
                  onChanged: (value) {
                    if (value == null) return;
                    onChanged(value);
                  },
                ),
              ),
              Gap(4),
              Expanded(
                child: BaseText(
                    text: label,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    maxLines: 10),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget selectedImage(
    BuildContext context,
    String selectedFile,
  ) {
    return ShowPickedFile(
      selectedFile: selectedFile,
      mainBoxHeight: getSize(300),
      childBoxHeight: getSize(250),
      childBoxWidth: getSize(260),
      onDelete: () {
        AppDialog.showDelete(
          context,
          title: StringConstant.delete,
          infoMessage: StringConstant.areYouSureYouWantToDeleteThisDocument,
          onCancelClick: () => Navigator.pop(context),
          onDeleteClick: () {
            Navigator.pop(context);
            context
                .read<EmployerLongTermPositionAddDetailBloc>()
                .add(EmployerLongTermPositionAddDetailEvent.removeDocument(
                  isCreate: widget.isCreate,
                  fromReview: widget.fromReview,
                ));
          },
        );
      },
    );
  }
}

class _UploadDocument extends StatelessWidget {
  const _UploadDocument();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseText(
          text: StringConstant.uploadDocument,
          fontSize: 14,
        ),
        Gap(getSize(12)),
        Container(
          height: 290,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              clickUploadButton(context);
            },
            child: Container(
              color: AppColors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: getSize(66),
                    width: getSize(58),
                    child: Image.asset(PngImageConstants.upload),
                  ),
                  SizedBox(height: getSize(20)),
                  CommonButton(
                    onPressed: () {
                      clickUploadButton(context);
                    },
                    width: 140,
                    height: 28,
                    backgroundColor:
                        AppColors.primaryColor.withValues(alpha: 0.15),
                    borderRadius: 5,
                    buttonText: StringConstant.upload,
                    customWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          SvgImageConstant.upload,
                        ),
                        SizedBox(
                          width: getSize(10),
                        ),
                        BaseText(
                          text: StringConstant.upload,
                          fontSize: 12,
                          textAlign: TextAlign.center,
                          //maxLines: 1,
                          fontWeight: FontWeight.w600,
                          textColor: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void clickUploadButton(BuildContext context) {
    ImageChooserDialog().showImageChooserDialog(
      takePhotoCallback: () async {
        String path = await ImagePickerUtils()
                .pickImage(imageSource: ImageSource.camera, context: context) ??
            '';
        if (path.isNotEmpty) {
          context.read<EmployerLongTermPositionAddDetailBloc>().add(
              EmployerLongTermPositionAddDetailEvent.selectDocument(
                  path: path));
        }
      },
      selectPhotoCallback: () async {
        String path = await ImagePickerUtils().pickImage(
                imageSource: ImageSource.gallery, context: context) ??
            '';

        if (path.isNotEmpty) {
          context.read<EmployerLongTermPositionAddDetailBloc>().add(
              EmployerLongTermPositionAddDetailEvent.selectDocument(
                  path: path));
        }
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          context.read<EmployerLongTermPositionAddDetailBloc>().add(
              EmployerLongTermPositionAddDetailEvent.selectDocument(
                  path: path));
        }
      },
      context: context,
    );
  }
}

class _ShiftSchedule extends StatelessWidget {
  const _ShiftSchedule({required this.initialValue});

  final List<dynamic> initialValue;

  @override
  Widget build(BuildContext context) {
    final list = [
      CommonDropdownModel(id: 1, label: "Morning"),
      CommonDropdownModel(id: 2, label: "Evening"),
      CommonDropdownModel(id: 3, label: "Night"),
      CommonDropdownModel(id: 4, label: "Weekends"),
      CommonDropdownModel(id: 5, label: "Weekdays"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MultiSelectDialogField(
          isOptional: false,
          isShowOtherValue: false,
          initialValue: initialValue,
          items: list
              .map((item) => MultiSelectItem<String>(item.label, item.label))
              .toList(),
          title: StringConstant.shiftSchedule,
          labelText: StringConstant.shiftSchedule,
          selectedColor: AppColors.black,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          chipDisplay: MultiSelectChipDisplay(
            chipColor: AppColors.transparent,
            onDelete: (value) {
              context.read<EmployerLongTermPositionAddDetailBloc>().add(
                  EmployerLongTermPositionAddDetailEvent.removeShiftSchedule(
                      value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            StringConstant.shiftSchedule,
            style: TextStyle(
                fontSize: 14, color: AppColors.black.withValues(alpha: 0.50)),
          ),
          onConfirm: (selectedList, otherValues) {
            context.read<EmployerLongTermPositionAddDetailBloc>().add(
                    EmployerLongTermPositionAddDetailEvent.confirmShiftSchedule(
                  List<String>.from(selectedList),
                ));
          },
        ),
        if (initialValue.isEmpty)
          commonErrorText(
            StringConstant.pleaseSelectAtLeastOneLanguage,
            padding: EdgeInsets.only(left: getSize(20), top: getSize(4)),
          )
      ],
    );
  }
}

class UpdateLongTermDetailController extends ChangeNotifier {
  UpdateLongTermDetailController(EmployerLongTermSuccessDto? data) {
    _jobDescriptionController =
        TextEditingController(text: data?.job_description);
    _requirementsController = TextEditingController(text: data?.requirements);
    _responsibilityController =
        TextEditingController(text: data?.responsibilities);
    _qualificationController =
        TextEditingController(text: data?.qualifications);
    _licensesController =
        TextEditingController(text: data?.licenses_certifications);
    _termsController = TextEditingController(text: data?.terms);
    _onBoardingController =
        TextEditingController(text: data?.onboarding_process);
    _vacancyController =
        TextEditingController(text: "${data?.number_of_vacancie ?? ""}");
  }

  late final TextEditingController _jobDescriptionController;
  late final TextEditingController _requirementsController;
  late final TextEditingController _responsibilityController;
  late final TextEditingController _qualificationController;
  late final TextEditingController _licensesController;
  late final TextEditingController _termsController;
  late final TextEditingController _onBoardingController;
  late final TextEditingController _vacancyController;

  String get jobDescription => _jobDescriptionController.text.trim();

  String get requirements => _requirementsController.text.trim();

  String get responsibility => _responsibilityController.text.trim();

  String get qualification => _qualificationController.text.trim();

  String get licenses => _licensesController.text.trim();

  String get terms => _termsController.text.trim();

  String get onBoarding => _onBoardingController.text.trim();

  String get vacancy => _vacancyController.text.trim();

  @override
  void dispose() {
    super.dispose();
    _jobDescriptionController.dispose();
    _requirementsController.dispose();
    _responsibilityController.dispose();
    _qualificationController.dispose();
    _licensesController.dispose();
    _termsController.dispose();
    _onBoardingController.dispose();
    _vacancyController.dispose();
  }
}
