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
  }) = _AddFullPositionState;
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
