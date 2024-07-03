part of 'location_details_bloc.dart';

@freezed
class LocationDetailsState with _$LocationDetailsState {
  const factory LocationDetailsState({
    required InputEmptyOrNot address,
    required InputEmptyOrNot faciltyType,
    required InputEmptyOrNot otherFaciltyType,
    required String locationId,
    required String accreditationNumber,
    required String locationNote,
    required String unitNumber,
    required String notes,
    required String faciltyTypeDDValue,
    required String otherFaciltyTypeValue,
    required bool isSubmitting,
    required bool showErrorMessages,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _LocationDetailsState;
  factory LocationDetailsState.initial() => LocationDetailsState(
        address: InputEmptyOrNot(""),
        faciltyType: InputEmptyOrNot(""),
        otherFaciltyType: InputEmptyOrNot(""),
        locationId: "",
        accreditationNumber: "",
        locationNote: "",
        unitNumber: "",
        notes: "",
        faciltyTypeDDValue: "",
        otherFaciltyTypeValue: "",
        isSubmitting: false,
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),
      );
}
