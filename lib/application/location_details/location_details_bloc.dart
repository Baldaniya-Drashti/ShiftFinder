// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:http/http.dart' as http;

import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
part 'location_details_event.dart';
part 'location_details_state.dart';
part 'location_details_bloc.freezed.dart';

@injectable
class LocationDetailsBloc
    extends Bloc<LocationDetailsEvent, LocationDetailsState> {
  final IAccountRepository _repository;
  static TextEditingController locationCtrl = TextEditingController();
  List<dynamic> placeList = [];

  /// TO GET GOOGLE PLACES
  /*Future<String?> fetchUrl(String query, {Map<String, String>? headers}) async {
    var uri = Uri.tryParse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?query=$query&components=country:ca&key=AIzaSyCiVTuKvc7IrDDG_onVY-CdAlKz_Mo_XoE')!;
    // Uri uri = Uri.https(
    //   "maps.googleapis.com",
    //   'maps/api/place/textsearch/json',
    //   {
    //     "input": query,
    //     "key": "AIzaSyCiVTuKvc7IrDDG_onVY-CdAlKz_Mo_XoE",
    //   },
    // );
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("LOCATION CATCH ERROR: $e");
    }
    return null;
  }*/

  Future<String?> fetchUrl(String query, {Map<String, String>? headers}) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": "AIzaSyCiVTuKvc7IrDDG_onVY-CdAlKz_Mo_XoE",
        "components": "country:ca",
      },
    );
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("LOCATION CATCH ERROR: $e");
    }
    return null;
  }

  LocationDetailsBloc(this._repository)
      : super(LocationDetailsState.initial()) {
    on<LocationDetailsEvent>((event, emit) async {
      await event.map(
        getFacilityTypeList: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          final facilityTypeList = await _repository.getFacilityTypeList();
          print("Facility type List ---> $facilityTypeList");
          facilityTypeList.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                facilityTypeList: [],
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isLoading: false,
                  facilityTypeList: List.from(state.facilityTypeList)
                    ..addAll(r),
                ),
              );
            },
          );
        },
        addressChanged: (e) async {
          /// To get google place with serched result
          // List<dynamic> placeList = [];
          // String? response = await fetchUrl(e.address);
          // if (response != null) {
          //   print("API RESPONSE----> $response");
          //   placeList = json.decode(response)['results'];
          // }

          if (placeList.isNotEmpty) {
            placeList.clear();
          }
          String? response = await fetchUrl(e.address);
          if (response != null) {
            print("API RESPONSE----> $response");
            placeList = json.decode(response)['predictions'];
          }
          emit(
            state.copyWith(
              address: InputEmptyOrNot(e.address),
              // searchLocationList: placeList
              //     .map(
              //       (e) => Results.fromJson(e),
              //     )
              //     .toList(),
              searchLocationList: placeList,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationSelectedFromSearchList: (e) {
          // locationCtrl.text = e.selectedLocation.formatted_address ?? "";
          locationCtrl.text = e.selectedLocation;

          emit(
            state.copyWith(
              // address:
              //     InputEmptyOrNot(e.selectedLocation.formatted_address ?? ""),
              address: InputEmptyOrNot(e.selectedLocation),

              searchLocationList: [],
              // selectedAddress: e.selectedLocation,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationIdChanged: (e) {
          emit(
            state.copyWith(
              locationId: e.locationId,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        accreditationNumberChanged: (e) {
          emit(
            state.copyWith(
              accreditationNumber: e.accreditationNumber,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationNoteChanged: (e) {
          emit(
            state.copyWith(
              locationNote: e.locationNote,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        unitNumberChanged: (e) {
          emit(
            state.copyWith(
              unitNumber: e.unitNumber,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        removeUnitNumberChip: (e) {
          /*emit(
            state.copyWith(
              unitNoNameChipList: List.from(state.unitNoNameChipList)
                ..remove(e.unitNumber),
              unitNumber: "",
              authFailureOrSuccessOption: none(),
            ),
          );*/

          /// for unit list
          emit(
            state.copyWith(
              // unitNoNameChipList: List.from(state.unitNoNameChipList)
              //   ..remove(e.unitNumber),
              // unitNumber: "",
              listOfUnit: List.from(state.listOfUnit)..removeAt(e.index),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        addUnitNumberChipList: (e) {
          /*if (e.unitNumber.trim().isNotEmpty &&
              (!state.unitNoNameChipList.contains(e.unitNumber) ||
                  state.unitNoNameChipList.isEmpty)) {
            emit(
              state.copyWith(
                unitNoNameChipList: List.from(state.unitNoNameChipList)
                  ..add(e.unitNumber),
                unitNumber: e.unitNumber,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                unitNoNameChipList: List.from(state.unitNoNameChipList),
                unitNumber: e.unitNumber,
                authFailureOrSuccessOption: none(),
              ),
            );
          }*/

          /// for unit list
          if (e.unitNumber.trim().isNotEmpty &&
              (!state.listOfUnit
                      .every((unit) => unit.number_or_name == e.unitNumber) ||
                  state.listOfUnit.isEmpty)) {
            emit(
              state.copyWith(
                listOfUnit: List.from(state.listOfUnit)
                  ..add(UnitDTO(
                    number_or_name: e.unitNumber.trim(),
                    note: e.unitNote.trim(),
                  )),
                unitNumber: "",
                notes: "",
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                listOfUnit: List.from(state.listOfUnit),
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        notesChanged: (e) {
          emit(
            state.copyWith(
              notes: e.notes,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        facilityTypeChanged: (e) {
          emit(
            state.copyWith(
              faciltyTypeDDValue: e.faciltyType,
              faciltyType: InputEmptyOrNot(e.faciltyType),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        continueBtnPressed: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;
          final isAddressValid = state.address.isValid();
          bool isFaciltyTypeValid = state.faciltyType.isValid();

          if (state.faciltyType.getValue()!.toLowerCase() == "other") {
            isFaciltyTypeValid = state.otherFaciltyType.isValid();
          }

          if (isAddressValid && isFaciltyTypeValid) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addLocationDetailsApi(
              locationAddress: state.address.getValue() ?? '',
              facilityType:
                  (state.faciltyType.getValue()!.toLowerCase() != "other")
                      ? getSelectedFacilityTypeId()
                      : "",
              facilityTypeOther:
                  (state.faciltyType.getValue()!.toLowerCase() == "other")
                      ? state.otherFaciltyType.getValue() ?? ""
                      : "",
              accreditationNumber: state.accreditationNumber,
              locationId: state.locationId,
              locationNotes: state.locationNote,
              unitNumber: state.unitNoNameChipList.join(','),
              unitNotes: "Test unit",
              units: state.listOfUnit,
              // latitude:
              //     state.selectedAddress.geometry?.location?.lat.toString() ??
              //         '',
              // longitude:
              //     state.selectedAddress.geometry?.location?.lng.toString() ??
              //         '',
            );
          }
          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        addOtherfaciltyType: (e) {
          emit(
            state.copyWith(
              otherFaciltyTypeValue: e.faciltyType,
              otherFaciltyType: InputEmptyOrNot(e.faciltyType),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
      );
    });
  }

  String getSelectedFacilityTypeId() {
    final selectedFacilityType = state.facilityTypeList.firstWhere(
      (facilityType) => facilityType.name == state.faciltyType.getValue(),
      orElse: () => const SkillDTO(id: -1, name: 'Unknown'),
    );
    return selectedFacilityType.id.toString();
  }
}
