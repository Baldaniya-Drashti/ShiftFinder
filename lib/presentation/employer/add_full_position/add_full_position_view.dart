import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "AddFullPositionView")
class AddFullPositionView extends StatelessWidget {
  const AddFullPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddFullPositionBloc>()..add(AddFullPositionEvent.fetchLocationList(context: context)),
      child: Scaffold(
        appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "HealthCare"),
        body: BlocBuilder<AddFullPositionBloc, AddFullPositionState>(
          builder: (context, state) {
            if (state.loading) return CenterLoadingIndicator();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    PngImageConstants.healthcare_post_employer,
                  ),
                  Gap(16),
                  Expanded(
                    child: SingleChildScrollView(child: _PositionForm()),
                  )
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
  late TextEditingController _benefitController;
  late TextEditingController _compensationPackageController;

  @override
  void initState() {
    super.initState();
    _positionController = TextEditingController();
    _unionUnitController = TextEditingController();
    _benefitController = TextEditingController();
    _compensationPackageController = TextEditingController();
  }

  @override
  void dispose() {
    _positionController.dispose();
    _unionUnitController.dispose();
    _benefitController.dispose();
    _compensationPackageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          controller: _positionController,
          labelText: "Position",
          hintText: "Type Here...",
          maxLines: 4,
        ),
        Gap(12),
        BlocSelector<AddFullPositionBloc, AddFullPositionState, CommonDropdownModel>(
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
        Gap(16),
        BlocSelector<AddFullPositionBloc, AddFullPositionState, CommonDropdownModel>(
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
        Gap(12),
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
        Gap(12),
        CustomTextField(
          controller: _unionUnitController,
          labelText: "Union/Bargaining Unit",
          hintText: "Union/Bargaining Unit",
        ),
        Gap(12),
        _CompensationType()
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
  final CommonDropdownModel selectedJobType;

  @override
  Widget build(BuildContext context) {
    final List<CommonDropdownModel> list = [
      CommonDropdownModel(id: 1, label: "Full time"),
      CommonDropdownModel(id: 2, label: "Part time"),
    ];

    return CustomDropdownField<CommonDropdownModel>(
      label: "Job Type",
      onChanged: (value) => onChanged(value as CommonDropdownModel),
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
  final CommonDropdownModel selectedShiftSchedule;

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
      label: "Shift Schedule",
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
        BaseText(
          text: StringConstant.locationAddress,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        Gap(8),
        Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
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
  final TextEditingController _hourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffoldColor,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: "Select Type",
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            Gap(8),
            BlocSelector<AddFullPositionBloc, AddFullPositionState, int>(
              selector: (state) => state.selectedRadioOption,
              builder: (context, selectedRadioOption) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
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
                    Gap(8),
                    if (selectedRadioOption == 1) ...[
                      CustomTextField(
                        controller: _hourController,
                        hintText: "\$Rate/Hour",
                      ),
                    ] else ...[
                      _buildYearPicker(context)
                    ],
                  ],
                );
              },
            )
          ],
        ),
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
          overlayColor: WidgetStatePropertyAll<Color>(AppColors.backgroundRed),
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
        Expanded(child: BaseText(text: label, fontSize: 13, fontWeight: FontWeight.w600)),
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
      controller: _hourController,
      hintText: "Salary/Year",
    );
  }
}

class BulletTextEditingController extends TextEditingController {
  BulletTextEditingController() {
    addListener(_textListener);
  }

  final String bullet = '• ';

  void _textListener() {
    final lines = text.split('\n');

    final bulletText = lines.map((line) {
      if (line.isEmpty) return line; // Keep empty lines
      return line.startsWith(bullet) ? line : bullet + line;
    }).join('\n');

    // Update the text only if it has changed
    if (bulletText != text) {
      final previousPosition = selection;
      value = value.copyWith(
        text: bulletText,
        selection: previousPosition,
      );
    }
  }

  @override
  void dispose() {
    removeListener(_textListener);
    super.dispose();
  }
}
