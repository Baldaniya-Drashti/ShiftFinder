part of 'add_full_position_bloc.dart';

@freezed
class AddFullPositionEvent with _$AddFullPositionEvent {
  const factory AddFullPositionEvent.onCreate(BuildContext context) = onCreate;
  const factory AddFullPositionEvent.fetchLocationList({required BuildContext context}) = FetchLocationList;
  const factory AddFullPositionEvent.onJobTypeChanged(CommonDropdownModel value) = OnJobTypeChanged;
  const factory AddFullPositionEvent.onShiftScheduleChanged(CommonDropdownModel value) = OnShiftScheduleChanged;
  const factory AddFullPositionEvent.onLocationChanged({required LocationDTO selectedLocation}) = OnLocationChanged;
  const factory AddFullPositionEvent.onCompensationTypeChanged({required int type}) = OnCompensationTypeChanged;
  const factory AddFullPositionEvent.onEstimatedDateChanged({required TimeOfDay value}) = OnEstimatedDateChanged;

}
