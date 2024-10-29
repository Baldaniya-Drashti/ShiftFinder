part of 'employer_location_form_bloc.dart';

@freezed
class EmployerLocationFormEvent with _$EmployerLocationFormEvent {
  const factory EmployerLocationFormEvent.addressChanged(String address) = AddressChanged;

  const factory EmployerLocationFormEvent.getPlaceDetail(String placeId) = GetPlaceDetail;

  const factory EmployerLocationFormEvent.getFacilityTypeList() = GetFacilityTypeList;

  const factory EmployerLocationFormEvent.locationSelectedFromSearchList(Predictions selectedLocation) = _LocationSelectedFromSearchList;

  const factory EmployerLocationFormEvent.locationIdChanged(String locationId) = LocationIdChanged;

  const factory EmployerLocationFormEvent.accreditationNumberChanged(String accreditationNumber) = AccreditationNumberChanged;

  const factory EmployerLocationFormEvent.locationNoteChanged(String locationNote) = LocationNoteChanged;

  const factory EmployerLocationFormEvent.unitNumberChanged(String unitNumber) = UnitNumberChanged;

  const factory EmployerLocationFormEvent.addUnitNumberChipList(String unitNumber, String unitNote) = AddUnitNumberChipList;

  const factory EmployerLocationFormEvent.removeUnitNumberChip(int index) = RemoveUnitNumberChip;

  const factory EmployerLocationFormEvent.editUnitNumberChip(BuildContext context, int index, UnitDTO updatedUnit) = EditUnitNumberChip;

  const factory EmployerLocationFormEvent.notesChanged(String notes) = NotesChanged;

  const factory EmployerLocationFormEvent.facilityTypeChanged(String faciltyType) = FacilityTypeChanged;

  const factory EmployerLocationFormEvent.addOtherfaciltyType(String faciltyType) = AddOtherfaciltyType;

  const factory EmployerLocationFormEvent.continueBtnPressed(BuildContext context) = ContinueBtnPressed;

  const factory EmployerLocationFormEvent.updateUnitNumberChanged(String unitNumber) = UpdateUnitNumberChanged;

  const factory EmployerLocationFormEvent.updateUnitNotesChanged(String notes) = UpdateUnitNotesChanged;
  const factory EmployerLocationFormEvent.getLocationInfo({required int id,required BuildContext context}) = GetLocationInfo;
}
