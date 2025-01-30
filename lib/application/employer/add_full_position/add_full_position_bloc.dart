import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/auth/contractor_auth/address_proof/address_proof_bloc.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
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
  final IAuthFacade _authFacade;

  AddFullPositionBloc(this._repository, this._mainFacade, this._authFacade) : super(AddFullPositionState.initial()) {
    on<AddFullPositionEvent>(
      (event, emit) async {
        await event.map(
          onCreate: (value) async {
            emit(state.copyWith(loading: true, postId: value.postId));

            add(AddFullPositionEvent.fetchLocationList(context: value.context));
            final languageList = await _authFacade.getLanguageList();

            print("Language List ---> ${languageList}");
            languageList.fold(
              (l) => emit(
                state.copyWith(
                  languageList: [],
                ),
              ),
              (r) {
                return emit(
                  state.copyWith(
                    languageList: List.from(state.languageList)..addAll(r),
                  ),
                );
              },
            );

            if (value.postId != null) {
              final response = await _mainFacade.getEmployerPositionDetail(id: value.postId!, postType: 2);
              response.fold(
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
                  emit(
                    state.copyWith(
                      employerLongTermDto: data,
                      languageOther: data.language_other?.split(',') ?? [],
                      location: InputEmptyOrNot((data.location != null) ? data.location!.location ?? "" : ""),
                      selectedLocationUnit: data.location_unit ?? "",
                      locationObj: data.location ?? LocationDTO(),
                      unitList: (data.location != null) ? data.location?.add_units ?? [] : [],
                      languageChipList: ListInputEmptyOrNot(
                          (data.languages_list != null) ? data.languages_list!.map((element) => element.name ?? "").toList() : []),

                    ),
                  );
                  print("==>employerLongTermDto${state.employerLongTermDto.position}");
                },
              );
            }
            emit(state.copyWith(loading: false));
          },
          fetchLocationList: (value) async {
            final locationList = await _repository.getLocationListApi();
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
            final position = state.employerLongTermDto.copyWith(
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
              shift_schedule_type: getShiftScheduleId(state.requiredShiftScheduleChipList.getValue()),
              language_other: state.languageOther.join(','),
              languages_list_id: getSelectedLanguageId(),
              post_type: 2,
              location_id: state.employerLongTermDto.location?.id.toString() ?? state.selectedLocation?.id.toString(),


            );

            print("==>yyy ${position.toJson()}");
            print("==>yyy ${state.selectedLocation?.id}");
            //
            value.context.router.push(
              PageRouteInfo(
                EmployerFullPostingConfirmView.name,
                args: EmployerFullPostingConfirmViewArgs(employerFullPosting: position, postId: state.postId),
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
            final result = await _mainFacade.getEmployerPositionDetail(id: value.id, postType: 2);
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

  String getSelectedLanguageId() {
    /*List<int> outputIds = [];
    for (String title in state.languageChipList.getValue()) {
      for (ListDTO item in CommonList.languageList) {
        if (item.title == title) {
          outputIds.add(item.id ?? -1);
          break;
        }
      }
    }
    print("IDSSSSS----- ${outputIds}");
    return outputIds;*/

    final languageIds = state.languageChipList
        .getValue()
        .map((chipName) => state.languageList.firstWhere(
              (language) => language.name == chipName,
              orElse: () => const SkillDTO(), // Handle cases where no match is found
            ))
        .where((language) => language.id != null) // Filter out null values
        .map((language) => language.id) // Extract IDs
        .toList();
    String commaSeparated = languageIds.join(',');
    print("Language Ids--> ${commaSeparated}");
    return commaSeparated;
  }
}
