import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:http/http.dart' as http;

import 'package:shift/domain/auth/auth_value_objects.dart';
part 'location_details_event.dart';
part 'location_details_state.dart';
part 'location_details_bloc.freezed.dart';

@injectable
class LocationDetailsBloc
    extends Bloc<LocationDetailsEvent, LocationDetailsState> {
  final IAccountRepository _repository;

  /// TO GET GOOGLE PLACES
  Future<String?> fetchUrl(String query, {Map<String, String>? headers}) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": "AIzaSyCiVTuKvc7IrDDG_onVY-CdAlKz_Mo_XoE",
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

  LocationDetailsBloc(this._repository) : super(LocationDetailsState.initial()) {
    on<LocationDetailsEvent>((event, emit) async {
      await event.map(
        addressChanged: (e) async {
          /// To get google place with serched result
          List<dynamic> placeList = [];
          String? response = await fetchUrl(e.address);
          if (response != null) {
            print("API RESPONSE----> $response");
            placeList = json.decode(response)['predictions'];
          }
          emit(
            state.copyWith(
              address: InputEmptyOrNot(e.address),
              searchLocationList: placeList,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationSelectedFromSearchList: (e) {
          emit(
            state.copyWith(
              address: InputEmptyOrNot(e.selectedLocation),
              searchLocationList: [],
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
          emit(
            state.copyWith(
              unitNoNameChipList: List.from(state.unitNoNameChipList)
                ..remove(e.unitNumber),
              unitNumber: "",
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        addUnitNumberChipList: (e) {
          if (state.unitNoNameChipList.isEmpty ||
              !state.unitNoNameChipList.contains(e.unitNumber)) {
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
          }
        },
        notesChanged: (e) {
          emit(
            state.copyWith(
              unitNumber: e.notes,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        facilityTypeChanged: (e) {
          emit(
            state.copyWith(
              faciltyTypeDDValue: e.faciltyType,
              faciltyType: InputEmptyOrNot(e.faciltyType),
            ),
          );
        },
        continueBtnPressed: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;
          final isAddressValid = state.address.isValid();
          bool isFaciltyTypeValid = state.faciltyType.isValid();

          print("facilityType= ${state.faciltyType.getValue()}");
          print("facilityType= ${state.otherFaciltyType.getValue()}");
          print("facilityType= ${state.otherFaciltyTypeValue}");
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
              facilityType: (state.faciltyType.getValue()!.toLowerCase() != "other") ?  state.faciltyType.getValue()  ?? "": "" ,
              facilityTypeOther: (state.faciltyType.getValue()!.toLowerCase() == "other") ?  state.otherFaciltyType.getValue() ?? "" : "",
              accreditationNumber: state.accreditationNumber,
              locationId: state.locationId,
              locationNotes: state.locationNote,
              unitNotes: state.unitNoNameChipList.join(','),
              unitNumber: state.unitNumber,
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
            ),
          );
        },
      );
    });
  }
}
