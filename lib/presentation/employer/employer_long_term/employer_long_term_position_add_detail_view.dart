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
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/datetime_extensions.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import '../../common/utils/file_picker_utils.dart';
import '../../core/widgets/buttons/common_button.dart';

@RoutePage(name: "EmployerLongTermPositionAddDetailView")
class EmployerLongTermPositionAddDetailView extends StatelessWidget {
  const EmployerLongTermPositionAddDetailView({super.key, required this.postShiftDTO});

  final PostShiftDTO postShiftDTO;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Health Care"),
      body: BlocProvider(
        create: (context) => getIt<EmployerLongTermPositionAddDetailBloc>()
          ..add(
            EmployerLongTermPositionAddDetailEvent.onCreate(postShiftDTO),
          ),
        child: _EmployerLongTermPositionDetailContent(),
      ),
    );
  }
}

class _EmployerLongTermPositionDetailContent extends StatefulWidget {
  const _EmployerLongTermPositionDetailContent({super.key});

  @override
  State<_EmployerLongTermPositionDetailContent> createState() => _EmployerLongTermPositionDetailContentState();
}

class _EmployerLongTermPositionDetailContentState extends State<_EmployerLongTermPositionDetailContent> {
  late final TextEditingController _jobDescriptionController;
  late final TextEditingController _requirementsController;
  late final TextEditingController _responsibilityController;
  late final TextEditingController _qualificationController;
  late final TextEditingController _licensesController;
  late final TextEditingController _termsController;
  late final TextEditingController _onBoardingController;
  late final TextEditingController _vacancyController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final employer = context.read<EmployerLongTermPositionAddDetailBloc>().state.employerLongTermAddDetailDto;

    _jobDescriptionController = TextEditingController();
    _requirementsController = TextEditingController();
    _responsibilityController = TextEditingController();
    _onBoardingController = TextEditingController();
    _qualificationController = TextEditingController();
    _termsController = TextEditingController();
    _licensesController = TextEditingController();
    _vacancyController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final hasMoreVacancy =
        context.select<EmployerLongTermPositionAddDetailBloc, bool>((value) => value.state.hasMoreVacancy);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
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
              selector: (state) => state.employerLongTermAddDetailDto.applicationDeadline,
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
            BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState,
                CommonDropdownModel?>(
              selector: (state) => state.selectedShiftSchedule,
              builder: (context, selectedShiftSchedule) {
                return ShiftScheduleDropdownField(
                  selectedShiftSchedule: selectedShiftSchedule,
                  onChanged: (value) {
                    context.read<EmployerLongTermPositionAddDetailBloc>().add(
                          EmployerLongTermPositionAddDetailEvent.onShiftScheduleChanged(value: value),
                        );
                  },
                );
              },
            ),
            Gap(getSize(12)),
            CustomTextField(
              autoValidateMode: AutovalidateMode.onUserInteraction,
              labelText: "Job Description",
              controller: _jobDescriptionController,
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
              controller: _requirementsController,
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
              controller: _responsibilityController,
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
              controller: _qualificationController,
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
              controller: _licensesController,
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
                      hintText: "Type Here...",
                      maxLines: 3,
                    ),
                    Gap(getSize(16)),
                    BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState,
                        String?>(
                      selector: (state) => state.documentPath,
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
              controller: _onBoardingController,
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
            _buildCheckListTile(
              context,
              value: false,
              onChanged: (value) {},
              label: "This contract may include on call.",
            ),
            Gap(getSize(16)),
            _buildCheckListTile(
              context,
              value: hasMoreVacancy,
              onChanged: (value) {
                context.read<EmployerLongTermPositionAddDetailBloc>().add(
                      EmployerLongTermPositionAddDetailEvent.addMoreVacancy(value),
                    );
              },
              label: "We are looking to fill more than one vacancies with the same  requirements.",
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            if (hasMoreVacancy) ...[
              Gap(getSize(12)),
              CustomTextField(
                controller: _vacancyController,
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
                  if (!hasMoreVacancy) return null;
                  value = value?.trim() ?? "";
                  if (value.isEmpty) {
                    return StringConstant.pleaseAddNumberOfVacancies;
                  }
                  if (value == "1" || value == "0") {
                    return StringConstant.numberOfVacanciesMustBeGreaterThanOne;
                  } else {
                    return null;
                  }
                },
              )
            ],
            Gap(getSize(16)),
            CommonButton(
              onPressed: () {
                if (_formKey.currentState?.validate() != true) return;
                final employer =
                    context.read<EmployerLongTermPositionAddDetailBloc>().state.employerLongTermAddDetailDto;
                final startDate = employer.start_date;
                final endDate = employer.end_date;
                if (startDate == null || endDate == null) return;
                final difference = endDate.difference(startDate);
                final months = (difference.inDays % 365 / 30).toInt();
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
                final postShift = context.read<EmployerLongTermPositionAddDetailBloc>().state.postShiftDto;

                context.router.push(
                  PageRouteInfo(
                    EmployerLongTermPostConfirmationView.name,
                    args: EmployerLongTermPostConfirmationView(postShiftDTO: postShift, employerAddDetailDto: employer),
                  ),
                );
              },
              buttonText: "Continue",
            )
          ],
        ),
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
          onDeleteClick: () {},
        );
      },
    );
  }
}

class DatePickerInputField extends StatefulWidget {
  const DatePickerInputField({
    super.key,
    required this.label,
    required this.hint,
    this.initialDate,
    required this.onPickedDate,
    this.firstDate,
    this.lastDate,
    this.validator,
  });

  final String label;
  final String hint;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime date) onPickedDate;
  final String? Function(String? value, BuildContext context)? validator;

  @override
  State<DatePickerInputField> createState() => _DatePickerInputFieldState();
}

class _DatePickerInputFieldState extends State<DatePickerInputField> {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      autoValidateMode: AutovalidateMode.onUserInteraction,
      controller: TextEditingController(text: widget.initialDate != null ? widget.initialDate?.formattedString : ""),
      validator: widget.validator,
      labelText: widget.label,
      hintText: widget.hint,
      hintAsValue: widget.initialDate != null,
      readOnly: true,
      errorInputBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(SvgImageConstant.calendar, height: getSize(24), width: getSize(24)),
      ),
      onTap: () {
        DocumentExpiryDatePicker.customDatePicker(
          context,
          firstDate: widget.firstDate ?? DateTime.now(),
          onPickedDate: widget.onPickedDate,
          onCancelClick: () {},
          selectedDate: widget.initialDate ?? DateTime.now(),
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
          context
              .read<EmployerLongTermPositionAddDetailBloc>()
              .add(EmployerLongTermPositionAddDetailEvent.selectDocument(path: path));
        }
      },
      selectPhotoCallback: () async {
        String path = await ImagePickerUtils().pickImage(imageSource: ImageSource.gallery, context: context) ?? '';

        if (path.isNotEmpty) {
          context
              .read<EmployerLongTermPositionAddDetailBloc>()
              .add(EmployerLongTermPositionAddDetailEvent.selectDocument(path: path));
        }
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
          context
              .read<EmployerLongTermPositionAddDetailBloc>()
              .add(EmployerLongTermPositionAddDetailEvent.selectDocument(path: path));
        }
      },
      context: context,
    );
  }
}
