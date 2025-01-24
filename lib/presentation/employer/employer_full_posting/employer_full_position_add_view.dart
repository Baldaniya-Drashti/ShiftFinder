import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/full_time_position/full_time_position_bloc.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
import 'package:shift/application/employer/employer_long_term_position_add_detail/employer_long_term_position_add_detail_bloc.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_chip_display.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_item.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_selectable_dropdown.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/core/widgets/time_picker_input_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@RoutePage(name: "EmployerFullPositionAddView")
class EmployerFullPositionAddView extends StatelessWidget {
  const EmployerFullPositionAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddFullPositionBloc>()..add(AddFullPositionEvent.fetchLocationList(context: context)),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "HealthCare"),
          body: BlocBuilder<AddFullPositionBloc, AddFullPositionState>(
            builder: (context, state) {
              if (state.loading) return CenterLoadingIndicator();
              return SingleChildScrollView(
                padding: EdgeInsets.all(getSize(16)),
                child: Column(
                  children: [
                    Image.asset(PngImageConstants.fullPosition),
                    Gap(getSize(24)),
                    _PositionForm(),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

class _PositionForm extends StatefulWidget {
  const _PositionForm();

  @override
  State<_PositionForm> createState() => _PositionFormState();
}

class _PositionFormState extends State<_PositionForm> {
  late TextEditingController _positionController;
  late TextEditingController _unionUnitController;
  final TextEditingController _rateAndSalaryController = TextEditingController();
  late BulletTextEditingController _benefitController;
  late BulletTextEditingController _compensationController;
  late BulletTextEditingController _jobSummaryController;
  late BulletTextEditingController _keyResponsibilityController;
  late BulletTextEditingController _externalInternalRelationshipController;
  late BulletTextEditingController _qualificationController;
  late BulletTextEditingController _experienceController;
  late BulletTextEditingController _licenseController;
  late BulletTextEditingController _skillController;
  late BulletTextEditingController _otherController;

  @override
  void initState() {
    super.initState();
    _positionController = TextEditingController();
    _unionUnitController = TextEditingController();
    _benefitController = BulletTextEditingController();
    _compensationController = BulletTextEditingController();
    _jobSummaryController = BulletTextEditingController();
    _keyResponsibilityController = BulletTextEditingController();
    _externalInternalRelationshipController = BulletTextEditingController();
    _qualificationController = BulletTextEditingController();
    _experienceController = BulletTextEditingController();
    _licenseController = BulletTextEditingController();
    _skillController = BulletTextEditingController();
    _otherController = BulletTextEditingController();
  }

  @override
  void dispose() {
    _benefitController.dispose();
    _compensationController.dispose();
    _jobSummaryController.dispose();
    _keyResponsibilityController.dispose();
    _externalInternalRelationshipController.dispose();
    _qualificationController.dispose();
    _experienceController.dispose();
    _licenseController.dispose();
    _skillController.dispose();
    _otherController.dispose();
    _positionController.dispose();
    _unionUnitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<AddFullPositionBloc, AddFullPositionState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: _positionController,
                labelText: "Position",
                hintText: "Type Here... ",
                maxLines: 4,
                textInputAction: TextInputAction.next,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value, context) {
                  value = value?.trim() ?? "";
                  if (value.isEmpty) return "Please Enter Position";
                  return null;
                },
              ),
              Gap(getSize(18)),
              BlocSelector<AddFullPositionBloc, AddFullPositionState, CommonDropdownModel?>(
                selector: (state) => state.selectedJobType,
                builder: (context, selectedJobType) {
                  return _JobTypeDropdownField(
                    selectedJobType: selectedJobType,
                    onChanged: (value) {
                      context.read<AddFullPositionBloc>().add(AddFullPositionEvent.onJobTypeChanged(value));
                    },
                  );
                },
              ),
              Gap(getSize(18)),
              BlocSelector<AddFullPositionBloc, AddFullPositionState, ListInputEmptyOrNot>(
                selector: (state) => state.requiredShiftScheduleChipList,
                builder: (context, shiftSchedule) {
                  return _ShiftSchedule(initialValue: shiftSchedule.getValue());
                },
              ),
              Gap(getSize(12)),
              locationDropDown(context, state),
              Gap(getSize(18)),
              CustomTextField(
                controller: _unionUnitController,
                labelText: "Union/Bargaining Unit",
                hintText: "Union/Bargaining Unit",
                textInputAction: TextInputAction.next,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                validator: (value, context) {
                  value = value?.trim() ?? "";
                  if (value.isEmpty) return "Please Enter Union/Bargaining Unit";
                  return null;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Gap(getSize(18)),
              BlocSelector<AddFullPositionBloc, AddFullPositionState, TimeOfDay?>(
                selector: (state) => state.employerLongTermDto.estimated_weekly_hours,
                builder: (context, selectedEstimatedHours) {
                  return TimePickerInputField(
                    initialTime: selectedEstimatedHours,
                    label: "Estimated Weekly Hours",
                    hint: "00h 00min",
                    onPickedTime: (time) {
                      context.read<AddFullPositionBloc>().add(
                            AddFullPositionEvent.selectEstimatedHour(estimatedHour: time),
                          );
                    },
                  );
                },
              ),
              Gap(getSize(18)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: getSize(16)),
                    child: BaseText(text: "Compensation Type", fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Gap(12),
                  Material(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(getSize(20)),
                    child: Padding(
                      padding: EdgeInsets.all(getSize(18)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            text: "Select Type",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          Gap(getSize(8)),
                          BlocSelector<AddFullPositionBloc, AddFullPositionState, int>(
                            selector: (state) => state.selectedRadioOption,
                            builder: (context, selectedRadioOption) {
                              final label = selectedRadioOption == 1 ? "Rate/Hour" : "Salary/Year";

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Material(
                                    borderRadius: BorderRadius.circular(getSize(10)),
                                    color: AppColors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: getSize(16), horizontal: getSize(22)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _buildRadioOptions(
                                            context,
                                            onChanged: (value) {
                                              context.read<AddFullPositionBloc>().add(
                                                    AddFullPositionEvent.onCompensationTypeChanged(type: value),
                                                  );
                                            },
                                            label: "Rate/Hour",
                                            groupValue: selectedRadioOption,
                                            value: 1,
                                          ),
                                          Divider(),
                                          _buildRadioOptions(
                                            context,
                                            onChanged: (value) {
                                              context.read<AddFullPositionBloc>().add(
                                                    AddFullPositionEvent.onCompensationTypeChanged(type: value),
                                                  );
                                            },
                                            label: "Salary/Year",
                                            groupValue: selectedRadioOption,
                                            value: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Gap(getSize(8)),
                                  CustomTextField(
                                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                                    inputFormatters: [
                                      if (selectedRadioOption == 1) FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                    ],
                                    controller: _rateAndSalaryController,
                                    autoValidateMode: AutovalidateMode.onUserInteraction,
                                    hintText: selectedRadioOption == 1 ? "\$$label" : "\$$label",
                                    validator: (value, context) {
                                      value = value?.trim() ?? "";
                                      if (value.isEmpty) {
                                        return "Please enter $label";
                                      }
                                      final parsedValue = double.tryParse(value);
                                      if (parsedValue == null) {
                                        return "Please enter a valid number";
                                      }
                                      if (parsedValue <= 0) {
                                        return "The $label should not be 0 or negative";
                                      }

                                      return null;
                                    },
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(getSize(18)),
              _BulletTextField(
                controller: _benefitController,
                label: "Benefits Provided",
              ),
              Gap(getSize(16)),
              _BulletTextField(
                controller: _compensationController,
                label: "Compensation Package",
              ),
              Gap(getSize(16)),
              _BulletTextField(
                controller: _jobSummaryController,
                label: "Job Summary",
                optional: false,
                validator: (value) {
                  value = value?.trim() ?? "";
                  if (value.isEmpty) {
                    return "Please enter job summary";
                  }
                  return null;
                },
              ),
              Gap(getSize(16)),
              _BulletTextField(
                controller: _keyResponsibilityController,
                label: "Key Responsibilities",
                optional: false,
                validator: (value) {
                  value = value?.trim() ?? "";
                  if (value.isEmpty) {
                    return "Please enter key responsibilities";
                  }
                  return null;
                },
              ),
              Gap(getSize(16)),
              _BulletTextField(
                controller: _externalInternalRelationshipController,
                label: "External and Internal Relationships",
              ),
              Gap(getSize(16)),
              _BulletTextField(
                controller: _qualificationController,
                label: "Required Qualifications",
                optional: false,
                validator: (value) {
                  value = value?.trim() ?? "";
                  if (value.isEmpty) {
                    return "Please enter required qualifications";
                  }
                  return null;
                },
              ),
              Gap(getSize(16)),
              _BulletTextField(
                controller: _experienceController,
                label: "Required Experience",
                optional: false,
                validator: (value) {
                  value = value?.trim() ?? "";
                  if (value.isEmpty) {
                    return "Please enter required experience";
                  }
                  return null;
                },
              ),
              Gap(getSize(16)),
              _BulletTextField(
                controller: _licenseController,
                label: "Required Licenses/Certifications",
                optional: false,
                validator: (value) {
                  value = value?.trim() ?? "";
                  if (value.isEmpty) {
                    return "Please enter required licenses/certifications";
                  }
                  return null;
                },
              ),
              Gap(getSize(16)),
              _BulletTextField(
                controller: _skillController,
                label: "Required Skills",
                optional: false,
                validator: (value) {
                  value = value?.trim() ?? "";
                  if (value.isEmpty) {
                    return "Please enter required skills";
                  }
                  return null;
                },
              ),
              Gap(getSize(16)),
              _BulletTextField(
                controller: _otherController,
                label: "Other",
              ),
              Gap(getSize(28)),
              CommonButton(
                onPressed: () {
                  final list = context.read<AddFullPositionBloc>().state.requiredShiftScheduleChipList.getValue();
                  if (_formKey.currentState?.validate() != true || list.isEmpty) {
                    showError(message: StringConstant.someDetailsAreMissingOrInvalidPleaseCheck).show(context);
                    return;
                  }
                  context.read<AddFullPositionBloc>().add(
                        AddFullPositionEvent.onContinue(
                          context: context,
                          unionBargainUnit: _unionUnitController.text.trim(),
                          salaryOrRateHour: _rateAndSalaryController.text.trim(),
                          benefits: _benefitController.toCommaSeparatedString,
                          compensationPackage: _compensationController.toCommaSeparatedString,
                          jobSummary: _jobSummaryController.toCommaSeparatedString,
                          keyResponsibility: _keyResponsibilityController.toCommaSeparatedString,
                          externalInternalRelationship: _externalInternalRelationshipController.toCommaSeparatedString,
                          requiredQualification: _qualificationController.toCommaSeparatedString,
                          requiredExperience: _experienceController.toCommaSeparatedString,
                          licenseCertification: _licenseController.toCommaSeparatedString,
                          requiredSkill: _skillController.toCommaSeparatedString,
                          others: _otherController.toCommaSeparatedString,
                          position: _positionController.text.trim(),
                        ),
                      );
                },
                buttonText: "Continue",
              ),

            ],
          );
        },
      ),
    );
  }

  Widget _buildRadioOptions(
    BuildContext context, {
    required void Function(int value) onChanged,
    required String label,
    required int groupValue,
    required int value,
  }) {
    return Row(
      children: [
        Radio(
          fillColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) return AppColors.green;
              return Colors.grey;
            },
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            if (value == null) return;
            onChanged(value);
          },
        ),
        Gap(8),
        Expanded(child: BaseText(text: label, fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget locationDropDown(BuildContext context, AddFullPositionState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomLocationDropdDown(
          labelText: StringConstant.location,
          isLabelPadding: true,
          showTextfield: false,
          isOptional: true,
          value: (state.location.isValid()) ? state.location.getValue() : null,
          optionalWidget: GestureDetector(
            onTap: () {
              AppDialog.showInfo(
                context,
                StringConstant.missingLocationInfoDesc,
                maxLines: 5,
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
              state.location.value.fold(
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
              context.read<AddFullPositionBloc>().add(
                    AddFullPositionEvent.locationChanged(value.toString()),
                  );
            }
          },
          hintText: StringConstant.location,
          childDroDwonHintText: StringConstant.selectUnitIfAny,
          childDropDownValue: (state.selectedLocationUnit.isNotEmpty) ? state.selectedLocationUnit : null,
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
              context.read<AddFullPositionBloc>().add(
                    AddFullPositionEvent.locationUnitSelectionChanged(value),
                  );
            }
          },
        ),
        if (state.location.isValid() && state.unitList.isNotEmpty && state.showLocationError && state.selectedLocationUnit.isEmpty)
          commonErrorText(StringConstant.pleaseSelectLocationUnit),
      ],
    );
  }
}

class _JobTypeDropdownField extends StatelessWidget {
  const _JobTypeDropdownField({
    required this.onChanged,
    required this.selectedJobType,
  });

  final Function(CommonDropdownModel value) onChanged;
  final CommonDropdownModel? selectedJobType;

  @override
  Widget build(BuildContext context) {
    final List<CommonDropdownModel> list = [
      CommonDropdownModel(id: 1, label: "Full time"),
      CommonDropdownModel(id: 2, label: "Part time"),
    ];

    return CustomDropdownField<CommonDropdownModel>(
      fontSize: 14,
      label: "Job Type",
      hintText: "Job Type",
      validator: (value) {
        if (value == null) {
          return "Please enter required skills";
        }
        return null;
      },
      onChanged: (value) => onChanged(value as CommonDropdownModel),
      hintTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black.withOpacity(0.5),
      ),
      value: selectedJobType,
      items: list.map(
        (e) {
          return DropdownMenuItem<CommonDropdownModel>(
            value: e,
            child: BaseText(text: e.label, fontSize: 14, fontWeight: FontWeight.w500),
          );
        },
      ).toList(),
    );
  }
}

class _BulletTextField extends StatelessWidget {
  const _BulletTextField({
    required this.controller,
    required this.label,
    this.optional = true,
    this.validator,
  });

  final BulletTextEditingController controller;
  final String label;
  final bool optional;
  final FormFieldValidator<String?>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BaseText(text: label, fontSize: 13, fontWeight: FontWeight.w500),
                  if (optional) ...[
                    Gap(6),
                    Flexible(
                      child: BaseText(text: "(Optional)", fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ]
                ],
              ),
              Gap(2),
              BaseText(text: "You can add multiple points", fontSize: 10, fontWeight: FontWeight.w500)
            ],
          ),
        ),
        Gap(8),
        CustomTextField(
          minLines: 1,
          maxLines: 7,
          controller: controller,
          hintText: "• Type Here",
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: validator != null
              ? (value, context) {
                  return validator!(value);
                }
              : null,
        ),
      ],
    );
  }
}

class BulletTextEditingController extends TextEditingController {
  BulletTextEditingController({List<String>? initialItems}) {
    if (initialItems != null) {
      text = initialItems.map((item) => '$bullet$item').join('\n');
    }
    addListener(_handleTextChange);
  }

  final String bullet = '• ';
  bool _isProcessing = false;
  String _previousText = '';

  void _handleTextChange() {
    if (_isProcessing) return;

    _isProcessing = true;

    final currentText = text;
    final cursorPosition = selection.baseOffset;
    final isBackspace = currentText.length < _previousText.length;

    // Split text into lines and handle bullets
    final lines = currentText.split('\n');
    final buffer = StringBuffer();
    int newCursorPosition = cursorPosition;

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      bool isLastLine = i == lines.length - 1;

      // Handle backspace on an empty bullet line
      if (isBackspace && line == bullet && cursorPosition <= buffer.length + bullet.length) {
        // Skip adding this line, effectively deleting it
        newCursorPosition -= bullet.length;
        continue;
      }

      // Add bullet if line has text and doesn’t already start with it
      if (line.isNotEmpty && !line.startsWith(bullet)) {
        line = '$bullet$line';
        // Adjust cursor if we’re on the line where the bullet was added
        if (cursorPosition > buffer.length && cursorPosition <= buffer.length + line.length) {
          newCursorPosition += bullet.length;
        }
      }

      buffer.write(line);

      // Add newline if not the last line
      if (!isLastLine) buffer.write('\n');
    }

    final formattedText = buffer.toString();

    // Update text and cursor only if the formatted text differs
    if (formattedText != currentText) {
      text = formattedText;
      selection = TextSelection.collapsed(offset: newCursorPosition);
    }

    _previousText = text;
    _isProcessing = false;
  }

  List<String> getBulletContent() {
    return text.split('\n').map((line) => line.startsWith(bullet) ? line.substring(bullet.length) : line).toList();
  }

  String get toCommaSeparatedString {
    return getBulletContent().join(",").trim();
  }

  @override
  void dispose() {
    removeListener(_handleTextChange);
    super.dispose();
  }
}

class _ShiftSchedule extends StatelessWidget {
  const _ShiftSchedule({super.key, required this.initialValue});

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
              context.read<AddFullPositionBloc>().add(AddFullPositionEvent.removeShiftSchedule(value.toString()));
            },
          ),
          buttonIcon: SvgPicture.asset(SvgImageConstant.downArrow),
          buttonText: Text(
            "Shift Schedule",
            style: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.50)),
          ),
          onConfirm: (selectedList, otherValues) {
            context.read<AddFullPositionBloc>().add(AddFullPositionEvent.confirmShiftSchedule(
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
