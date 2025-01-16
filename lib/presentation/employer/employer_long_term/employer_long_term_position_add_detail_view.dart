import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import '../../common/utils/file_picker_utils.dart';
import '../../core/widgets/buttons/common_button.dart';

@RoutePage(name: "EmployerLongTermPositionAddDetailView")
class EmployerLongTermPositionAddDetailView extends StatefulWidget {
  const EmployerLongTermPositionAddDetailView({super.key});

  @override
  State<EmployerLongTermPositionAddDetailView> createState() => _EmployerLongTermPositionAddDetailViewState();
}

class _EmployerLongTermPositionAddDetailViewState extends State<EmployerLongTermPositionAddDetailView> {
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();
  final TextEditingController _responsibilityController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _licensesController = TextEditingController();
  final TextEditingController _termsController = TextEditingController();
  final TextEditingController _onBoardingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermPositionAddDetailBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Health Care"),
        body: ListView(
          padding: EdgeInsets.all(getSize(16)).copyWith(top: 0),
          children: [
            BlocBuilder<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState>(
              builder: (context, state) {
                return DatePickerInputField(
                  label: "Start Date",
                  hint: "Start Date",
                  initialDate: state.startDate,
                  onPickedDate: (DateTime date) {
                    context
                        .read<EmployerLongTermPositionAddDetailBloc>()
                        .add(EmployerLongTermPositionAddDetailEvent.selectStartDate(startDate: date));
                  },
                );
              },
            ),
            Gap(getSize(12)),
            BlocBuilder<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState>(
              builder: (context, state) {
                final endDate = state.startDate != null
                    ? DateTime(state.startDate!.year, state.startDate!.month + 3, state.startDate!.day)
                    : DateTime.now();

                return DatePickerInputField(
                  firstDate: endDate,
                  label: "End Date",
                  hint: "End Date",
                  initialDate: endDate,
                  onPickedDate: (DateTime date) {
                    context
                        .read<EmployerLongTermPositionAddDetailBloc>()
                        .add(EmployerLongTermPositionAddDetailEvent.selectEndDate(endaDate: date));
                  },
                );
              },
            ),
            Gap(getSize(12)),
            BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, DateTime?>(
              selector: (state) => state.applicationDeadlineDate,
              builder: (context, startDate) {
                return DatePickerInputField(
                  label: "Application Deadline",
                  hint: "Application Deadline",
                  initialDate: startDate,
                  onPickedDate: (DateTime date) {
                    context
                        .read<EmployerLongTermPositionAddDetailBloc>()
                        .add(EmployerLongTermPositionAddDetailEvent.selectApplicationDeadline(deadLine: date));
                  },
                );
              },
            ),
            Gap(getSize(12)),
            BlocSelector<EmployerLongTermPositionAddDetailBloc, EmployerLongTermPositionAddDetailState, CommonDropdownModel?>(
              selector: (state) => state.selectedShiftSchedule,
              builder: (context, selectedShiftSchedule) {
                return ShiftScheduleDropdownField(
                  selectedShiftSchedule: selectedShiftSchedule,
                  onChanged: (value) {
                    context.read<AddFullPositionBloc>().add(AddFullPositionEvent.onShiftScheduleChanged(value));
                  },
                );
              },
            ),
            Gap(getSize(12)),
            CustomTextField(
              labelText: "Job Description",
              controller: _jobDescriptionController,
              hintText: "Type Here...",
              maxLines: 3,
            ),
            Gap(getSize(12)),
            CustomTextField(
              labelText: "Requirements",
              controller: _requirementsController,
              hintText: "Type Here...",
              maxLines: 3,
            ),
            Gap(getSize(12)),
            CustomTextField(
              labelText: "Responsibilities",
              controller: _responsibilityController,
              hintText: "Type Here...",
              maxLines: 3,
            ),
            Gap(getSize(12)),
            CustomTextField(
              labelText: "Qualifications",
              controller: _requirementsController,
              hintText: "Type Here...",
              maxLines: 3,
            ),
            Gap(getSize(12)),
            CustomTextField(
              labelText: "Licenses/Certifications",
              controller: _licensesController,
              hintText: "Type Here...",
              maxLines: 3,
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
                    _UploadDocument(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void clickUploadButton(BuildContext context) {
    ImageChooserDialog().showImageChooserDialog(
      takePhotoCallback: () async {
        String path = await ImagePickerUtils().pickImage(imageSource: ImageSource.camera, context: context) ?? '';
        if (path.isNotEmpty) {
          print("CAMERA IMAGE PATH: $path");
        }
      },
      selectPhotoCallback: () async {
        String path = await ImagePickerUtils().pickImage(imageSource: ImageSource.gallery, context: context) ?? '';

        if (path.isNotEmpty) {}
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
        }
      },
      context: context,
    );
  }
}

class DatePickerInputField extends StatelessWidget {
  const DatePickerInputField({
    super.key,
    required this.label,
    required this.hint,
    this.initialDate,
    required this.onPickedDate,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final String hint;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime date) onPickedDate;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: label,
      hintText: hint,
      readOnly: true,
      errorInputBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.transparent),
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
          firstDate: firstDate ?? DateTime.now(),
          onPickedDate: onPickedDate,
          onCancelClick: () {},
          selectedDate: initialDate ?? DateTime.now(),
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
        }
      },
      selectPhotoCallback: () async {
        String path = await ImagePickerUtils().pickImage(imageSource: ImageSource.gallery, context: context) ?? '';

        if (path.isNotEmpty) {}
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
        }
      },
      context: context,
    );
  }
}
