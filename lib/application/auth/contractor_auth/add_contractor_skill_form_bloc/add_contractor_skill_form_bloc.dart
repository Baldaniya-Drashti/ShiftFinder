// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/infrastructure/core/common_list_dto.dart';
import 'package:shift/infrastructure/core/speciality/speciality_dto.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';

part 'add_contractor_skill_form_event.dart';
part 'add_contractor_skill_form_state.dart';
part 'add_contractor_skill_form_bloc.freezed.dart';

@injectable
class AddContractorSkillFormBloc
    extends Bloc<AddContractorSkillFormEvent, AddContractorSkillFormState> {
  AddContractorSkillFormBloc() : super(AddContractorSkillFormState.initial()) {
    on<AddContractorSkillFormEvent>((event, emit) {
      event.map(
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
        },
        removeRoleTypeChips: (e) {
          emit(
            state.copyWith(
              roleTypeChipList: ListInputEmptyOrNot(List.from(
                  state.roleTypeChipList.getOrCrash()..remove(e.roleType))),
              roleTypeChip: "",
              showRoleTypeError:
                  (state.roleTypeChipList.getValue().isNotEmpty) ? false : true,
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Select Specialities
        addRequiredSpecialitichips: (e) {
          // final updatedList = List<SpecialityDTO>.from(
          //     state.requiredSpecialityChipList.getValue());
          print("SELECT VALUEEEEE-->  ${e.selectedValue}");

          if (e.selectedValue.isNotEmpty &&
              !(e.selectedValue.toLowerCase() == "other") &&
              (state.requiredSpecialityChipList.getValue().isEmpty ||
                  !state.requiredSpecialityChipList.getValue().any(
                      (speciality) =>
                          speciality.specialityName == e.selectedValue))) {
            // updatedList.add(SpecialityDTO(specialityName: e.selectedValue));

            emit(
              state.copyWith(
                requiredSpecialityChipList: ListInputEmptyOrNot(
                    List.from(state.requiredSpecialityChipList.getValue())
                      ..add(SpecialityDTO(specialityName: e.selectedValue))),
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
          emit(
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
          );
        },

        /// Selected Speciality's Experience
        addSpecialityExperienceList: (e) {
          final updatedList = List<SpecialityDTO>.from(
              state.requiredSpecialityChipList.getValue());
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

            for (int i = 0; i < updatedList.length; i++) {
              if (i == e.currentIndex) {
                SpecialityDTO obj = SpecialityDTO(
                  specialityName: updatedList[i].specialityName,
                  specialityExperience: e.selectedValue,
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
          if (e.selectedValue.isNotEmpty &&
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
              requiredSoftwareSkillChipList: ListInputEmptyOrNot(List.from(
                  state.requiredSoftwareSkillChipList.getOrCrash()
                    ..remove(e.selectedValue))),
              requiredSoftwareSkillChip: "",
              showSoftwareSkillError:
                  (state.requiredSoftwareSkillChipList.getValue().isNotEmpty)
                      ? false
                      : true,
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Select Language
        addLanguageChips: (e) {
          if (e.selectedLanguage.isNotEmpty &&
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
              languageChipList: ListInputEmptyOrNot(List.from(
                  state.languageChipList.getOrCrash()
                    ..remove(e.selectedLanguage))),
              languageChip: "",
              showLanguageError:
                  (state.languageChipList.getValue().isNotEmpty) ? false : true,
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Click Continue Button
        continueBtnPressed: (e) {
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
              languageListValid &&
              softwareSkillListValid &&
              specialityListValid &&
              !state.showRoleTypeError &&
              !state.showSpecialityError &&
              !state.showSoftwareSkillError &&
              !state.showLanguageError &&
              !state.showSpeExperienceError) {
            print("ALL DETAILS ARE VALID!---->  ${getSelectedLanguageId()}");
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            // failureOrSuccess = await _authFacade.login(
            //   mobileNumber: EmailAddress(""),
            //   countryCode: '+${state.selectedCountrycode}',
            // );
            failureOrSuccess = right("sucess");
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

  List<int> getSelectedLanguageId() {
    List<int> outputIds = [];
    for (String title in state.languageChipList.getValue()) {
      for (ListDTO item in CommonList.languageList) {
        if (item.title == title) {
          outputIds.add(item.id ?? -1);
          break;
        }
      }
    }
    print("IDSSSSS----- ${outputIds}");
    return outputIds;
  }
}
