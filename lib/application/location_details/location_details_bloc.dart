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

import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'location_details_event.dart';
part 'location_details_state.dart';
part 'location_details_bloc.freezed.dart';

@injectable
class LocationDetailsBloc
    extends Bloc<LocationDetailsEvent, LocationDetailsState> {
  final IAccountRepository _repository;
  static TextEditingController locationCtrl = TextEditingController();
  List<dynamic> placeList = [];

  LocationDetailsBloc(this._repository)
      : super(LocationDetailsState.initial()) {
    on<LocationDetailsEvent>((event, emit) async {
      await event.map(
        updateUnitNumberChanged: (e) {
          emit(
            state.copyWith(
              updatedUnitNumber: e.unitNumber,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        updateUnitNotesChanged: (e) {
          emit(
            state.copyWith(
              updatedUnitNotes: e.notes,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
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
        locationSelectedFromSearchList: (e) async {
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
        editUnitNumberChip: (e) {
          List<UnitDTO> updatedList = List.from(state.listOfUnit);
          if (!state.listOfUnit.any((unit) =>
              unit.number_or_name?.toLowerCase() ==
              e.updatedUnit.number_or_name?.toLowerCase())) {
            updatedList[e.index] = e.updatedUnit;
            emit(
              state.copyWith(
                listOfUnit: updatedList,
                authFailureOrSuccessOption: none(),
              ),
            );
            Navigator.pop(e.context);
          } else {
            AppFocus.unfocus(e.context);
            showError(message: StringConstant.unitAlreadyExist).show(e.context);
          }
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
          print("Unit list----> ${state.listOfUnit}");
          if (e.unitNumber.trim().isNotEmpty &&
              (!state.listOfUnit.any((unit) {
                    print("Unit number----> ${e.unitNumber}");
                    print("Unit number_or_name----> ${unit.number_or_name}");
                    return unit.number_or_name?.toLowerCase() ==
                        e.unitNumber.trim().toLowerCase();
                  }) ||
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

          print("state unit--> ${state.unitNumber}");
          print("state unit note--> ${state.notes}");
          add(LocationDetailsEvent.addUnitNumberChipList(
              state.unitNumber, state.notes));
          await Future.delayed(Duration(milliseconds: 50));
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
              units: state.listOfUnit,
              latitude: state.selectedAddress.result?.geometry?.location?.lat
                      .toString() ??
                  '',
              longitude: state.selectedAddress.result?.geometry?.location?.lng
                      .toString() ??
                  '',
            );
          } else {
            AppFocus.unfocus(e.context);
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
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
        getPlaceDetail: (GetPlaceDetail value) async {
          await LocationHelper.getPlaceDetail(value.placeId);
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
