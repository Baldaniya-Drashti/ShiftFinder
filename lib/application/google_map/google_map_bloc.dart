import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

part 'google_map_state.dart';
part 'google_map_event.dart';
part 'google_map_bloc.freezed.dart';

@injectable
class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc() : super(GoogleMapState.initial()) {
    on<GoogleMapEvent>((event, emit) async {
      await event.map(
        addMarker: (e) async {
          //        const CameraPosition _kLake = CameraPosition(
          // bearing: 192.8334901395799,
          // target: LatLng(37.43296265331129, -122.08832357078792),
          // tilt: 59.440717697143555,
          // zoom: 19.151926040649414);
          emit(
            state.copyWith(
              latitude: e.latitude,
              longitude: e.longitude,
              initialCameraPosition: CameraPosition(
                target: LatLng(e.latitude, e.longitude),
                zoom: 17,
              ),
              isMapCreated: true,
            ),
          );
        },
      );
    });
  }
}
