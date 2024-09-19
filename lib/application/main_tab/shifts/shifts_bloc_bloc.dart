import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';

part 'shifts_bloc_event.dart';
part 'shifts_bloc_state.dart';
part 'shifts_bloc_bloc.freezed.dart';

@injectable
class ShiftsBloc extends Bloc<ShiftsBlocEvent, ShiftsBlocState> {
  static TextEditingController locationCtrl = TextEditingController();
  
  final IAccountRepository iAccountRepository;
  List<dynamic> placeList = [];
  ShiftsBloc(this.iAccountRepository) : super(ShiftsBlocState.initial()) {
    on<ShiftsBlocEvent>(
      (event, emit) async {
        await event.map(
          started: (value) async {},
          tabChange: (value) async {
            emit(state.copyWith(selectedTab: value.tabIndex));
          },
          addressChanged: (AddressChanged e) async {
            if (placeList.isNotEmpty) {
              placeList.clear();
            }
            String? response = await LocationHelper.fetchUrl(e.address);
            if (response != null) {
              print("API RESPONSE----> $response");
              placeList = json.decode(response)['predictions'];
            }
            emit(
              state.copyWith(
                address: InputEmptyOrNot(e.address),
                searchLocationList: placeList
                    .map(
                      (e) => Predictions.fromJson(e),
                    )
                    .toList(),
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          getPlaceDetail: (GetPlaceDetail e) async {},
          locationSelectedFromSearchList:
              (_LocationSelectedFromSearchList e) async {
            locationCtrl.text = e.selectedLocation.description ?? "";
            var res = await LocationHelper.getPlaceDetail(
                e.selectedLocation.place_id ?? "");
            emit(
              state.copyWith(
                address: InputEmptyOrNot(e.selectedLocation.description ?? ""),
                searchLocationList: [],
                selectedAddress: res ?? PlaceDetailDTO(),
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          locationIdChanged: (LocationIdChanged value) async {},
          getLocationListAPI: (GetLocationListAPI value) async {
            emit(state.copyWith(isLoading: true));
            final locationList = await iAccountRepository.getLocationListApi();

            // print("Location List ---> ${locationList}");
            locationList.fold(
              (l) => emit(
                state.copyWith(
                  isLoading: false,
                  locationList: [],
                ),
              ),
              (r) {
                var dropdownList = r
                    .map(
                      (e) => DropDownValueModel(
                          name: e.location ?? "", value: e.id),
                    )
                    .toList();
                return emit(
                  state.copyWith(
                    isLoading: false,
                    locationList: List.from(state.locationList)
                      ..addAll(dropdownList),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
