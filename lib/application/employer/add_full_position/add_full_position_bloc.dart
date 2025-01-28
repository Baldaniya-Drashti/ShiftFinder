import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/auth/contractor_auth/address_proof/address_proof_bloc.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';

part 'add_full_position_event.dart';

part 'add_full_position_state.dart';

part 'add_full_position_bloc.freezed.dart';

@injectable
class AddFullPositionBloc extends Bloc<AddFullPositionEvent, AddFullPositionState> {
  final IAccountRepository _repository;
  final IMainFacade _mainFacade;

  AddFullPositionBloc(this._repository, this._mainFacade) : super(AddFullPositionState.initial()) {
    on<AddFullPositionEvent>(
      (event, emit) async {
        await event.map(
          onCreate: (value) {
            add(AddFullPositionEvent.fetchLocationList(context: value.context));
          },
          fetchLocationList: (value) async {
            emit(state.copyWith(loading: true));
            final locationList = await _repository.getLocationListApi();
            emit(state.copyWith(loading: false));
            locationList.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) => 'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                emit(state.copyWith(locationList: r));
              },
            );
          },
          onJobTypeChanged: (value) {
            emit(
              state.copyWith(
                employerLongTermDto: state.employerLongTermDto.copyWith(job_type: value.value.id),
              ),
            );
          },
          onShiftScheduleChanged: (value) {
            emit(state.copyWith(selectedShiftSchedule: value.value));
          },
          onLocationChanged: (OnLocationChanged value) {
            emit(state.copyWith(selectedLocation: value.selectedLocation));
          },
          onCompensationTypeChanged: (OnCompensationTypeChanged value) {
            emit(
              state.copyWith(
                employerLongTermDto: state.employerLongTermDto.copyWith(compensation_type: value.type),
              ),
            );
          },
          onEstimatedDateChanged: (OnEstimatedDateChanged value) {
            emit(
              state.copyWith(
                employerLongTermDto: state.employerLongTermDto.copyWith(estimated_weekly_hours: value.value),
              ),
            );
          },
          removeShiftSchedule: (RemoveShiftSchedule value) {
            emit(
              state.copyWith(
                requiredShiftScheduleChipList: ListInputEmptyOrNot(
                  List.from(
                    List.of(state.requiredShiftScheduleChipList.getValue())..remove(value.selectedValue),
                  ),
                ),
              ),
            );
          },
          confirmShiftSchedule: (ConfirmSoftwareSkill value) {
            emit(state.copyWith(
              requiredShiftScheduleChipList: ListInputEmptyOrNot(value.shiftSchedule),
            ));
          },
          onContinue: (OnContinue value) {
            final longTermPosition = state.employerLongTermDto.copyWith(
              benefits: value.benefits,
              position: value.position,
              union_bargaining_unit: value.unionBargainUnit,
              compensation_package: value.compensationPackage,
              job_summary: value.jobSummary,
              responsibilities: value.keyResponsibility,
              external_internal_relationships: value.externalInternalRelationship,
              qualifications: value.requiredQualification,
              experience: value.requiredExperience,
              licenses_certifications: value.licenseCertification,
              skills: value.requiredSkill,
              other: value.others,
              location: state.selectedLocation,
              location_unit: state.selectedLocationUnit,
              rate_hour: num.tryParse(value.salaryOrRateHour),
              compensation_type: state.selectedRadioOption,
              shift_schedule_type: getShiftScheduleId(state.requiredShiftScheduleChipList.getValue()),
            );

            print("==>yyy ${longTermPosition.toJson()}");

            value.context.router.push(
              PageRouteInfo(
                EmployerFullPostingConfirmView.name,
                args: EmployerFullPostingConfirmViewArgs(employerFullPosting: longTermPosition),
              ),
            );
          },
          locationChanged: (LocationChanged value) {
            final selectedLocationObject = state.locationList.firstWhere(
              (location) => location.location == value.selectedValue,
              orElse: () => LocationDTO(),
            );

            print("selectedLocationObject => $selectedLocationObject");

            emit(
              state.copyWith(
                location: InputEmptyOrNot(selectedLocationObject.location ?? ""),
                unitList: selectedLocationObject.add_units ?? [],
                selectedLocationUnit: "",
                showLocationError:
                    (selectedLocationObject.add_units != null && selectedLocationObject.add_units!.isNotEmpty) ? true : false,
                selectedLocation: selectedLocationObject,
              ),
            );
          },
          locationUnitSelectionChanged: (LocationUnitSelectionChanged value) {
            emit(
              state.copyWith(
                selectedLocationUnit: value.selectedUnit,
                showLocationError: false,
              ),
            );
          },
          selectEstimatedHour: (SelectEstimatedHour value) {
            emit(
              state.copyWith(
                employerLongTermDto: state.employerLongTermDto.copyWith(
                  estimated_weekly_hours: value.estimatedHour,
                ),
              ),
            );
          },
          getEmployerFullPostingData: (GetEmployerFullPostingData value) async {
            emit(state.copyWith(loading: true));
            final result = await _mainFacade.getEmployerPositionDetail(id: value.id);
            emit(state.copyWith(loading: false));
            result.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) => 'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                final data = EmployerLongTermSuccessDto.fromJson(r.data);
                emit(state.copyWith(employerLongTermDto: data));
              },
            );
          },
          confirmLanguageList: (ConfirmLanguageList value) {
            emit(state.copyWith(
              languageChipList: ListInputEmptyOrNot(value.languageList),
              languageOther: value.otherLanguageList,
            ));
          },
          removeLanguageChips: (RemoveLanguageChips value) {
            emit(
              state.copyWith(
                languageChipList: ListInputEmptyOrNot(
                  List.from(
                    List.of(state.languageChipList.getValue())..remove(value.selectedLanguage),
                  ),
                ),
                languageOther: List.of(state.languageOther)..remove(value.selectedLanguage),
              ),
            );
          },
          addLanguageChips: (AddLanguageChips e) {
            if (e.selectedLanguage.isNotEmpty &&
                !e.selectedLanguage.toLowerCase().contains("other") &&
                (state.languageChipList.getValue().isEmpty || !state.languageChipList.getValue().contains(e.selectedLanguage))) {
              emit(
                state.copyWith(
                  languageChipList: ListInputEmptyOrNot(List.from(state.languageChipList.getValue()..add(e.selectedLanguage))),
                  languageChip: (e.isOtherValue == true) ? "" : e.selectedLanguage,
                  languageOther: (e.isOtherValue == true) ? (List<String>.from(state.languageOther)..add(e.selectedLanguage)) : [],
                ),
              );
            } else if ((state.languageChip.toLowerCase() == "other" && e.isOtherValue == true && e.selectedLanguage.isEmpty)) {
              emit(state.copyWith());
            } else {
              emit(
                state.copyWith(
                  languageChipList: ListInputEmptyOrNot(List.from(state.languageChipList.getValue())),
                  languageChip: (e.isOtherValue == true) ? "" : e.selectedLanguage,
                ),
              );
            }
          },
        );
      },
    );
  }
}
