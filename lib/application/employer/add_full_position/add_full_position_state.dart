part of 'add_full_position_bloc.dart';

@freezed
class AddFullPositionState with _$AddFullPositionState {
  const factory AddFullPositionState({
    final CommonDropdownModel? selectedJobType,
    final CommonDropdownModel? selectedShiftSchedule,
    final TimeOfDay? selectedEstimatedHours,
    @Default([]) final List<LocationDTO> locationList,
    @Default(false) final bool loading,
    @Default(false) final bool postDataLoading,
    @Default(1) final int selectedRadioOption,
    final LocationDTO? selectedLocation,
    @Default(EmployerLongTermSuccessDto()) EmployerLongTermSuccessDto employerLongTermDto,
    required ListInputEmptyOrNot requiredShiftScheduleChipList,
    required List<UnitDTO> unitList,
    required InputEmptyOrNot location,
    required LocationDTO locationObj,
    required String selectedLocationUnit,
    required bool showLocationError,
  }) = _AddFullPositionState;

  factory AddFullPositionState.initial() => AddFullPositionState(
        requiredShiftScheduleChipList: ListInputEmptyOrNot(["Morning"]),
        showLocationError: false,
        location: InputEmptyOrNot(""),
        unitList: [],
        locationObj: LocationDTO(),
        selectedLocationUnit: "",
      );
}

class CommonDropdownModel extends Equatable {
  const CommonDropdownModel({
    required this.id,
    required this.label,
  });

  final int id;
  final String label;

  @override
  List<Object?> get props => [id, label];
}
