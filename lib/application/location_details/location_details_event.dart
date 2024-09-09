part of 'location_details_bloc.dart';

@freezed
class LocationDetailsEvent with _$LocationDetailsEvent {
  const factory LocationDetailsEvent.addressChanged(String address) =
      AddressChanged;
  const factory LocationDetailsEvent.getFacilityTypeList() =
      GetFacilityTypeList;

  const factory LocationDetailsEvent.locationSelectedFromSearchList(
      String selectedLocation) = _LocationSelectedFromSearchList;

  const factory LocationDetailsEvent.locationIdChanged(String locationId) =
      LocationIdChanged;

  const factory LocationDetailsEvent.accreditationNumberChanged(
      String accreditationNumber) = AccreditationNumberChanged;

  const factory LocationDetailsEvent.locationNoteChanged(String locationNote) =
      LocationNoteChanged;

  const factory LocationDetailsEvent.unitNumberChanged(String unitNumber) =
      UnitNumberChanged;

  const factory LocationDetailsEvent.addUnitNumberChipList(String unitNumber,String unitNote) =
      AddUnitNumberChipList;
  const factory LocationDetailsEvent.removeUnitNumberChip(int index) =
      RemoveUnitNumberChip;

  const factory LocationDetailsEvent.notesChanged(String notes) = NotesChanged;
  const factory LocationDetailsEvent.facilityTypeChanged(String faciltyType) =
      FacilityTypeChanged;

  const factory LocationDetailsEvent.addOtherfaciltyType(String faciltyType) =
      AddOtherfaciltyType;
  const factory LocationDetailsEvent.continueBtnPressed() = ContinueBtnPressed;
}
