import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shift/application/google_map/google_map_bloc.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ShowGoogleMap')
class ShowGoogleMap extends StatelessWidget {
  final double latitude;
  final double longitude;

  const ShowGoogleMap(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> controller =
        Completer<GoogleMapController>();
    return BlocProvider(
      create: (context) => getIt<GoogleMapBloc>()
        ..add(GoogleMapEvent.addMarker(latitude, longitude)),
      child: BlocBuilder<GoogleMapBloc, GoogleMapState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              title: 'Google Map',
              onBackPressed: () {
                context.router.maybePop();
              },
            ),
            body: state.isMapCreated == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GoogleMap(
                    //  mapType: MapType.hybrid,
                    initialCameraPosition: state.initialCameraPosition!,
                    markers: {
                      Marker(
                        markerId: MarkerId('1'),
                        position: LatLng(latitude, longitude),
                      ),
                    },
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController c) {
                      controller.complete(c);
                    },
                  ),
          );
        },
      ),
    );
  }
}
