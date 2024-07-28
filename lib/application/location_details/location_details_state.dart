part of 'location_details_bloc.dart';

@freezed
class LocationDetailsState with _$LocationDetailsState {
  const factory LocationDetailsState({
    required InputEmptyOrNot address,
    required List<dynamic> searchLocationList,
    required InputEmptyOrNot faciltyType,
    required InputEmptyOrNot otherFaciltyType,
    required String locationId,
    required String accreditationNumber,
    required String locationNote,
    required String unitNumber,
    required String notes,
    required String faciltyTypeDDValue,
    required String otherFaciltyTypeValue,
    required List<String> unitNoNameChipList,
    required bool isSubmitting,
    required bool showErrorMessages,
    required Option<Either<AccountFailure, Account>> authFailureOrSuccessOption,
  }) = _LocationDetailsState;
  factory LocationDetailsState.initial() => LocationDetailsState(
        address: InputEmptyOrNot(""),
        searchLocationList: [],
        faciltyType: InputEmptyOrNot(""),
        otherFaciltyType: InputEmptyOrNot(""),
        locationId: "",
        accreditationNumber: "",
        locationNote: "",
        unitNumber: "",
        notes: "",
        faciltyTypeDDValue: "",
        otherFaciltyTypeValue: "",
        unitNoNameChipList: [],
        isSubmitting: false,
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),
      );
}
