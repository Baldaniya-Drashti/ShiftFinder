part of 'full_time_position_bloc.dart';

@freezed
class FullTimePositionState with _$FullTimePositionState {
  const factory FullTimePositionState({
    @Default(1) int tabIndex,
    required List<LocationDTO> locationList,
    required List<UnitDTO> unitList,
    required InputEmptyOrNot location,
    required LocationDTO locationObj,
    required String selectedLocationUnit,
    required bool showLocationError,
  }) = _FullTimePositionState;

  factory FullTimePositionState.initial() => FullTimePositionState(
        showLocationError: false,
        location: InputEmptyOrNot(""),
        locationList: [],
        unitList: [],
        locationObj: LocationDTO(),
        selectedLocationUnit: "",
      );
}
