part of 'add_full_position_bloc.dart';

@freezed
class AddFullPositionState with _$AddFullPositionState {
  const factory AddFullPositionState({
    @Default(CommonDropdownModel(id: 1, label: "Full time")) final CommonDropdownModel selectedJobType,
    @Default(CommonDropdownModel(id: 1, label: "Morning")) final CommonDropdownModel selectedShiftSchedule,
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
