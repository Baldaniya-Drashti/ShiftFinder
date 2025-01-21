// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/core/speciality/speciality_dto.dart';
part 'add_contractor_skill_form_event.dart';
part 'add_contractor_skill_form_state.dart';
part 'add_contractor_skill_form_bloc.freezed.dart';

@injectable
class AddContractorSkillFormBloc
    extends Bloc<AddContractorSkillFormEvent, AddContractorSkillFormState> {
  final IAuthFacade _authFacade;
  final IAccountRepository repository;

  AddContractorSkillFormBloc(this._authFacade, this.repository)
      : super(AddContractorSkillFormState.initial()) {
    on<AddContractorSkillFormEvent>((event, emit) async {
      await event.map(
        getProfileDetail: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          final failureOrSuccess = await repository.getCurrentUserApi();
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
              ),
            ),
            (r) {
              print("Current user complete profile----> ${r}");
              return emit(
                state.copyWith(
                  isLoading: false,
                  roleTypeChipList: ListInputEmptyOrNot(
                      (r.complete_profile != null &&
                              r.complete_profile!.roles_list != null)
                          ? r.complete_profile!.roles_list!
                              .map((element) => element.name ?? "")
                              .toList()
                          : []),

                  // roleType: InputEmptyOrNot(r.roles_list_name ?? ""),
                  requiredSoftwareSkillChipList: ListInputEmptyOrNot(
                      (r.complete_profile != null &&
                              r.complete_profile?.softwares_skill_list != null)
                          ? r.complete_profile!.softwares_skill_list!
                              .map((element) => element.name ?? "")
                              .toList()
                          : []),
                  softwareSkillOther:
                      r.complete_profile?.software_skill_other?.split(',') ??
                          [],
                  requiredSpecialityChipList: ListInputEmptyOrNot(
                      (r.complete_profile != null &&
                              r.complete_profile!.specialties_detail != null)
                          ? r.complete_profile!.specialties_detail!
                              .map((element) => element.name ?? "")
                              .toList()
                          : []),
                  // specialityOther: r.specialties_detail_other?.split(',') ?? [],
                  languageChipList: ListInputEmptyOrNot(
                      (r.complete_profile != null &&
                              r.complete_profile!.languages_list != null)
                          ? r.complete_profile!.languages_list!
                              .map((element) => element.name ?? "")
                              .toList()
                          : []),
                  languageOther: (r.complete_profile != null &&
                          r.complete_profile!.language_other != null)
                      ? r.complete_profile!.language_other?.split(',') ?? []
                      : [],
                  // location: InputEmptyOrNot((r.location != null) ? r.location!.location ?? "" : ""),
                  // locationObj: r.location ?? LocationDTO(),
                  // unitList: (r.location != null) ? r.location?.add_units ?? [] : [],
                  // selectedLocationUnit: r.location_unit ?? "",
                  // rateHour: Rate((r.rate_hour != null) ? "${r.rate_hour ?? ""}" : ""),
                ),
              );
            },
          );

          emit(
            state.copyWith(
              isLoading: false,
            ),
          );
        },
        confirmSpecialityList: (e) {
          emit(state.copyWith(
            requiredSpecialityChipList: ListInputEmptyOrNot(e.specialityList),
            specialityOther: e.otherSpecialityList,
            authFailureOrSuccessOption: none(),
          ));
        },
        confirmRoleList: (e) {
          emit(state.copyWith(
            roleTypeChipList: ListInputEmptyOrNot(e.roleList),
            authFailureOrSuccessOption: none(),
          ));

          print("selected role list---> ${state.roleTypeChipList}");
        },
        confirmSoftwareSkill: (e) {
          emit(state.copyWith(
            requiredSoftwareSkillChipList: ListInputEmptyOrNot(e.skillList),
            softwareSkillOther: e.otherSkillList,
            authFailureOrSuccessOption: none(),
          ));

          print(
              "selected skill list---> ${state.requiredSoftwareSkillChipList} \n other skills ${state.softwareSkillOther}");
        },
        confirmLanguageList: (e) {
          emit(state.copyWith(
            languageChipList: ListInputEmptyOrNot(e.languageList),
            languageOther: e.otherLanguageList,
            authFailureOrSuccessOption: none(),
          ));

          print(
              "selected language list---> ${state.languageChipList} \n other languages ${state.languageOther}");
        },

        /// GET ALL DROPDOWN LIST FROM API
        getAllDropDownList: (e) async {
          // Either<AuthFailure, SkillListDTO>? res;
          emit(
            state.copyWith(
              isLoading: true,
              authFailureOrSuccessOption: none(),
            ),
          );

          // add(AddContractorSkillFormEvent.getProfileDetail());
          await getRoleListApi(emit);
          await getSpecialityListApi(emit);
          await getExperienceListApi(emit);
          await getLanguageListApi(emit);
          await getSoftwareListApi(emit);
          if (e.isUpdate == true) {
            await getContractorSkillAPI(emit);
          }

          // final roleList = await _authFacade.getRoleList();
          // print("Role List ---> ${roleList}");
          // roleList.fold(
          //   (l) => emit(
          //     state.copyWith(
          //       isLoading: false,
          //       roleList: [],
          //     ),
          //   ),
          //   (r) {
          //     return emit(
          //       state.copyWith(
          //         isLoading: false,
          //         roleList: List.from(state.roleList)..addAll(r),
          //       ),
          //     );
          //   },
          // );

          // final softwareList = await _authFacade.getSoftwareSkillList();
        },

        /// ROLE TYPE
        addRoleTypeChips: (e) {
          if ((state.roleTypeChipList.getValue().isEmpty ||
              !state.roleTypeChipList.getValue().contains(e.roleType))) {
            emit(
              state.copyWith(
                roleTypeChipList: ListInputEmptyOrNot(List.from(
                    state.roleTypeChipList.getValue()..add(e.roleType))),
                roleTypeChip: e.roleType,
                showRoleTypeError: false,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                roleTypeChipList: ListInputEmptyOrNot(
                    List.from(state.roleTypeChipList.getValue())),
                roleTypeChip: e.roleType,
                showRoleTypeError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }

          /*if (e.roleType.isNotEmpty &&
              !e.roleType.toLowerCase().contains("other") &&
              (state.roleTypeChipList.getValue().isEmpty ||
                  !state.roleTypeChipList.getValue().contains(e.roleType))) {
            emit(
              state.copyWith(
                roleTypeChipList: ListInputEmptyOrNot(List.from(
                    state.roleTypeChipList.getValue()..add(e.roleType))),
                roleTypeChip: (e.isOtherValue == true) ? "" : e.roleType,
                roleOther: (e.isOtherValue == true) ? e.roleType : "",
                showRoleTypeError: false,
                authFailureOrSuccessOption: none(),
              ),
            );
          }

          /// when click on add button
          else if ((state.roleTypeChip.toLowerCase() == "other" &&
              e.isOtherValue == true &&
              e.roleType.isEmpty)) {
            emit(
              state.copyWith(
                showRoleTypeError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }

          /// when select "other" value
          else {
            emit(
              state.copyWith(
                roleTypeChipList: ListInputEmptyOrNot(
                    List.from(state.roleTypeChipList.getValue())),
                roleTypeChip: (e.isOtherValue == true) ? "" : e.roleType,
                showRoleTypeError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }*/
        },
        removeRoleTypeChips: (e) {
          /*emit(
            state.copyWith(
              roleTypeChipList: ListInputEmptyOrNot(List.from(
                  state.roleTypeChipList.getOrCrash()..remove(e.roleType))),
              roleTypeChip: "",
              showRoleTypeError:
                  (state.roleTypeChipList.getValue().isNotEmpty) ? false : true,
              authFailureOrSuccessOption: none(),
            ),
          );*/

          emit(
            state.copyWith(
              roleTypeChipList: ListInputEmptyOrNot(
                List.from(
                  List.of(state.roleTypeChipList.getValue())
                    ..remove(e.roleType),
                ),
              ),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Select Specialities
        addRequiredSpecialitichips: (e) {
          // final updatedList = List<SpecialityDTO>.from(
          //     state.requiredSpecialityChipList.getValue());
          print("SELECT VALUEEEEE-->  ${e.selectedValue}");

          if (e.selectedValue.trim().isNotEmpty &&
              !(e.selectedValue.toLowerCase() == "other") &&
              (state.requiredSpecialityChipList.getValue().isEmpty ||
                  !state.requiredSpecialityChipList.getValue().any(
                      (speciality) => speciality.name == e.selectedValue))) {
            // updatedList.add(SpecialityDTO(specialityName: e.selectedValue));

            emit(
              state.copyWith(
                requiredSpecialityChipList: ListInputEmptyOrNot(
                    List.from(state.requiredSpecialityChipList.getValue())
                      ..add(SpecialityDTO(name: e.selectedValue))),
                requiredSpecialityChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                authFailureOrSuccessOption: none(),
                showSpecialityError: false,
                showSpeExperienceError: true,
              ),
            );
          } else if ((state.requiredSpecialityChip.toLowerCase() == "other" &&
              e.isOtherValue == true &&
              e.selectedValue.isEmpty)) {
            emit(
              state.copyWith(
                showSpecialityError: true,
                showSpeExperienceError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                requiredSpecialityChipList: ListInputEmptyOrNot(
                    List.from(state.requiredSpecialityChipList.getValue())),
                requiredSpecialityChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                showSpecialityError: true,
                showSpeExperienceError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        removeRequiredSpecialitichips: (e) {
          /*emit(
            state.copyWith(
              requiredSpecialityChipList: ListInputEmptyOrNot(
                  List.from(state.requiredSpecialityChipList.getValue())
                    ..removeAt(e.currentIndex)),
              requiredSpecialityChip: "",
              showSpecialityError:
                  (state.requiredSpecialityChipList.getValue().isNotEmpty)
                      ? false
                      : true,
              authFailureOrSuccessOption: none(),
            ),
          );*/

          /// For multi speciality
          emit(
            state.copyWith(
              requiredSpecialityChipList: ListInputEmptyOrNot(
                List.from(
                  List.of(state.requiredSpecialityChipList.getValue())
                    ..remove(e.selectedValue),
                ),
              ),
              specialityOther: List.of(state.specialityOther)
                ..remove(e.selectedValue),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Selected Speciality's Experience
        addSpecialityExperienceList: (e) {
          final updatedList = List<SpecialityDTO>.from(
              state.requiredSpecialityChipList.getValue());

          print(
              "state.requiredSpecialityChipList---> ${state.requiredSpecialityChipList}");
          if (!(e.selectedValue.toLowerCase() == "other") &&
              (state.requiredSpecialityChipList.getValue().isNotEmpty)) {
            // emit(
            //   state.copyWith(
            //     selectedSpecialityExperienceList: ListInputEmptyOrNot(
            //         List.from(state.selectedSpecialityExperienceList.getValue())
            //           ..add(e.selectedValue)),
            //     selectedSpecialityExperience:
            //         (e.isOtherValue == true) ? "" : e.selectedValue,
            //     authFailureOrSuccessOption: none(),
            //   ),
            // );

            int selectedExperienceId = getExperienceIdFromName(e.selectedValue);
            for (int i = 0; i < updatedList.length; i++) {
              if (i == e.currentIndex) {
                SpecialityDTO obj = SpecialityDTO(
                  name: updatedList[i].name,
                  specialityExperience: e.selectedValue,
                  experienceId: selectedExperienceId,
                );
                updatedList.removeAt(i);
                updatedList.insert(i, obj);
              }
            }
            print("SPECILAITY LIST---->  ${jsonEncode(updatedList)}");
            emit(
              state.copyWith(
                requiredSpecialityChipList:
                    ListInputEmptyOrNot(List.from(updatedList)),
                selectedSpecialityExperience:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                showSpeExperienceError: false,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            // emit(
            //   state.copyWith(
            //     selectedSpecialityExperienceList: ListInputEmptyOrNot(List.from(
            //         state.selectedSpecialityExperienceList.getValue())),
            //     selectedSpecialityExperience:
            //         (e.isOtherValue == true) ? "" : e.selectedValue,
            //     authFailureOrSuccessOption: none(),
            //   ),
            // );
            emit(
              state.copyWith(
                requiredSpecialityChipList: ListInputEmptyOrNot(
                    List.from(state.requiredSpecialityChipList.getValue())),
                selectedSpecialityExperience:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                showSpeExperienceError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },

        /// Select Software skills
        addPreferedSoftwareSkillchips: (e) {
          if (e.selectedValue.trim().isNotEmpty &&
              !e.selectedValue.toLowerCase().contains("other") &&
              (state.requiredSoftwareSkillChipList.getValue().isEmpty ||
                  !state.requiredSoftwareSkillChipList
                      .getValue()
                      .contains(e.selectedValue))) {
            emit(
              state.copyWith(
                requiredSoftwareSkillChipList: ListInputEmptyOrNot(List.from(
                    state.requiredSoftwareSkillChipList.getValue()
                      ..add(e.selectedValue))),
                requiredSoftwareSkillChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                softwareSkillOther: (e.isOtherValue == true)
                    ? (List<String>.from(state.softwareSkillOther)
                      ..add(e.selectedValue))
                    : [],
                showSoftwareSkillError: false,
                authFailureOrSuccessOption: none(),
              ),
            );
          }

          /// when click on add button
          else if ((state.requiredSoftwareSkillChip.toLowerCase() == "other" &&
              e.isOtherValue == true &&
              e.selectedValue.isEmpty)) {
            emit(
              state.copyWith(
                showSoftwareSkillError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }

          /// when select "other" value
          else {
            emit(
              state.copyWith(
                requiredSoftwareSkillChipList: ListInputEmptyOrNot(
                    List.from(state.requiredSoftwareSkillChipList.getValue())),
                requiredSoftwareSkillChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                showSoftwareSkillError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        removePreferedSoftwareSkillchips: (e) {
          /*emit(
            state.copyWith(
              requiredSoftwareSkillChipList: ListInputEmptyOrNot(List.from(
                  state.requiredSoftwareSkillChipList.getOrCrash()
                    ..remove(e.selectedValue))),
              requiredSoftwareSkillChip: "",
              softwareSkillOther:
                  (state.softwareSkillOther.contains(e.selectedValue))
                      ? (List<String>.from(state.softwareSkillOther)
                        ..remove(e.selectedValue))
                      : state.softwareSkillOther,
              showSoftwareSkillError:
                  (state.requiredSoftwareSkillChipList.getValue().isNotEmpty)
                      ? false
                      : true,
              authFailureOrSuccessOption: none(),
            ),
          );*/

          emit(
            state.copyWith(
              requiredSoftwareSkillChipList: ListInputEmptyOrNot(
                List.from(
                  List.of(state.requiredSoftwareSkillChipList.getValue())
                    ..remove(e.selectedValue),
                ),
              ),
              softwareSkillOther: List.of(state.softwareSkillOther)
                ..remove(e.selectedValue),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Select Language
        addLanguageChips: (e) {
          if (e.selectedLanguage.trim().isNotEmpty &&
              !e.selectedLanguage.toLowerCase().contains("other") &&
              (state.languageChipList.getValue().isEmpty ||
                  !state.languageChipList
                      .getValue()
                      .contains(e.selectedLanguage))) {
            emit(
              state.copyWith(
                languageChipList: ListInputEmptyOrNot(List.from(
                    state.languageChipList.getValue()
                      ..add(e.selectedLanguage))),
                showLanguageError: false,
                languageChip:
                    (e.isOtherValue == true) ? "" : e.selectedLanguage,
                languageOther: (e.isOtherValue == true)
                    ? (List<String>.from(state.languageOther)
                      ..add(e.selectedLanguage))
                    : [],
                authFailureOrSuccessOption: none(),
              ),
            );
          } else if ((state.languageChip.toLowerCase() == "other" &&
              e.isOtherValue == true &&
              e.selectedLanguage.isEmpty)) {
            emit(
              state.copyWith(
                showLanguageError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                languageChipList: ListInputEmptyOrNot(
                    List.from(state.languageChipList.getValue())),
                languageChip:
                    (e.isOtherValue == true) ? "" : e.selectedLanguage,
                showLanguageError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        removeLanguageChips: (e) {
          /*emit(
            state.copyWith(
              languageChipList: ListInputEmptyOrNot(List.from(
                  state.languageChipList.getOrCrash()
                    ..remove(e.selectedLanguage))),
              languageChip: "",
              languageOther: (state.languageOther.contains(e.selectedLanguage))
                  ? (List<String>.from(state.languageOther)
                    ..remove(e.selectedLanguage))
                  : state.languageOther,
              showLanguageError:
                  (state.languageChipList.getValue().isNotEmpty) ? false : true,
              authFailureOrSuccessOption: none(),
            ),
          );*/

          emit(
            state.copyWith(
              languageChipList: ListInputEmptyOrNot(
                List.from(
                  List.of(state.languageChipList.getValue())
                    ..remove(e.selectedLanguage),
                ),
              ),
              languageOther: List.of(state.languageOther)
                ..remove(e.selectedLanguage),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Click Continue Button
        continueBtnPressed: (e) async {
          print("OTher Skill type value2222--->  ${state.softwareSkillOther}");
          print(
              "OTher Language type value3333--->  ${state.languageOther.join(',')}");
          Either<AuthFailure, String>? failureOrSuccess;

          final roleTypeListValid = state.roleTypeChipList.isValid();
          final languageListValid = state.languageChipList.isValid();
          final softwareSkillListValid =
              state.requiredSoftwareSkillChipList.isValid();
          final specialityListValid =
              state.requiredSpecialityChipList.isValid();

          print(
              "ROLE ALL !-------->  ${roleTypeListValid} ${state.showRoleTypeError}");
          print(
              "SPECIALITY ALL !-------->  ${specialityListValid} ${state.showSpecialityError}");
          print(
              "SOFTWARE ALL !-------->  ${softwareSkillListValid} ${state.showSoftwareSkillError}");
          print(
              "LANGUAGE ALL !-------->  ${state.languageChipList.getValue()} ${state.showLanguageError}");
          print(
              "EXPERIENCE ALL !-------->  ${specialityListValid} ${state.showSpeExperienceError}");

          if (roleTypeListValid &&
                  (languageListValid || state.languageOther.isNotEmpty) &&
                  (softwareSkillListValid ||
                      state.softwareSkillOther.isNotEmpty) &&
                  (specialityListValid || state.specialityOther.isNotEmpty)
              // !state.showRoleTypeError &&
              // !state.showSpecialityError &&
              // !state.showSoftwareSkillError &&
              // !state.showLanguageError &&
              // !state.showSpeExperienceError
              ) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _authFacade.completeProfileAPI(
              rolesListId: getSelectedRoleIds(),
              // specialtiesDetail: getSelectedSpecialityIdsAsJson(),
              specialtiesDetail: getSelectedSpecialityIds(),
              specialityOther: state.specialityOther.join(','),
              softwaresSkillListId: getSelectedSoftwareIds(),
              softwareSkillOther: state.softwareSkillOther.join(','),
              languageListId: getSelectedLanguageId(),
              languageOther: state.languageOther.join(','),
            );
            // print("ALL DETAILS ARE VALID!----> ");
            // print("Role id--> ${getSelectedRoleIds()} ");
            // print("Skill id--> ${getSelectedSoftwareIds()}");
            // print("Skill other--> ${state.softwareSkillOther.join(',')}");
            // print("language id--> ${getSelectedLanguageId()} ");
            // print("language other--> ${state.languageOther.join(',')} ");
          } else {
            print("Some DETAILS ARE INVALID!");
          }
          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }

  int getExperienceIdFromName(
    String name,
  ) {
    for (var experience in state.experienceList) {
      if (experience.name == name) {
        return experience.id ?? -1;
      }
    }
    return -1;
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
              orElse: () =>
                  const SkillDTO(), // Handle cases where no match is found
            ))
        .where((language) => language.id != null) // Filter out null values
        .map((language) => language.id) // Extract IDs
        .toList();
    String commaSeparated = languageIds.join(',');
    print("Language Ids--> ${commaSeparated}");
    return commaSeparated;
  }

  String getSelectedRoleIds() {
    final roleIds = state.roleTypeChipList
        .getValue()
        .map((chipName) => state.roleList.firstWhere(
              (role) => role.name == chipName,
              orElse: () => SkillDTO(), // Handle cases where no match is found
            ))
        .where((role) => role.id != null) // Filter out null values
        .map((role) => role.id) // Extract IDs
        .toList();
    String commaSeparated = roleIds.join(',');
    print('Role IDs: $commaSeparated');
    return commaSeparated;
  }

  List<SpecialityDTO?> getSelectedSpecialtiyIds() {
    print('Spciality IDs=====: ${state.requiredSpecialityChipList}');
    final specialityIds = state.requiredSpecialityChipList
        .getValue()
        .map((chipName) {
          final speciality = state.specialityList.firstWhere(
            (speciality) => (speciality.name == chipName.name),
            orElse: () => SpecialityDTO(
              id: null,
              name: '',
              shortName: '',
              experienceId: null,
              specialityExperience: '',
            ),
          );

          return SpecialityDTO(
            id: speciality.id,
            // name: speciality.name,
            name: speciality.id == null ? '' : speciality.name,
            shortName: speciality.shortName,
            experienceId: chipName.experienceId,
            specialityExperience: "",
            specialityOther: speciality.id == null ? chipName.name : null,
          );
        })
        .where((speciality) =>
            (speciality.id != null || speciality.specialityOther != null))
        .toList();

    print('Spciality IDs: $specialityIds');
    return specialityIds;
  }

  List<Map<String, dynamic>> mapSpecialityDTOToApiFormat(
      List<SpecialityDTO?> specialities) {
    return specialities.map((speciality) {
      return {
        'specialtie_lists_id': speciality?.id,
        'specialtie_lists_other': speciality?.specialityOther,
        'experience_lists_id': speciality?.experienceId,
        'experience_other': speciality?.specialityExperience,
      };
    }).toList();
  }

  String getSelectedSpecialityIdsAsJson() {
    final selectedSpecialities = getSelectedSpecialtiyIds();
    final apiFormattedList = mapSpecialityDTOToApiFormat(selectedSpecialities);
    return jsonEncode(apiFormattedList);
  }

  String getSelectedSoftwareIds() {
    final softwareIds = state.requiredSoftwareSkillChipList
        .getValue()
        .map((chipName) => state.softwareList.firstWhere(
              (software) => software.name == chipName,
              orElse: () => SkillDTO(), // Handle cases where no match is found
            ))
        .where((software) => software.id != null) // Filter out null values
        .map((software) => software.id) // Extract IDs
        .toList();
    String commaSeparated = softwareIds.join(',');
    print('Software IDs: $commaSeparated');

    return commaSeparated;
  }

  String getSelectedSpecialityIds() {
    final specialityIds = state.requiredSpecialityChipList
        .getValue()
        .map((chipName) => state.specialityList.firstWhere(
              (speciality) => speciality.name == chipName,
              orElse: () =>
                  SpecialityDTO(), // Handle cases where no match is found
            ))
        .where((speciality) => speciality.id != null) // Filter out null values
        .map((speciality) => speciality.id) // Extract IDs
        .toList();
    String commaSeparated = specialityIds.join(',');
    print('Speciality IDs: $commaSeparated');

    return commaSeparated;
  }

  getContractorSkillAPI(Emitter<AddContractorSkillFormState> emit) async {
    try {
      emit(
        state.copyWith(isLoading: true),
      );
      final failureOrSuccess = await repository.getCurrentUserApi();
      failureOrSuccess.fold(
        (l) => emit(
          state.copyWith(
            isLoading: false,
          ),
        ),
        (r) {
          print(
              "Current user complete profile----> ${r.complete_profile?.specialties_detail}");
          return emit(
            state.copyWith(
              isLoading: false,
              roleTypeChipList: ListInputEmptyOrNot(
                  (r.complete_profile != null &&
                          r.complete_profile!.roles_list != null)
                      ? r.complete_profile!.roles_list!
                          .map((element) => element.name ?? "")
                          .toList()
                      : []),
              requiredSoftwareSkillChipList: ListInputEmptyOrNot(
                  (r.complete_profile != null &&
                          r.complete_profile?.softwares_skill_list != null)
                      ? r.complete_profile!.softwares_skill_list!
                          .map((element) => element.name ?? "")
                          .toList()
                      : []),
              softwareSkillOther:
                  r.complete_profile?.software_skill_other?.split(',') ?? [],
              requiredSpecialityChipList: ListInputEmptyOrNot(
                  (r.complete_profile != null &&
                          r.complete_profile!.specialties_detail != null)
                      ? r.complete_profile!.specialties_detail!
                          .where((element) => element.role != null)
                          .map((element) => element.role?.name ?? "")
                          .toList()
                      : []),
              specialityOther: (r.complete_profile != null &&
                      r.complete_profile!.specialties_detail != null)
                  ? r.complete_profile!.specialties_detail!
                      .where(
                          (element) => element.specialtie_lists_other != null)
                      .map((element) => element.specialtie_lists_other ?? "")
                      .toList()
                  : [],
              // r.complete_profile?.specialties_other?.split(',') ?? [],
              languageChipList: ListInputEmptyOrNot(
                  (r.complete_profile != null &&
                          r.complete_profile!.languages_list != null)
                      ? r.complete_profile!.languages_list!
                          .map((element) => element.name ?? "")
                          .toList()
                      : []),
              languageOther: (r.complete_profile != null &&
                      r.complete_profile!.language_other != null)
                  ? r.complete_profile!.language_other?.split(',') ?? []
                  : [],
            ),
          );
        },
      );
    } catch (e) {
      print("Current user ERRORRR--> ${e}");
    }
  }

  getRoleListApi(Emitter<AddContractorSkillFormState> emit) async {
    final roleList = await _authFacade.getRoleList();
    print("Role List ---> ${roleList}");
    roleList.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          roleList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            // isLoading: false,
            roleList: List.from(state.roleList)..addAll(r),
          ),
        );
      },
    );
  }

  getExperienceListApi(Emitter<AddContractorSkillFormState> emit) async {
    final experienceList = await _authFacade.getExperienceList();
    print("Experience List ---> ${experienceList}");
    experienceList.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          experienceList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            // isLoading: false,
            experienceList: List.from(state.experienceList)..addAll(r),
          ),
        );
      },
    );
  }

  getSpecialityListApi(Emitter<AddContractorSkillFormState> emit) async {
    final specialityList = await _authFacade.getSpecialityList();
    print("Speciality List ---> ${specialityList}");
    specialityList.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          specialityList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            // isLoading: false,
            specialityList: List.from(state.specialityList)..addAll(r),
          ),
        );
      },
    );
  }

  getSoftwareListApi(Emitter<AddContractorSkillFormState> emit) async {
    final softwareList = await _authFacade.getSoftwareSkillList();
    print("Software List ---> ${softwareList}");
    softwareList.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          softwareList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            isLoading: false,
            softwareList: List.from(state.softwareList)..addAll(r),
          ),
        );
      },
    );
  }

  getLanguageListApi(Emitter<AddContractorSkillFormState> emit) async {
    final languageList = await _authFacade.getLanguageList();
    print("Language List ---> ${languageList}");
    languageList.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          languageList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            // isLoading: false,
            languageList: List.from(state.languageList)..addAll(r),
          ),
        );
      },
    );
  }
}
