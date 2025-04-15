part of 'google_map_bloc.dart';

@freezed
class GoogleMapState with _$GoogleMapState {
  const factory GoogleMapState({
    double? latitude,
    double? longitude,
    required bool isMapCreated,
    CameraPosition? initialCameraPosition,
  }) = _CardState;

  factory GoogleMapState.initial() => GoogleMapState(
        isMapCreated: false,
      );
}
