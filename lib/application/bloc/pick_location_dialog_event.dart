part of 'pick_location_dialog_bloc.dart';

@freezed
class PickLocationDialogEvent with _$PickLocationDialogEvent {
  const factory PickLocationDialogEvent.getLocationAddress(String location) =
      GetLocationAddress;

  const factory PickLocationDialogEvent.locationAddressChanged(
      String location) = LocationAddressChanged;

  const factory PickLocationDialogEvent.locationSelectedFromSearchList(
      Predictions selectedLocation,
      {bool? isFromStarting,
      String? locationName}) = _LocationSelectedFromSearchList;
}
