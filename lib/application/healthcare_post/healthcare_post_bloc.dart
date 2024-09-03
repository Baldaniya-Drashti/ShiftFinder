// import 'package:dartz/dartz.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:injectable/injectable.dart';
// import 'package:shift/domain/auth/auth_failure.dart';
// import 'package:shift/domain/auth/auth_value_objects.dart';
// part 'healthcare_post_event.dart';
// part 'healthcare_post_state.dart';
// part 'healthcare_post_bloc.freezed.dart';

// @injectable
// class HealthcarePostBloc
//     extends Bloc<HealthcarePostEvent, HealthcarePostState> {
//   HealthcarePostBloc() : super(HealthcarePostState.initial()) {
//     on<HealthcarePostEvent>((event, emit) {
//       event.map(
//         roleTypeChanged: (e) {
//           emit(
//             state.copyWith(
//               roleType: InputEmptyOrNot(e.roleType),
//             ),
//           );
//         },
//         locationChanged: (e) {
//           emit(
//             state.copyWith(
//               location: InputEmptyOrNot(e.location),
//               authFailureOrSuccessOption: none(),
//             ),
//           );
//         },
//         locationUnitSelectionChanged: (e) {
//           emit(
//             state.copyWith(
//               selectedLocationUnit: e.selectedUnit,
//               authFailureOrSuccessOption: none(),
//             ),
//           );
//         },
//         rateHourChanged: (e) {
//           emit(
//             state.copyWith(
//               rateHour: InputEmptyOrNot(e.rateHour),
//               authFailureOrSuccessOption: none(),
//             ),
//           );
//         },
//         selectedLanguageChanged: (e) {
//           emit(
//             state.copyWith(
//               selectedLanguage: InputEmptyOrNot(e.language),
//             ),
//           );
//         },
//         addRequiredSpecialitichips: (e) {
//           if (!(e.selectedValue.toLowerCase() == "other") &&
//               (state.requiredSpecialityChipList.isEmpty ||
//                   !state.requiredSpecialityChipList
//                       .contains(e.selectedValue))) {
//             emit(
//               state.copyWith(
//                 requiredSpecialityChipList:
//                     List.from(state.requiredSpecialityChipList)
//                       ..add(e.selectedValue),
//                 requiredSpecialityChip:
//                     (e.isOtherValue == true) ? "" : e.selectedValue,
//                 authFailureOrSuccessOption: none(),
//               ),
//             );
//           } else {
//             emit(
//               state.copyWith(
//                 requiredSpecialityChipList:
//                     List.from(state.requiredSpecialityChipList),
//                 requiredSpecialityChip:
//                     (e.isOtherValue == true) ? "" : e.selectedValue,
//                 authFailureOrSuccessOption: none(),
//               ),
//             );
//           }
//         },
//         removeRequiredSpecialitichips: (e) {
//           emit(
//             state.copyWith(
//               requiredSpecialityChipList:
//                   List.from(state.requiredSpecialityChipList)
//                     ..remove(e.selectedValue),
//               requiredSpecialityChip: "",
//               authFailureOrSuccessOption: none(),
//             ),
//           );
//         },
//         addPreferedSoftwareSkillchips: (e) {
//           if (e.selectedValue.isNotEmpty &&
//               !(e.selectedValue.toLowerCase() == "other") &&
//               (state.requiredSoftwareSkillChipList.isEmpty ||
//                   !state.requiredSoftwareSkillChipList
//                       .contains(e.selectedValue))) {
//             emit(
//               state.copyWith(
//                 requiredSoftwareSkillChipList:
//                     List.from(state.requiredSoftwareSkillChipList)
//                       ..add(e.selectedValue),
//                 requiredSoftwareSkillChip:
//                     (e.isOtherValue == true) ? "" : e.selectedValue,
//                 authFailureOrSuccessOption: none(),
//               ),
//             );
//           } else {
//             emit(
//               state.copyWith(
//                 requiredSoftwareSkillChipList:
//                     List.from(state.requiredSoftwareSkillChipList),
//                 requiredSoftwareSkillChip:
//                     (e.isOtherValue == true) ? "" : e.selectedValue,
//                 authFailureOrSuccessOption: none(),
//               ),
//             );
//           }
//         },
//         removePreferedSoftwareSkillchips: (e) {
//           emit(
//             state.copyWith(
//               requiredSoftwareSkillChipList:
//                   List.from(state.requiredSoftwareSkillChipList)
//                     ..remove(e.selectedValue),
//               requiredSoftwareSkillChip: "",
//               authFailureOrSuccessOption: none(),
//             ),
//           );
//         },
//         continueBtnPressed: (e) {
//           Either<AuthFailure, String>? failureOrSuccess;
//           final isLocationValid = state.location.isValid();
//           final isRateHourValid = state.rateHour.isValid();
//           final roleType = state.roleType.isValid();
//           final language = state.selectedLanguage.isValid();

//           if (roleType && language && isLocationValid && isRateHourValid) {
//             emit(
//               state.copyWith(
//                 isSubmitting: true,
//                 authFailureOrSuccessOption: none(),
//               ),
//             );
//             // failureOrSuccess = await _authFacade.login(
//             //   mobileNumber: EmailAddress(""),
//             //   countryCode: '+${state.selectedCountrycode}',
//             // );
//             failureOrSuccess = right("sucess");
//           }
//           emit(
//             state.copyWith(
//               isSubmitting: false,
//               showErrorMessages: true,
//               authFailureOrSuccessOption: optionOf(failureOrSuccess),
//             ),
//           );
//         },
//       );
//     });
//   }
// }

// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors, unused_field, unused_local_variable

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/core/speciality/speciality_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
part 'healthcare_post_event.dart';
part 'healthcare_post_state.dart';
part 'healthcare_post_bloc.freezed.dart';

@injectable
class HealthcarePostBloc
    extends Bloc<HealthcarePostEvent, HealthcarePostState> {
  final IAuthFacade _authFacade;
  final IAccountRepository _repository;
  final IMainFacade _mainFacade;

  HealthcarePostBloc(this._authFacade, this._repository, this._mainFacade)
      : super(HealthcarePostState.initial()) {
    on<HealthcarePostEvent>((event, emit) async {
      await event.map(
        /// GET ALL DROPDOWN LIST FROM API
        getAllDropDownList: (e) async {
          // Either<AuthFailure, SkillListDTO>? res;
          emit(
            state.copyWith(
              isLoading: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          await getRoleListApi(emit);
          await getLocationListApi(emit);
          await getSpecialityListApi(emit);
          await getSoftwareListApi(emit);
          await getLanguageListApi(emit);
        },

        /// ROLE TYPE
        roleTypeChanged: (e) {
          emit(
            state.copyWith(
              roleType: InputEmptyOrNot(e.roleType),
            ),
          );
        },

        addRequiredSpecialitichips: (e) {
          if (e.selectedValue.trim().isNotEmpty &&
              !(e.selectedValue.toLowerCase() == "other") &&
              (state.requiredSpecialityChipList.getValue().isEmpty ||
                  !state.requiredSpecialityChipList
                      .getValue()
                      .contains(e.selectedValue))) {
            emit(
              state.copyWith(
                requiredSpecialityChipList: ListInputEmptyOrNot(List.from(
                    state.requiredSpecialityChipList.getValue()
                      ..add(e.selectedValue))),
                requiredSpecialityChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                specialityOther: (e.isOtherValue == true)
                    ? (List<String>.from(state.specialityOther)
                      ..add(e.selectedValue))
                    : [],
                showSpecialityError: false,
                authFailureOrSuccessOption: none(),
              ),
            );
          }

          /// when click on add button
          else if ((state.requiredSpecialityChip.toLowerCase() == "other" &&
              e.isOtherValue == true &&
              e.selectedValue.isEmpty)) {
            emit(
              state.copyWith(
                showSpecialityError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }

          /// when select "other" value
          else {
            emit(
              state.copyWith(
                requiredSpecialityChipList: ListInputEmptyOrNot(
                    List.from(state.requiredSpecialityChipList.getValue())),
                requiredSpecialityChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                showSpecialityError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        removeRequiredSpecialitichips: (e) {
          emit(
            state.copyWith(
              requiredSpecialityChipList: ListInputEmptyOrNot(List.from(
                  state.requiredSpecialityChipList.getOrCrash()
                    ..remove(e.selectedValue))),
              requiredSpecialityChip: "",
              specialityOther: (state.specialityOther.contains(e.selectedValue))
                  ? (List<String>.from(state.specialityOther)
                    ..remove(e.selectedValue))
                  : state.specialityOther,
              showSpecialityError: false,
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Select Software skills
        addPreferedSoftwareSkillchips: (e) {
          if (e.selectedValue.trim().isNotEmpty &&
              !(e.selectedValue.toLowerCase() == "other") &&
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
              requiredSoftwareSkillChipList: ListInputEmptyOrNot(List.from(
                  state.requiredSoftwareSkillChipList.getOrCrash()
                    ..remove(e.selectedValue))),
              requiredSoftwareSkillChip: "",
              softwareSkillOther:
                  (state.softwareSkillOther.contains(e.selectedValue))
                      ? (List<String>.from(state.softwareSkillOther)
                        ..remove(e.selectedValue))
                      : state.softwareSkillOther,
              showSoftwareSkillError: false,
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
          );
        },

        /// LOCATION
        locationChanged: (e) {
          print("Location---- > ${e.location}");
          final selectedLocationObject = state.locationList.firstWhere(
            (location) => location.location == e.location,
            orElse: () => LocationDTO(),
          );

          emit(
            state.copyWith(
              location: InputEmptyOrNot(e.location),
              unitList: selectedLocationObject.add_units ?? [],
              selectedLocationUnit: "",
              showLocationError: (selectedLocationObject.add_units != null &&
                      selectedLocationObject.add_units!.isNotEmpty)
                  ? true
                  : false,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationUnitSelectionChanged: (e) {
          emit(
            state.copyWith(
              selectedLocationUnit: e.selectedUnit,
              showLocationError: false,
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// RATE/HOUR
        rateHourChanged: (e) {
          emit(
            state.copyWith(
              rateHour: InputEmptyOrNot(e.rateHour),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Click Continue Button
        continueBtnPressed: (e) async {
          Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;
          final roleTypeListValid = state.roleType.isValid();
          final languageListValid = state.languageChipList.isValid();
          final isLocationValid = state.location.isValid();
          final isRateHourValid = state.rateHour.isValid();

          if ((!(state.requiredSpecialityChip.toLowerCase() == "other") &&
                  !state.showSpecialityError) &&
              !(state.requiredSoftwareSkillChip.toLowerCase() == "other") &&
              !state.showSoftwareSkillError &&
              roleTypeListValid &&
              languageListValid &&
              !state.showRoleTypeError &&
              !state.showLanguageError &&
              !state.showSpeExperienceError &&
              isLocationValid &&
              !state.showLocationError &&
              isRateHourValid) {
            print("ALL DETAILS ARE VALID!---->  ");
            PostShiftDTO post = PostShiftDTO(
              roles_list_id: getSelectedRoleIds(),
              specialties_detail_id: getSelectedSpecialtiyIds(),
              specialties_detail_other: state.specialityOther.join(','),
              softwares_skill_list_id: getSelectedSoftwareIds(),
              software_skill_other: state.softwareSkillOther.join(','),
              languages_list_id: getSelectedLanguageId(),
              language_other: state.languageOther.join(','),
              location_id: getSelectedLocationIds(),
              location_unit: state.selectedLocationUnit,
              rate_hour: double.parse(state.rateHour.getValue() ?? "0.0"),
            );

            e.context.router.push(PageRouteInfo(
              HealthcarePostShift.name,
              args: HealthcarePostShiftArgs(postId: -1, post: post),
            ));
            /*emit(
              state.copyWith(
                isLoading: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            failureOrSuccess = await _mainFacade.createPostApi(
              roleListId: getSelectedRoleIds(),
              specialityDetailId: getSelectedSpecialtiyIds(),
              specialityDetailOther: state.specialityOther.join(','),
              softwareSkillId: getSelectedSoftwareIds(),
              softwareSkillOther: state.softwareSkillOther.join(','),
              languageListId: getSelectedLanguageId(),
              languageOther: state.languageOther.join(','),
              locationId: getSelectedLocationIds(),
              locationUnit: state.selectedLocationUnit,
              rateHour: double.parse(state.rateHour.getValue() ?? "0.0"),
            );*/
          } else {
            print("SOME DETAILS ARE INVALID!");
          }
          // print("Failure or success--> ${failureOrSuccess}");
          emit(
            state.copyWith(
              isSubmitting: false,
              isLoading: false,
              showErrorMessages: true,
              // authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
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
    final roleIds = state.roleList.firstWhere(
        (role) => role.name == state.roleType.getValue(),
        orElse: () => SkillDTO());
    print("Role ID --> $roleIds");
    return "${roleIds.id ?? -1}";
  }

  String getSelectedSpecialtiyIds() {
    final specialityIds = state.requiredSpecialityChipList
        .getValue()
        .map((chipName) => state.specialityList.firstWhere(
              (speciality) => speciality.name == chipName,
              orElse: () => SpecialityDTO(),
            ))
        .where((speciality) => speciality.id != null)
        .map((specialtiy) => specialtiy.id)
        .toList();
    String commaSeparated = specialityIds.join(',');
    print('Speciality IDs: $commaSeparated');

    return commaSeparated;
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

  String getSelectedLocationIds() {
    final locationIds = state.locationList.firstWhere(
        (location) => location.location == state.location.getValue(),
        orElse: () => LocationDTO());
    print("Location ID --> $locationIds");
    return "${locationIds.id ?? -1}";
  }

  getRoleListApi(Emitter<HealthcarePostState> emit) async {
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

  getLocationListApi(Emitter<HealthcarePostState> emit) async {
    final locationList = await _repository.getLocationListApi();

    print("Location List ---> ${locationList}");
    locationList.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          locationList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            // isLoading: false,
            locationList: List.from(state.locationList)..addAll(r),
          ),
        );
      },
    );
  }

  getSpecialityListApi(Emitter<HealthcarePostState> emit) async {
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

  getSoftwareListApi(Emitter<HealthcarePostState> emit) async {
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

  getLanguageListApi(Emitter<HealthcarePostState> emit) async {
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
