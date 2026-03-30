part of 'google_map_bloc.dart';

@freezed
class GoogleMapEvent with _$GoogleMapEvent {
  const factory GoogleMapEvent.addMarker(double latitude, double longitude) =
      AddMarker;
}
