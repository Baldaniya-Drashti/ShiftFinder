part of 'pick_location_dialog_bloc.dart';

@freezed
class PickLocationDialogState with _$PickLocationDialogState {
  const factory PickLocationDialogState({
    required List<Predictions> searchLocationList,
    required InputEmptyOrNot locationAddress,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
    required PlaceDetailDTO selectedAddress,
    required Predictions selectedLocationPrediction,
  }) = _PickLocationDialogState;

  factory PickLocationDialogState.initial() => PickLocationDialogState(
        authFailureOrSuccessOption: none(),
        locationAddress: InputEmptyOrNot(""),
        searchLocationList: [],
        selectedAddress: PlaceDetailDTO(),
        selectedLocationPrediction: Predictions(),
      );
}
