import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
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
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@RoutePage(name: "EmployerFullPositionAddView")
class EmployerFullPositionAddView extends StatelessWidget {
  const EmployerFullPositionAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddFullPositionBloc>()..add(AddFullPositionEvent.fetchLocationList(context: context)),
      child: Scaffold(
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
      ),
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

  @override
  void initState() {
    super.initState();
    _positionController = TextEditingController();
    _unionUnitController = TextEditingController();
  }

  @override
  void dispose() {
    _positionController.dispose();
    _unionUnitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: _positionController,
            labelText: "Position",
            hintText: "Type Here...",
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
          BlocSelector<AddFullPositionBloc, AddFullPositionState, CommonDropdownModel?>(
            selector: (state) => state.selectedShiftSchedule,
            builder: (context, selectedShiftSchedule) {
              return _ShiftScheduleDropdownField(
                selectedShiftSchedule: selectedShiftSchedule,
                onChanged: (value) {
                  context.read<AddFullPositionBloc>().add(AddFullPositionEvent.onShiftScheduleChanged(value));
                },
              );
            },
          ),
          Gap(getSize(18)),
          BlocSelector<AddFullPositionBloc, AddFullPositionState, LocationDTO?>(
            selector: (state) => state.selectedLocation,
            builder: (context, selectedLocation) {
              return _LocationDropdown(
                initialLocation: selectedLocation,
                list: context.read<AddFullPositionBloc>().state.locationList,
                onLocationChanged: (location) {
                  context.read<AddFullPositionBloc>().add(
                        AddFullPositionEvent.onLocationChanged(selectedLocation: location),
                      );
                },
              );
            },
          ),
          Gap(getSize(18)),
          CustomTextField(
            controller: _unionUnitController,
            labelText: "Union/Bargaining Unit",
            hintText: "Union/Bargaining Unit",
            textInputAction: TextInputAction.next,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: (value, context) {
              value = value?.trim() ?? "";
              if (value.isEmpty) return "Please Enter Union/Bargaining Unit";
              return null;
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          Gap(getSize(18)),
          BlocSelector<AddFullPositionBloc, AddFullPositionState, TimeOfDay?>(
            selector: (state) => state.selectedEstimatedHours,
            builder: (context, selectedEstimatedHours) {
              return CustomTextField(
                controller: TextEditingController(text: selectedEstimatedHours?.format(context)),
                labelText: "Estimated Weekly Hours",
                hintText: "00h 00min",
                readOnly: true,
                onTap: () async {
                  final result = await showTimePicker(
                    context: context,
                    initialTime: selectedEstimatedHours ?? TimeOfDay.now(),
                  );
                  if (result != null) {
                    context.read<AddFullPositionBloc>().add(
                          AddFullPositionEvent.onEstimatedDateChanged(value: result),
                        );
                  }
                },
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(14),
                    vertical: getSize(14),
                  ),
                  child: SvgPicture.asset(
                    SvgImageConstant.clock,
                    height: getSize(24),
                    width: getSize(24),
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            },
          ),
          Gap(getSize(18)),
          _CompensationType(),
          Gap(getSize(18)),
          _BulletListView()
        ],
      ),
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

class _ShiftScheduleDropdownField extends StatelessWidget {
  const _ShiftScheduleDropdownField({
    required this.onChanged,
    required this.selectedShiftSchedule,
  });

  final Function(CommonDropdownModel value) onChanged;
  final CommonDropdownModel? selectedShiftSchedule;

  @override
  Widget build(BuildContext context) {
    final List<CommonDropdownModel> list = [
      CommonDropdownModel(id: 1, label: "Morning"),
      CommonDropdownModel(id: 2, label: "Evening"),
      CommonDropdownModel(id: 3, label: "Night"),
      CommonDropdownModel(id: 4, label: "Weekends"),
      CommonDropdownModel(id: 5, label: "Weekdays"),
    ];

    return CustomDropdownField<CommonDropdownModel>(
      hintText: "Shift Schedule",
      fontSize: 13,
      label: "Shift Schedule",
      hintTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black.withOpacity(0.5),
      ),
      onChanged: (value) => onChanged(value as CommonDropdownModel),
      value: selectedShiftSchedule,
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

class _LocationDropdown extends StatelessWidget {
  const _LocationDropdown({
    this.initialLocation,
    required this.onLocationChanged,
    required this.list,
  });

  final LocationDTO? initialLocation;
  final void Function(LocationDTO locationId) onLocationChanged;
  final List<LocationDTO> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(16)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(
                text: "Location",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              // SvgPicture.asset(SvgImageConstant.i)
            ],
          ),
        ),
        Gap(getSize(8)),
        Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(getSize(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomDropdownField<LocationDTO>(
                hintText: StringConstant.locationAddress,
                value: initialLocation,
                radius: 10,
                hintTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.5),
                ),
                items: list.map(
                  (e) {
                    return DropdownMenuItem<LocationDTO>(
                      value: e,
                      child: BaseText(text: e.location ?? "", fontSize: 14, maxLines: 1),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  final location = value as LocationDTO?;
                  if (location != null) onLocationChanged(location);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompensationType extends StatefulWidget {
  const _CompensationType();

  @override
  State<_CompensationType> createState() => _CompensationTypeState();
}

class _CompensationTypeState extends State<_CompensationType> {
  final TextEditingController _rateAndSalaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          controller: _rateAndSalaryController,
                          hintText: selectedRadioOption == 1 ? "\$$label" : "\$$label",
                          validator: (value, context) {
                            value = value?.trim() ?? "";
                            if (value.isEmpty) {
                              return "Please enter $label";
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

  Widget _buildYearPicker(BuildContext context) {
    return CustomTextField(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: BaseText(text: "Select Year")),
              backgroundColor: AppColors.white,
              content: SizedBox(
                height: 300,
                width: 300,
                child: YearPicker(
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2050),
                  selectedDate: DateTime(2001),
                  onChanged: (value) {},
                ),
              ),
            );
          },
        );
      },
      readOnly: true,
      controller: _rateAndSalaryController,
      hintText: "Salary/Year",
    );
  }
}

class _BulletListView extends StatefulWidget {
  const _BulletListView();

  @override
  State<_BulletListView> createState() => _BulletListViewState();
}

class _BulletListViewState extends State<_BulletListView> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<AddFullPositionBloc>().state;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
            // if (state.selectedShiftSchedule == null) {
            //   showError(message: "Please select shift schedule").show(context);
            //   return;
            // }
            //
            // if (state.selectedJobType == null) {
            //   showError(message: "Please select job type").show(context);
            //   return;
            // }
            //
            // if (state.selectedLocation == null) {
            //   showError(message: "Please select location").show(context);
            //   return;
            // }
            //
            // if (_formKey.currentState?.validate() != true) return;

            context.router.navigate(PageRouteInfo(EmployerFullPostingConfirmView.name));
          },
          buttonText: "Continue",
        )
      ],
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
          padding:  EdgeInsets.only(left: getSize(20)),
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

  @override
  void dispose() {
    removeListener(_handleTextChange);
    super.dispose();
  }
}
