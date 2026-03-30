import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
part 'pick_location_dialog_event.dart';
part 'pick_location_dialog_state.dart';
part 'pick_location_dialog_bloc.freezed.dart';

@injectable
class PickLocationDialogBloc
    extends Bloc<PickLocationDialogEvent, PickLocationDialogState> {
  List<dynamic> placeList = [];
  static late TextEditingController locationCtrl;

  PickLocationDialogBloc() : super(PickLocationDialogState.initial()) {
    locationCtrl = TextEditingController(text: "");
    on<PickLocationDialogEvent>((event, emit) async {
      await event.map(
        getLocationAddress: (e) {
          locationCtrl.text = e.location;
        },
        locationAddressChanged: (e) async {
          /// To get google place with serched result
          if (placeList.isNotEmpty) {
            placeList.clear();
          }

          String? response = await LocationHelper.fetchUrl(e.location);
          if (response != null) {
            print("API RESPONSE----> $response");
            placeList = json.decode(response)['predictions'];
          }
          emit(
            state.copyWith(
              locationAddress: InputEmptyOrNot(""),
              searchLocationList: placeList
                  .map(
                    (e) => Predictions.fromJson(e),
                  )
                  .toList(),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationSelectedFromSearchList: (e) async {
          PlaceDetailDTO? res;
          if (e.isFromStarting == true) {
            locationCtrl.text = e.locationName ?? "";
            String? response =
                await LocationHelper.fetchUrl(e.locationName ?? "");
            if (response != null) {
              placeList = json.decode(response)['predictions'];
            }
            final locationList = placeList
                .map(
                  (e) => Predictions.fromJson(e),
                )
                .toList();
            final matchedLocation = locationList.firstWhere(
              (location) => location.description == e.locationName,
              orElse: () => Predictions(),
            );
            res = await LocationHelper.getPlaceDetail(
                matchedLocation.place_id ?? "");
            emit(
              state.copyWith(
                // locationAddress: InputEmptyOrNot(e.selectedLocation),
                locationAddress:
                    InputEmptyOrNot(matchedLocation.description ?? ""),
                searchLocationList: [],
                selectedAddress: res ?? PlaceDetailDTO(),
                selectedLocationPrediction: matchedLocation,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            locationCtrl.text = e.selectedLocation.description ?? "";
            res = await LocationHelper.getPlaceDetail(
                e.selectedLocation.place_id ?? "");
            emit(
              state.copyWith(
                // locationAddress: InputEmptyOrNot(e.selectedLocation),
                locationAddress:
                    InputEmptyOrNot(e.selectedLocation.description ?? ""),
                searchLocationList: [],
                selectedAddress: res ?? PlaceDetailDTO(),
                selectedLocationPrediction: e.selectedLocation,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
      );
    });
  }
}
