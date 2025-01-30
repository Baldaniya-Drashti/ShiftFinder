import 'dart:async';

import 'package:auto_route/annotations.dart';
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
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/date_picker_input_field.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
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
  });

  final PostShiftDTO postShiftDTO;
  final EmployerLongTermSuccessDto? employer;
  final int? postId;

  @override
  Widget build(BuildContext context) {
    print("employerrrr=> ${employer?.job_description}");
    print("employerrrr=> ${postId}");
    return Scaffold(
      appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Health Care"),
      body: BlocProvider(
        create: (context) => getIt<EmployerLongTermPositionAddDetailBloc>()
          ..add(
            EmployerLongTermPositionAddDetailEvent.onCreate(postShiftDTO, employer, postId),
          ),
        child: _EmployerLongTermPositionDetailContent(employer),
      ),
    );
  }
}

class _EmployerLongTermPositionDetailContent extends StatefulWidget {
  const _EmployerLongTermPositionDetailContent(this.data);

  final EmployerLongTermSuccessDto? data;

  @override
  State<_EmployerLongTermPositionDetailContent> createState() => _EmployerLongTermPositionDetailContentState();
}

class _EmployerLongTermPositionDetailContentState extends State<_EmployerLongTermPositionDetailContent> {
  late final UpdateLongTermDetailController controller;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    print("data => ${widget.data?.job_description}");
    controller = UpdateLongTermDetailController(widget.data);
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(getSize(16)).copyWith(top: 0),
            child: Column(
              children: [
                BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, DateTime?>(
                  selector: (state) {
                    return state.employerLongTermAddDetailDto.start_date;
                  },
                  builder: (context, startDate) {
                    return DatePickerInputField(
                      validator: (value, _) {
                        value = value?.trim() ?? "";
                        if (value.isEmpty) {
                          return "Please select start date";
                        }
                        return null;
                      },
                      label: "Start Date",
                      hint: "Start Date",
                      initialDate: startDate,
                      onPickedDate: (DateTime date) {
                        context.read<EmployerLongTermPositionAddDetailBloc>().add(
                              EmployerLongTermPositionAddDetailEvent.selectStartDate(startDate: date),
                            );
                      },
                    );
                  },
                ),
                Gap(getSize(12)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, DateTime?>(
                  selector: (state) {
                    return state.employerLongTermAddDetailDto.end_date;
                  },
                  builder: (context, endDate) {
                    return DatePickerInputField(
                      validator: (value, _) {
                        value = value?.trim() ?? "";
                        if (value.isEmpty) {
                          return "Please select end date";
                        }
                        return null;
                      },
                      label: "End Date",
                      hint: "End Date",
                      initialDate: endDate,
                      onPickedDate: (DateTime date) {
                        context.read<EmployerLongTermPositionAddDetailBloc>().add(
                              EmployerLongTermPositionAddDetailEvent.selectEndDate(endaDate: date),
                            );
                      },
                    );
                  },
                ),
                Gap(getSize(12)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, DateTime?>(
                  selector: (state) => state.employerLongTermAddDetailDto.application_deadline,
                  builder: (context, applicationDeadline) {
                    return DatePickerInputField(
                      label: "Application Deadline",
                      hint: "Application Deadline",
                      validator: (value, _) {
                        value = value?.trim() ?? "";
                        if (value.isEmpty) {
                          return "Please select application deadline date";
                        }
                        return null;
                      },
                      initialDate: applicationDeadline,
                      onPickedDate: (DateTime date) {
                        context.read<EmployerLongTermPositionAddDetailBloc>().add(
                              EmployerLongTermPositionAddDetailEvent.selectApplicationDeadline(deadLine: date),
                            );
                      },
                    );
                  },
                ),
                Gap(getSize(12)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, TimeOfDay?>(
                  selector: (state) => state.employerLongTermAddDetailDto.estimated_weekly_hours,
                  builder: (context, estimatedHours) {
                    return TimePickerInputField(
                      label: "Estimated Weekly Hours",
                      hint: "00h 00min",
                      validator: (value, _) {
                        value = value?.trim() ?? "";
                        if (value.isEmpty) {
                          return "Please select estimation hours";
                        }
                        return null;
                      },
                      initialTime: estimatedHours,
                      onPickedTime: (value) {
                        context.read<EmployerLongTermPositionAddDetailBloc>().add(
                              EmployerLongTermPositionAddDetailEvent.selectEstimatedHour(estimatedHour: value),
                            );
                      },
                    );
                  },
                ),
                Gap(getSize(12)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, ListInputEmptyOrNot>(
                  selector: (state) {
                    return state.requiredShiftScheduleChipList;
                  },
                  builder: (context, state) {
                    print("initialValue =>${state.getValue()}");
                    return _ShiftSchedule(initialValue: state.getValue());
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  labelText: "Job Description",
                  controller: controller._jobDescriptionController,
                  hintText: "Type Here...",
                  maxLines: 3,
                  validator: (value, context) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) return "Please enter job description";
                    return null;
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  labelText: "Requirements",
                  controller: controller._requirementsController,
                  hintText: "Type Here...",
                  maxLines: 3,
                  validator: (value, context) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) return "Please enter requirements";
                    return null;
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  labelText: "Responsibilities",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller._responsibilityController,
                  hintText: "Type Here...",
                  maxLines: 3,
                  validator: (value, _) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) return "Please enter responsibilities";
                    return null;
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  labelText: "Qualifications",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller._qualificationController,
                  hintText: "Type Here...",
                  maxLines: 3,
                  validator: (value, _) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) return "Please enter qualification";
                    return null;
                  },
                ),
                Gap(getSize(12)),
                CustomTextField(
                  labelText: "Licenses/Certifications",
                  controller: controller._licensesController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: "Type Here...",
                  maxLines: 3,
                  validator: (value, _) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) return "Please enter licenses/certifications";
                    return null;
                  },
                ),
                Gap(getSize(16)),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      BaseText(
                        text: "Contract Terms",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(2),
                      BaseText(
                        text: "(Optional)",
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
                        BaseText(text: "Terms", fontSize: 14),
                        Gap(getSize(12)),
                        CustomTextField(
                          controller: controller._termsController,
                          hintText: "Type Here...",
                          maxLines: 3,
                        ),
                        Gap(getSize(16)),
                        BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, String?>(
                          selector: (state) => state.employerLongTermAddDetailDto.terms_document,
                          builder: (context, documentPath) {
                            if (documentPath != null) return selectedImage(context, documentPath);
                            return _UploadDocument();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(getSize(16)),
                CustomTextField(
                  labelText: "Onboarding Process",
                  controller: controller._onBoardingController,
                  hintText: "Type Here...",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: 3,
                  validator: (value, _) {
                    value = value?.trim() ?? "";
                    if (value.isEmpty) return "Please enter onboarding process";
                    return null;
                  },
                ),
                Gap(getSize(16)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, bool>(
                  selector: (state) {
                    return state.employerLongTermAddDetailDto.on_call_included == 1;
                  },
                  builder: (context, onCallIncluded) {
                    return _buildCheckListTile(
                      context,
                      value: onCallIncluded,
                      onChanged: (value) {
                        context.read<EmployerLongTermPositionAddDetailBloc>().add(
                              EmployerLongTermPositionAddDetailEvent.onChangeContractIncludeCall(onCallIncluded ? 0 : 1),
                            );
                      },
                      label: "This contract may include on call.",
                    );
                  },
                ),
                Gap(getSize(16)),
                BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, bool>(
                  selector: (state) {
                    return state.employerLongTermAddDetailDto.vacancie_type == 1 ||
                        state.employerLongTermAddDetailDto.number_of_vacancie != null;
                  },
                  builder: (context, vacancyEnable) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildCheckListTile(
                          context,
                          value: vacancyEnable,
                          onChanged: (value) {
                            context.read<EmployerLongTermPositionAddDetailBloc>().add(
                                  EmployerLongTermPositionAddDetailEvent.addMoreVacancy(vacancyEnable ? 0 : 1),
                                );
                          },
                          label: "We are looking to fill more than one vacancies with the same  requirements.",
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        ),
                        if (vacancyEnable) ...[
                          Gap(getSize(12)),
                          CustomTextField(
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            controller: controller._vacancyController,
                            labelText: StringConstant.numberOfVacancies,
                            hintText: StringConstant.numberOfVacancies,
                            keyboardType: TextInputType.number,
                            errorInputBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: AppColors.transparent),
                              borderRadius: BorderRadius.circular(getSize(10)),
                            ),
                            maxLength: 3,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value, _) {
                              if (!vacancyEnable) return null;
                              value = value?.trim() ?? "";
                              if (value.isEmpty) return StringConstant.pleaseAddNumberOfVacancies;
                              final newValue = int.tryParse(value);
                              if (newValue == null) return "Please enter valid value";
                              if (newValue < 1) {
                                return StringConstant.numberOfVacanciesMustBeGreaterThanOne;
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
                    final list = context.read<EmployerLongTermPositionAddDetailBloc>().state.requiredShiftScheduleChipList.getValue();
                    if (_formKey.currentState?.validate() != true || list.isEmpty) {
                      showError(message: StringConstant.someDetailsAreMissingOrInvalidPleaseCheck).show(context);
                      return;
                    }
                    final employer = context.read<EmployerLongTermPositionAddDetailBloc>().state.employerLongTermAddDetailDto;
                    final startDate = employer.start_date;
                    final endDate = employer.end_date;
                    if (startDate == null || endDate == null) return;
                    final difference = endDate.difference(startDate);
                    final months = difference.inDays % 365 ~/ 30;
                    if (months < 3) {
                      AppDialog.showCommonDialog(
                        context: context,
                        content:
                            "Long-term contracts must be at least three months. If your posting doesn't meet this  requirement, consider using our multi-shift feature to schedule your shifts more flexibly.",
                        title: "Long-Term Position",
                        successLabel: "Ok",
                        action: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: CommonButton(
                            onPressed: () => context.router.maybePop(true),
                            buttonText: "Ok",
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
                          ),
                        );
                  },
                  buttonText: "Continue",
                )
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
    return Material(
      color: AppColors.surfaceColor,
      borderRadius: BorderRadius.circular(getSize(10)),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
                side: BorderSide(color: AppColors.black.withOpacity(.5), width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                value: value,
                onChanged: (value) {
                  if (value == null) return;
                  onChanged(value);
                },
              ),
            ),
            Gap(4),
            Expanded(
              child: BaseText(text: label, fontSize: 12, fontWeight: FontWeight.w500, maxLines: 10),
            )
          ],
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
          infoMessage: StringConstant.deleteGovernmentIdDesc,
          onCancelClick: () => Navigator.pop(context),
          onDeleteClick: () {
            Navigator.pop(context);
            context.read<EmployerLongTermPositionAddDetailBloc>().add(EmployerLongTermPositionAddDetailEvent.removeDocument());
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
          text: "Upload Document",
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
                  const SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                    onPressed: () {
                      clickUploadButton(context);
                    },
                    width: 140,
                    height: 28,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.15),
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
        String path = await ImagePickerUtils().pickImage(imageSource: ImageSource.camera, context: context) ?? '';
        if (path.isNotEmpty) {
          print("CAMERA IMAGE PATH: $path");
          context.read<EmployerLongTermPositionAddDetailBloc>().add(EmployerLongTermPositionAddDetailEvent.selectDocument(path: path));
        }
      },
      selectPhotoCallback: () async {
        String path = await ImagePickerUtils().pickImage(imageSource: ImageSource.gallery, context: context) ?? '';

        if (path.isNotEmpty) {
          context.read<EmployerLongTermPositionAddDetailBloc>().add(EmployerLongTermPositionAddDetailEvent.selectDocument(path: path));
        }
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
          context.read<EmployerLongTermPositionAddDetailBloc>().add(EmployerLongTermPositionAddDetailEvent.selectDocument(path: path));
        }
      },
      context: context,
    );
  }
}

class _ShiftSchedule extends StatelessWidget {
  const _ShiftSchedule({super.key, required this.initialValue});

  final List<dynamic> initialValue;

  @override
  Widget build(BuildContext context) {
    print("===> ${initialValue}");
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
          items: list.map((item) => MultiSelectItem<String>(item.label, item.label)).toList(),
          title: "Shift Schedule",
          labelText: "Shift Schedule",
          selectedColor: AppColors.black,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          chipDisplay: MultiSelectChipDisplay(
            chipColor: AppColors.transparent,
            onDelete: (value) {
              print("On delete called!");
              context
                  .read<EmployerLongTermPositionAddDetailBloc>()
                  .add(EmployerLongTermPositionAddDetailEvent.removeShiftSchedule(value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            "Shift Schedule",
            style: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.50)),
          ),
          onConfirm: (selectedList, otherValues) {
            context.read<EmployerLongTermPositionAddDetailBloc>().add(EmployerLongTermPositionAddDetailEvent.confirmShiftSchedule(
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
    _jobDescriptionController = TextEditingController(text: data?.job_description);
    _requirementsController = TextEditingController(text: data?.requirements);
    _responsibilityController = TextEditingController(text: data?.responsibilities);
    _qualificationController = TextEditingController(text: data?.qualifications);
    _licensesController = TextEditingController(text: data?.licenses_certifications);
    _termsController = TextEditingController(text: data?.terms);
    _onBoardingController = TextEditingController(text: data?.onboarding_process);
    _vacancyController = TextEditingController(text: "${data?.number_of_vacancie ?? ""}");
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
