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
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/logger/logger.dart';

part 'employer_location_form_event.dart';

part 'employer_location_form_state.dart';

part 'employer_location_form_bloc.freezed.dart';

@injectable
class EmployerLocationFormBloc
    extends Bloc<EmployerLocationFormEvent, EmployerLocationFormState> {
  final IAccountRepository _repository;
  final IMainFacade _mainFacade;
  static TextEditingController locationCtrl = TextEditingController();
  static TextEditingController locationIDCtrl = TextEditingController();
  static TextEditingController locationNoteCtrl = TextEditingController();
  static TextEditingController accredationNOCtrl = TextEditingController();
  List<dynamic> placeList = [];

  EmployerLocationFormBloc(this._repository, this._mainFacade)
      : super(EmployerLocationFormState.initial()) {
    on<EmployerLocationFormEvent>((event, emit) async {
      await event.map(
        locationBrandChanged: (e) {
          emit(
            state.copyWith(
              locationBrandDDValue: e.locationBrand,
              locationBrand: InputEmptyOrNot(e.locationBrand),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        addOtherLocationBrand: (e) {
          emit(
            state.copyWith(
              otherLocationBrandValue: e.locationBrand,
              otherLocationBrand: InputEmptyOrNot(e.locationBrand),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
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
          locationCtrl.clear();
          locationIDCtrl.clear();
          locationNoteCtrl.clear();
          accredationNOCtrl.clear();

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

          if (getCurrentIndustry() == 2) {
            add(EmployerLocationFormEvent.getLocationBrandList());
          }
        },
        getLocationBrandList: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          final locationBrandList = await _repository.getLocationBrandList();
          print("Location brand List ---> $locationBrandList");
          locationBrandList.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                locationBrandList: [],
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isLoading: false,
                  locationBrandList: List.from(state.locationBrandList)
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
              selectedLocationPrediction: e.selectedLocation,
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

          bool isUnitNameAlreadyExist = state.listOfUnit.any((unit) =>
              unit.number_or_name?.toLowerCase() ==
                  e.updatedUnit.number_or_name?.toLowerCase() &&
              unit != existingUnit);
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
          add(EmployerLocationFormEvent.addUnitNumberChipList(
              state.unitNumber, state.notes));
          await Future.delayed(Duration(milliseconds: 50));
          final isAddressValid = state.address.isValid();
          bool isFaciltyTypeValid = state.faciltyType.isValid();
          bool isLocationBrandValid = state.locationBrand.isValid();

          if (state.faciltyType.getValue()!.toLowerCase() == "other") {
            isFaciltyTypeValid = state.otherFaciltyType.isValid();
          }
          if (state.locationBrand.getValue()!.toLowerCase() == "other") {
            isLocationBrandValid = state.otherLocationBrand.isValid();
          }
          if (isAddressValid &&
              isFaciltyTypeValid &&
              (getCurrentIndustry() != 2 ||
                  (getCurrentIndustry() == 2 && isLocationBrandValid))) {
            // if (isAddressValid && isFaciltyTypeValid && (getCurrentIndustry() == 2 && isLocationBrandValid)) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );

            if (state.id == null) {
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
                fromRegister: false,
                type: 1,
                locationBrand:
                    (state.locationBrand.getValue()!.toLowerCase() != "other")
                        ? getSelectedLocationBrandId()
                        : "",
                locationBrandOther:
                    (state.locationBrand.getValue()!.toLowerCase() == "other")
                        ? state.otherLocationBrand.getValue() ?? ""
                        : "",
              );
            } else {
              failureOrSuccess = await _repository.updateLocation(
                id: state.id ?? -1,
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
                    "${state.locationData.latitude ?? 0}",
                longitude: state.selectedAddress.result?.geometry?.location?.lng
                        .toString() ??
                    "${state.locationData.longitude ?? 0}",
                fromRegister: false,
                locationBrand:
                    (state.locationBrand.getValue()!.toLowerCase() != "other")
                        ? getSelectedLocationBrandId()
                        : "",
                locationBrandOther:
                    (state.locationBrand.getValue()!.toLowerCase() == "other")
                        ? state.otherLocationBrand.getValue() ?? ""
                        : "",
              );

              Log.debug("locationAddress :: ${state.address.getValue() ?? ''}");
              Log.debug(
                  "faciltyType :: ${(state.faciltyType.getValue()!.toLowerCase() != "other") ? getSelectedFacilityTypeId() : ""}");
              Log.debug(
                  "facilityTypeOther :: ${(state.faciltyType.getValue()!.toLowerCase() == "other") ? state.otherFaciltyType.getValue() ?? "" : ""}");
              Log.debug("accreditationNumber :: ${state.accreditationNumber}");
              Log.debug("locationId :: ${state.locationId}");
              Log.debug("locationNotes :: ${state.locationNote}");
              Log.debug(
                  "latitude :: ${state.selectedAddress.result?.geometry?.location?.lat.toString() ?? ''}");
              Log.debug(
                  "longitude :: ${state.selectedAddress.result?.geometry?.location?.lng.toString() ?? ''}");
              Log.debug("listOfUnit :: ${state.listOfUnit}");
            }
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
        getLocationInfo: (GetLocationInfo value) async {
          Either<MainFailure, CommonResponse>? failureOrSuccess;
          if (value.id != -1) {
            emit(state.copyWith(
              id: value.id,
              isLoading: true,
              authFailureOrSuccessOption: none(),
            ));
            failureOrSuccess =
                await _mainFacade.getLocationDetail(id: value.id);

            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                print("post--> $r");
                if (r.data != null) {
                  final locationData = LocationDTO.fromJson(r.data);
                  emit(
                    state.copyWith(
                      locationData: locationData,
                      locationId: locationData.location_id ?? "",
                      accreditationNumber:
                          locationData.accreditation_number ?? "",
                      locationNote: locationData.location_note ?? "",
                      listOfUnit: locationData.add_units ?? [],
                      faciltyTypeDDValue:
                          locationData.facility_type?.name ?? "",
                      faciltyType: InputEmptyOrNot(
                          locationData.facility_type?.name ?? ""),
                      address: InputEmptyOrNot(locationData.location ?? ""),
                      locationBrandDDValue:
                          locationData.location_brand?.name ?? "",
                      locationBrand: InputEmptyOrNot(
                          locationData.location_brand?.name ?? ""),
                    ),
                  );
                  locationCtrl.text = locationData.location ?? "";
                  locationIDCtrl.text = locationData.location_id ?? "";
                  locationNoteCtrl.text = locationData.location_note ?? "";
                  accredationNOCtrl.text =
                      locationData.accreditation_number ?? "";
                }
              },
            );
            emit(state.copyWith(isLoading: false));
          }
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

  String getSelectedLocationBrandId() {
    final selecteLocationBrand = state.locationBrandList.firstWhere(
      (brand) => brand.name == state.locationBrand.getValue(),
      orElse: () => const SkillDTO(id: -1, name: 'Unknown'),
    );
    return selecteLocationBrand.id.toString();
  }
}
