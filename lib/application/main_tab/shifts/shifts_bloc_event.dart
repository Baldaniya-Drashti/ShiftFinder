part of 'shifts_bloc_bloc.dart';

@freezed
class ShiftsBlocEvent with _$ShiftsBlocEvent {
  const factory ShiftsBlocEvent.started() = _Started;
  factory ShiftsBlocEvent.tabChange(int tabIndex) = ShiftsTabChange;
  const factory ShiftsBlocEvent.addressChanged(String address) = AddressChanged;

  const factory ShiftsBlocEvent.getPlaceDetail(String placeId) = GetPlaceDetail;
  const factory ShiftsBlocEvent.locationSelectedFromSearchList(
      Predictions selectedLocation) = _LocationSelectedFromSearchList;

  const factory ShiftsBlocEvent.locationIdChanged(String locationId) =
      LocationIdChanged;
  const factory ShiftsBlocEvent.getLocationListAPI() = GetLocationListAPI;
}
