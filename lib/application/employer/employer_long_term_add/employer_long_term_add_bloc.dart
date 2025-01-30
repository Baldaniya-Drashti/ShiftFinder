import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/core/speciality/speciality_dto.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';

part 'employer_long_term_add_event.dart';

part 'employer_long_term_add_state.dart';

part 'employer_long_term_add_bloc.freezed.dart';

@injectable
class EmployerLongTermAddBloc extends Bloc<EmployerLongTermAddEvent, EmployerLongTermAddState> {
  final IAuthFacade _authFacade;
  final IAccountRepository _repository;
  final IMainFacade _mainFacade;

  EmployerLongTermAddBloc(this._authFacade, this._repository, this._mainFacade) : super(EmployerLongTermAddState.initial()) {
    on<EmployerLongTermAddEvent>((event, emit) async {
      await event.map(
        confirmSoftwareSkill: (e) {
          emit(state.copyWith(
            requiredSoftwareSkillChipList: ListInputEmptyOrNot(e.skillList),
            softwareSkillOther: e.otherSkillList,
            authFailureOrSuccessOption: none(),
          ));
        },
        confirmSpecialityList: (e) {
          emit(state.copyWith(
            requiredSpecialityChipList: ListInputEmptyOrNot(e.specialityList),
            specialityOther: e.otherSpecialityList,
            authFailureOrSuccessOption: none(),
          ));
        },
        confirmLanguageList: (e) {
          emit(state.copyWith(
            languageChipList: ListInputEmptyOrNot(e.languageList),
            languageOther: e.otherLanguageList,
            authFailureOrSuccessOption: none(),
          ));
          print("selected language list---> ${state.languageChipList} \n other languages ${state.languageOther}");
        },

        /// GET ALL DROPDOWN LIST FROM API
        getAllDropDownList: (e) async {
          // Either<AuthFailure, SkillListDTO>? res;
          emit(
            state.copyWith(
              isLoading: true,
              authFailureOrSuccessOption: none(),
              postId: e.postId,
            ),
          );
          if (e.postId != -1) {
            await getShiftDetailApi(emit, e.postId);
          }
          await getRoleListApi(emit);
          await getLocationListApi(emit);
          await getSpecialityListApi(emit);
          await getLanguageListApi(emit);
          await getSoftwareListApi(emit);
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
                  !state.requiredSpecialityChipList.getValue().contains(e.selectedValue))) {
            emit(
              state.copyWith(
                requiredSpecialityChipList:
                    ListInputEmptyOrNot(List.from(state.requiredSpecialityChipList.getValue()..add(e.selectedValue))),
                requiredSpecialityChip: (e.isOtherValue == true) ? "" : e.selectedValue,
                specialityOther: (e.isOtherValue == true) ? (List<String>.from(state.specialityOther)..add(e.selectedValue)) : [],
                showSpecialityError: false,
                authFailureOrSuccessOption: none(),
              ),
            );
          }

          /// when click on add button
          else if ((state.requiredSpecialityChip.toLowerCase() == "other" && e.isOtherValue == true && e.selectedValue.isEmpty)) {
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
                requiredSpecialityChipList: ListInputEmptyOrNot(List.from(state.requiredSpecialityChipList.getValue())),
                requiredSpecialityChip: (e.isOtherValue == true) ? "" : e.selectedValue,
                showSpecialityError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        removeRequiredSpecialitichips: (e) {
          /*emit(
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
          );*/
          emit(
            state.copyWith(
              requiredSpecialityChipList: ListInputEmptyOrNot(
                List.from(
                  List.of(state.requiredSpecialityChipList.getValue())..remove(e.selectedValue),
                ),
              ),
              specialityOther: List.of(state.specialityOther)..remove(e.selectedValue),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Select Software skills
        addPreferedSoftwareSkillchips: (e) {
          if (e.selectedValue.trim().isNotEmpty &&
              !(e.selectedValue.toLowerCase() == "other") &&
              (state.requiredSoftwareSkillChipList.getValue().isEmpty ||
                  !state.requiredSoftwareSkillChipList.getValue().contains(e.selectedValue))) {
            emit(
              state.copyWith(
                requiredSoftwareSkillChipList:
                    ListInputEmptyOrNot(List.from(state.requiredSoftwareSkillChipList.getValue()..add(e.selectedValue))),
                requiredSoftwareSkillChip: (e.isOtherValue == true) ? "" : e.selectedValue,
                softwareSkillOther: (e.isOtherValue == true) ? (List<String>.from(state.softwareSkillOther)..add(e.selectedValue)) : [],
                showSoftwareSkillError: false,
                authFailureOrSuccessOption: none(),
              ),
            );
          }

          /// when click on add button
          else if ((state.requiredSoftwareSkillChip.toLowerCase() == "other" && e.isOtherValue == true && e.selectedValue.isEmpty)) {
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
                requiredSoftwareSkillChipList: ListInputEmptyOrNot(List.from(state.requiredSoftwareSkillChipList.getValue())),
                requiredSoftwareSkillChip: (e.isOtherValue == true) ? "" : e.selectedValue,
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
              showSoftwareSkillError: false,
              authFailureOrSuccessOption: none(),
            ),
          );*/
          emit(
            state.copyWith(
              requiredSoftwareSkillChipList: ListInputEmptyOrNot(
                List.from(
                  List.of(state.requiredSoftwareSkillChipList.getValue())..remove(e.selectedValue),
                ),
              ),
              softwareSkillOther: List.of(state.softwareSkillOther)..remove(e.selectedValue),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Select Language
        addLanguageChips: (e) {
          if (e.selectedLanguage.isNotEmpty &&
              !e.selectedLanguage.toLowerCase().contains("other") &&
              (state.languageChipList.getValue().isEmpty || !state.languageChipList.getValue().contains(e.selectedLanguage))) {
            emit(
              state.copyWith(
                languageChipList: ListInputEmptyOrNot(List.from(state.languageChipList.getValue()..add(e.selectedLanguage))),
                showLanguageError: false,
                languageChip: (e.isOtherValue == true) ? "" : e.selectedLanguage,
                languageOther: (e.isOtherValue == true) ? (List<String>.from(state.languageOther)..add(e.selectedLanguage)) : [],
                authFailureOrSuccessOption: none(),
              ),
            );
          } else if ((state.languageChip.toLowerCase() == "other" && e.isOtherValue == true && e.selectedLanguage.isEmpty)) {
            emit(
              state.copyWith(
                showLanguageError: true,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                languageChipList: ListInputEmptyOrNot(List.from(state.languageChipList.getValue())),
                languageChip: (e.isOtherValue == true) ? "" : e.selectedLanguage,
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
                  List.of(state.languageChipList.getValue())..remove(e.selectedLanguage),
                ),
              ),
              languageOther: List.of(state.languageOther)..remove(e.selectedLanguage),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// LOCATION
        locationChanged: (e) {
          final selectedLocationObject = state.locationList.firstWhere(
            (location) => location.location == e.selectedValue,
            orElse: () => LocationDTO(),
          );

          print("Location---- > ${selectedLocationObject.add_units}");

          emit(
            state.copyWith(
              location: InputEmptyOrNot(selectedLocationObject.location ?? ""),
              unitList: selectedLocationObject.add_units ?? [],
              selectedLocationUnit: "",
              showLocationError: (selectedLocationObject.add_units != null && selectedLocationObject.add_units!.isNotEmpty) ? true : false,
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
              rateHour: Rate(e.rateHour),
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

          if (
              // !state.showSoftwareSkillError &&
              roleTypeListValid &&
                  (languageListValid || state.languageOther.isNotEmpty) &&
                  !state.showRoleTypeError &&
                  // !state.showLanguageError &&
                  // !state.showSpeExperienceError &&
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
              rate_hour: double.parse(state.rateHour.getValue()),
            );

            print("Role id--> ${getSelectedRoleIds()} ");
            print("Speciality id--> ${getSelectedSpecialtiyIds()} ");
            print("Speciality Other--> ${state.specialityOther.join(',')} ");
            print("Skill id--> ${getSelectedSoftwareIds()}");
            print("Skill other--> ${state.softwareSkillOther.join(',')}");
            print("language id--> ${getSelectedLanguageId()} ");
            print("language other--> ${state.languageOther.join(',')} ");

            // e.context.router
            //     .push(PageRouteInfo(
            //   HealthcarePostShift.name,
            //   args: HealthcarePostShiftArgs(
            //       postId: -1,
            //       post: post,
            //       updateShift: state.updatePost,
            //       fromSaveTemplate: e.fromSaveTemplate
            //   ),
            // ))
            //     .then((value) {
            //   AppFocus.unfocus(e.context);
            // });


            print("post=> ${post.toJson()}");

            e.context.router.push(
              PageRouteInfo(
                EmployerLongTermPositionAddDetailView.name,
                args: EmployerLongTermPositionAddDetailViewArgs(
                  postShiftDTO: post,
                  employer: state.updatePost,
                  postId: state.postId,
                ),
              ),
            );

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
            showError(message: StringConstant.someDetailsAreMissingOrInvalidPleaseCheck).show(e.context);
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

  String getSelectedRoleIds() {
    final roleIds = state.roleList.firstWhere((role) => role.name == state.roleType.getValue(), orElse: () => SkillDTO());
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
    final locationIds =
        state.locationList.firstWhere((location) => location.location == state.location.getValue(), orElse: () => LocationDTO());
    print("Location ID --> $locationIds");
    return "${locationIds.id ?? -1}";
  }

  getShiftDetailApi(Emitter<EmployerLongTermAddState> emit, int postId) async {
    Either<MainFailure, CommonResponse> failureOrSuccess = await _mainFacade.getEmployerPositionDetail(
      postType: 1,
      id: postId,
    );
    failureOrSuccess.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
        ),
      ),
      (r) {
        final data = EmployerLongTermSuccessDto.fromJson(r.data);
        print("kkkkkk${data.job_description}");
        emit(
          state.copyWith(
            updatePost: data,
            roleType: InputEmptyOrNot(data.roles_list_name ?? ""),
            requiredSoftwareSkillChipList: ListInputEmptyOrNot(
                (data.softwares_skill_list != null) ? data.softwares_skill_list!.map((element) => element.name ?? "").toList() : []),
            softwareSkillOther: data.software_skill_other?.split(',') ?? [],
            requiredSpecialityChipList: ListInputEmptyOrNot(
                (data.specialties_detail_list != null) ? data.specialties_detail_list!.map((element) => element.name ?? "").toList() : []),
            specialityOther: data.specialties_detail_other?.split(',') ?? [],
            languageChipList: ListInputEmptyOrNot(
                (data.languages_list != null) ? data.languages_list!.map((element) => element.name ?? "").toList() : []),
            languageOther: data.language_other?.split(',') ?? [],
            location: InputEmptyOrNot((data.location != null) ? data.location!.location ?? "" : ""),
            locationObj: data.location ?? LocationDTO(),
            unitList: (data.location != null) ? data.location?.add_units ?? [] : [],
            selectedLocationUnit: data.location_unit ?? "",
            rateHour: Rate((data.rate_hour != null) ? "${data.rate_hour ?? ""}" : ""),
          ),
        );
        print("=>updatePostCreate ${state.updatePost.job_description}");
      },
    );
  }

  getRoleListApi(Emitter<EmployerLongTermAddState> emit) async {
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

  getLocationListApi(Emitter<EmployerLongTermAddState> emit) async {
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

  getSpecialityListApi(Emitter<EmployerLongTermAddState> emit) async {
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

  getSoftwareListApi(Emitter<EmployerLongTermAddState> emit) async {
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

  getLanguageListApi(Emitter<EmployerLongTermAddState> emit) async {
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
