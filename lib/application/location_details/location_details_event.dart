part of 'location_details_bloc.dart';

@freezed
class LocationDetailsEvent with _$LocationDetailsEvent {
  const factory LocationDetailsEvent.addressChanged(String address) =
      AddressChanged;

  const factory LocationDetailsEvent.getPlaceDetail(String placeId) =
      GetPlaceDetail;
  const factory LocationDetailsEvent.getFacilityTypeList() =
      GetFacilityTypeList;

  const factory LocationDetailsEvent.locationSelectedFromSearchList(
      Predictions selectedLocation) = _LocationSelectedFromSearchList;

  const factory LocationDetailsEvent.locationIdChanged(String locationId) =
      LocationIdChanged;

  const factory LocationDetailsEvent.accreditationNumberChanged(
      String accreditationNumber) = AccreditationNumberChanged;

  const factory LocationDetailsEvent.locationNoteChanged(String locationNote) =
      LocationNoteChanged;

  const factory LocationDetailsEvent.unitNumberChanged(String unitNumber) =
      UnitNumberChanged;

  const factory LocationDetailsEvent.addUnitNumberChipList(
      String unitNumber, String unitNote) = AddUnitNumberChipList;
  const factory LocationDetailsEvent.removeUnitNumberChip(int index) =
      RemoveUnitNumberChip;
  const factory LocationDetailsEvent.editUnitNumberChip(
          BuildContext context, int index, UnitDTO updatedUnit) =
      EditUnitNumberChip;

  const factory LocationDetailsEvent.notesChanged(String notes) = NotesChanged;
  const factory LocationDetailsEvent.facilityTypeChanged(String faciltyType) =
      FacilityTypeChanged;

  const factory LocationDetailsEvent.addOtherfaciltyType(String faciltyType) =
      AddOtherfaciltyType;
  const factory LocationDetailsEvent.continueBtnPressed(BuildContext context) =
      ContinueBtnPressed;

  const factory LocationDetailsEvent.updateUnitNumberChanged(
      String unitNumber) = UpdateUnitNumberChanged;
  const factory LocationDetailsEvent.updateUnitNotesChanged(String notes) =
      UpdateUnitNotesChanged;

  const factory LocationDetailsEvent.getLocationBrandList() =
      GetLocationBrandList;

  const factory LocationDetailsEvent.locationBrandChanged(
      String locationBrand) = LocationBrandChanged;

  const factory LocationDetailsEvent.addOtherLocationBrand(
      String locationBrand) = AddOtherLocationBrand;
}
