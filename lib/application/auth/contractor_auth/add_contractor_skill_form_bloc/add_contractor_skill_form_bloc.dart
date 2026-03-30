// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
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
            (l) => emit(state.copyWith(isLoading: false)),
            (r) {
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
                  initialRoleTypeChipList: ListInputEmptyOrNot(
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
                      r.complete_profile?.software_skill_other?.split(',') ??
                          [],
                  requiredSpecialityChipList: ListInputEmptyOrNot(
                      (r.complete_profile != null &&
                              r.complete_profile!.specialties_detail != null)
                          ? r.complete_profile!.specialties_detail!
                              .map((element) => element.name ?? "")
                              .toList()
                          : []),
                  initialSpecialityTypeChipList: ListInputEmptyOrNot(
                      (r.complete_profile != null &&
                              r.complete_profile!.specialties_detail != null)
                          ? r.complete_profile!.specialties_detail!
                              .map((element) => element.name ?? "")
                              .toList()
                          : []),
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

          emit(
            state.copyWith(
              isLoading: false,
            ),
          );
        },
        confirmSpecialityList: (e) {
          bool isChanged = !listEquals(
            List.from(state.initialSpecialityTypeChipList.getValue())..sort(),
            List.from(e.specialityList)..sort(),
          );

          emit(state.copyWith(
            requiredSpecialityChipList: ListInputEmptyOrNot(e.specialityList),
            specialityOther: e.otherSpecialityList,
            isSpecialityListUpdated: isChanged,
            authFailureOrSuccessOption: none(),
          ));
        },
        confirmRoleList: (e) {
          bool isChanged = !listEquals(
            List.from(state.initialRoleTypeChipList.getValue())..sort(),
            List.from(e.roleList)..sort(),
          );

          emit(state.copyWith(
            roleTypeChipList: ListInputEmptyOrNot(e.roleList),

            /// Check role is updated or not
            isRoleListUpdated: isChanged,
            authFailureOrSuccessOption: none(),
          ));
        },
        confirmSoftwareSkill: (e) {
          emit(state.copyWith(
            requiredSoftwareSkillChipList: ListInputEmptyOrNot(e.skillList),
            softwareSkillOther: e.otherSkillList,
            authFailureOrSuccessOption: none(),
          ));
        },
        confirmLanguageList: (e) {
          emit(state.copyWith(
            languageChipList: ListInputEmptyOrNot(e.languageList),
            languageOther: e.otherLanguageList,
            authFailureOrSuccessOption: none(),
          ));
        },

        /// GET ALL DROPDOWN LIST FROM API
        getAllDropDownList: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              authFailureOrSuccessOption: none(),
            ),
          );

          await getRoleListApi(emit);
          await getSpecialityListApi(emit);
          await getExperienceListApi(emit);
          await getLanguageListApi(emit);
          await getSoftwareListApi(emit);
          if (e.isUpdate == true) {
            await getContractorSkillAPI(emit);
          }
        },

        /// ROLE TYPE
        addRoleTypeChips: (e) {
          /* if ((state.roleTypeChipList.getValue().isEmpty ||
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
          } */
        },
        removeRoleTypeChips: (e) {
          final updatedList = List.of(state.roleTypeChipList.getValue())
            ..remove(e.roleType);

          bool isChanged = !listEquals(
            List.from(state.initialRoleTypeChipList.getValue())..sort(),
            List.from(updatedList)..sort(),
          );
          emit(
            state.copyWith(
              roleTypeChipList: ListInputEmptyOrNot(
                List.from(updatedList),
              ),
              isRoleListUpdated: isChanged,
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Select Specialities
        addRequiredSpecialitichips: (e) {
          if (e.selectedValue.trim().isNotEmpty &&
              !(e.selectedValue.toLowerCase() == "other") &&
              (state.requiredSpecialityChipList.getValue().isEmpty ||
                  !state.requiredSpecialityChipList.getValue().any(
                      (speciality) => speciality.name == e.selectedValue))) {
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
          final updatedList =
              List.of(state.requiredSpecialityChipList.getValue())
                ..remove(e.selectedValue);

          bool isChanged = !listEquals(
            List.from(state.initialSpecialityTypeChipList.getValue())..sort(),
            List.from(updatedList)..sort(),
          );

          /// For multi speciality
          emit(
            state.copyWith(
              requiredSpecialityChipList: ListInputEmptyOrNot(
                List.from(updatedList),
              ),
              isSpecialityListUpdated: isChanged,
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

          if (!(e.selectedValue.toLowerCase() == "other") &&
              (state.requiredSpecialityChipList.getValue().isNotEmpty)) {
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
          Either<AuthFailure, String>? failureOrSuccess;

          final roleTypeListValid = state.roleTypeChipList.isValid();
          final languageListValid = state.languageChipList.isValid();
          final softwareSkillListValid =
              state.requiredSoftwareSkillChipList.isValid();
          final specialityListValid =
              state.requiredSpecialityChipList.isValid();

          if (roleTypeListValid &&
              (languageListValid || state.languageOther.isNotEmpty) &&
              (softwareSkillListValid || state.softwareSkillOther.isNotEmpty) &&
              (specialityListValid || state.specialityOther.isNotEmpty)) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _authFacade.completeProfileAPI(
              rolesListId: getSelectedRoleIds(),
              specialtiesDetail: getSelectedSpecialityIds(),
              specialityOther: state.specialityOther.join(','),
              softwaresSkillListId: getSelectedSoftwareIds(),
              softwareSkillOther: state.softwareSkillOther.join(','),
              languageListId: getSelectedLanguageId(),
              languageOther: state.languageOther.join(','),
            );
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
    final languageIds = state.languageChipList
        .getValue()
        .map((chipName) => state.languageList.firstWhere(
              (language) => language.name == chipName,
              orElse: () => const SkillDTO(),
            ))
        .where((language) => language.id != null)
        .map((language) => language.id)
        .toList();
    String commaSeparated = languageIds.join(',');
    return commaSeparated;
  }

  String getSelectedRoleIds() {
    final roleIds = state.roleTypeChipList
        .getValue()
        .map((chipName) => state.roleList.firstWhere(
              (role) => role.name == chipName,
              orElse: () => SkillDTO(),
            ))
        .where((role) => role.id != null)
        .map((role) => role.id)
        .toList();
    String commaSeparated = roleIds.join(',');
    return commaSeparated;
  }

  List<SpecialityDTO?> getSelectedSpecialtiyIds() {
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
              orElse: () => SkillDTO(),
            ))
        .where((software) => software.id != null)
        .map((software) => software.id)
        .toList();
    String commaSeparated = softwareIds.join(',');

    return commaSeparated;
  }

  String getSelectedSpecialityIds() {
    final specialityIds = state.requiredSpecialityChipList
        .getValue()
        .map((chipName) => state.specialityList.firstWhere(
              (speciality) => speciality.name == chipName,
              orElse: () => SpecialityDTO(),
            ))
        .where((speciality) => speciality.id != null)
        .map((speciality) => speciality.id)
        .toList();
    String commaSeparated = specialityIds.join(',');

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
              initialRoleTypeChipList: ListInputEmptyOrNot(
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
              initialSpecialityTypeChipList: ListInputEmptyOrNot(
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
            roleList: List.from(state.roleList)..addAll(r),
          ),
        );
      },
    );
  }

  getExperienceListApi(Emitter<AddContractorSkillFormState> emit) async {
    final experienceList = await _authFacade.getExperienceList();

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
            experienceList: List.from(state.experienceList)..addAll(r),
          ),
        );
      },
    );
  }

  getSpecialityListApi(Emitter<AddContractorSkillFormState> emit) async {
    final specialityList = await _authFacade.getSpecialityList();

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
            specialityList: List.from(state.specialityList)..addAll(r),
          ),
        );
      },
    );
  }

  getSoftwareListApi(Emitter<AddContractorSkillFormState> emit) async {
    final softwareList = await _authFacade.getSoftwareSkillList();

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
            languageList: List.from(state.languageList)..addAll(r),
          ),
        );
      },
    );
  }
}
