import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/logger/logger.dart';

part 'employer_location_form_event.dart';

part 'employer_location_form_state.dart';

part 'employer_location_form_bloc.freezed.dart';

@injectable
class EmployerLocationFormBloc extends Bloc<EmployerLocationFormEvent, EmployerLocationFormState> {
  final IAccountRepository _repository;
  final IMainFacade _mainFacade;
  static TextEditingController locationCtrl = TextEditingController();
  List<dynamic> placeList = [];

  EmployerLocationFormBloc(this._repository, this._mainFacade) : super(EmployerLocationFormState.initial()) {
    on<EmployerLocationFormEvent>((event, emit) async {
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
                  facilityTypeList: List.from(state.facilityTypeList)..addAll(r),
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
          var res = await LocationHelper.getPlaceDetail(e.selectedLocation.place_id ?? "");
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
            ),
          );
        },
        locationNoteChanged: (e) {
          emit(
            state.copyWith(
              locationNote: e.locationNote,
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

          final existingUnit = state.listOfUnit[e.index];

          bool isUnitNameAlreadyExist = state.listOfUnit
              .any((unit) => unit.number_or_name?.toLowerCase() == e.updatedUnit.number_or_name?.toLowerCase() && unit != existingUnit);
          if (isUnitNameAlreadyExist) {
            AppFocus.unfocus(e.context);
            showError(message: StringConstant.unitAlreadyExist).show(e.context);
          } else {
            // - The number_or_name is new (not existing in another unit)
            // - Or the number_or_name is the same, and only the note is changed
            updatedList[e.index] = e.updatedUnit;
            emit(
              state.copyWith(
                listOfUnit: updatedList,
                authFailureOrSuccessOption: none(),
              ),
            );
            Navigator.pop(e.context);
          }
          /*if (!state.listOfUnit.any((unit) =>
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
          }*/
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
                    return unit.number_or_name?.toLowerCase() == e.unitNumber.trim().toLowerCase();
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
          add(EmployerLocationFormEvent.addUnitNumberChipList(state.unitNumber, state.notes));
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

            if (state.id == null) {
              failureOrSuccess = await _repository.addLocationDetailsApi(
                locationAddress: state.address.getValue() ?? '',
                facilityType: (state.faciltyType.getValue()!.toLowerCase() != "other") ? getSelectedFacilityTypeId() : "",
                facilityTypeOther: (state.faciltyType.getValue()!.toLowerCase() == "other") ? state.otherFaciltyType.getValue() ?? "" : "",
                accreditationNumber: state.accreditationNumber,
                locationId: state.locationId,
                locationNotes: state.locationNote,
                units: state.listOfUnit,
                latitude: state.selectedAddress.result?.geometry?.location?.lat.toString() ?? '',
                longitude: state.selectedAddress.result?.geometry?.location?.lng.toString() ?? '',
                fromRegister: false,
                type: 1,
              );
            } else {
              Log.debug("locationAddress :: ${state.address.getValue() ?? ''}");
              Log.debug("faciltyType :: ${(state.faciltyType.getValue()!.toLowerCase() != "other") ? getSelectedFacilityTypeId() : ""}");
              Log.debug(
                  "facilityTypeOther :: ${(state.faciltyType.getValue()!.toLowerCase() == "other") ? state.otherFaciltyType.getValue() ?? "" : ""}");
              Log.debug("accreditationNumber :: ${state.accreditationNumber}");
              Log.debug("locationId :: ${state.locationId}");
              Log.debug("locationNotes :: ${state.locationNote}");
              Log.debug("latitude :: ${state.selectedAddress.result?.geometry?.location?.lat.toString() ?? ''}");
              Log.debug("longitude :: ${state.selectedAddress.result?.geometry?.location?.lng.toString() ?? ''}");
              Log.debug("listOfUnit :: ${state.listOfUnit}");
            }
          } else {
            AppFocus.unfocus(e.context);
            showError(message: StringConstant.someDetailsAreMissingOrInvalidPleaseCheck).show(e.context);
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
        getLocationInfo: (GetLocationInfo value) async {
          if (value.id.isNegative) return;
          emit(state.copyWith(id: value.id));
          Either<MainFailure, CommonResponse>? failureOrSuccess;
          emit(state.copyWith(isLoading: true));
          failureOrSuccess = await _mainFacade.getLocationDetail(id: value.id);
          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) => 'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
              emit(state.copyWith(isLoading: false));

            },
            (r) async {
              final locationData = LocationDTO.fromJson(r.data);
              Log.debug("==> ${locationData.facility_type?.name}");
              locationCtrl.text = locationData.location ?? "";
              print("=>0000 ${locationData.accreditation_number ?? ""}");

              emit(
                state.copyWith(
                    locationData: locationData,
                    locationId: locationData.location_id ?? "",
                    accreditationNumber: locationData.accreditation_number ?? "",
                    locationNote: locationData.location_note ?? "",
                    listOfUnit: locationData.add_units ?? [],
                    faciltyTypeDDValue: locationData.facility_type?.name ?? "",
                    faciltyType: InputEmptyOrNot(locationData.facility_type?.name ?? ""),
                    address: InputEmptyOrNot(locationData.location ?? ""),
                    isLoading: false
                ),
              );

            },
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
