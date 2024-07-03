import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
part 'healthcare_post_event.dart';
part 'healthcare_post_state.dart';
part 'healthcare_post_bloc.freezed.dart';

@injectable
class HealthcarePostBloc
    extends Bloc<HealthcarePostEvent, HealthcarePostState> {
  HealthcarePostBloc() : super(HealthcarePostState.initial()) {
    on<HealthcarePostEvent>((event, emit) {
      event.map(
        roleTypeChanged: (e) {
          emit(
            state.copyWith(
              roleType: InputEmptyOrNot(e.roleType),
            ),
          );
        },
        locationChanged: (e) {
          emit(
            state.copyWith(
              location: InputEmptyOrNot(e.location),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        rateHourChanged: (e) {
          emit(
            state.copyWith(
              rateHour: InputEmptyOrNot(e.rateHour),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        selectedLanguageChanged: (e) {
          emit(
            state.copyWith(
              selectedLanguage: InputEmptyOrNot(e.language),
            ),
          );
        },
        addRequiredSpecialitichips: (e) {
          if (!e.selectedValue.toLowerCase().contains("other") &&
              (state.requiredSpecialityChipList.isEmpty ||
                  !state.requiredSpecialityChipList
                      .contains(e.selectedValue))) {
            emit(
              state.copyWith(
                requiredSpecialityChipList:
                    List.from(state.requiredSpecialityChipList)
                      ..add(e.selectedValue),
                requiredSpecialityChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                requiredSpecialityChipList:
                    List.from(state.requiredSpecialityChipList),
                requiredSpecialityChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        removeRequiredSpecialitichips: (e) {
          emit(
            state.copyWith(
              requiredSpecialityChipList:
                  List.from(state.requiredSpecialityChipList)
                    ..remove(e.selectedValue),
              requiredSpecialityChip: "",
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        addPreferedSoftwareSkillchips: (e) {
          if (e.selectedValue.isNotEmpty &&
              !e.selectedValue.toLowerCase().contains("other") &&
              (state.requiredSoftwareSkillChipList.isEmpty ||
                  !state.requiredSoftwareSkillChipList
                      .contains(e.selectedValue))) {
            emit(
              state.copyWith(
                requiredSoftwareSkillChipList:
                    List.from(state.requiredSoftwareSkillChipList)
                      ..add(e.selectedValue),
                requiredSoftwareSkillChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                requiredSoftwareSkillChipList:
                    List.from(state.requiredSoftwareSkillChipList),
                requiredSoftwareSkillChip:
                    (e.isOtherValue == true) ? "" : e.selectedValue,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        removePreferedSoftwareSkillchips: (e) {
          emit(
            state.copyWith(
              requiredSoftwareSkillChipList:
                  List.from(state.requiredSoftwareSkillChipList)
                    ..remove(e.selectedValue),
              requiredSoftwareSkillChip: "",
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        continueBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isLocationValid = state.location.isValid();
          final isRateHourValid = state.rateHour.isValid();
          final roleType = state.roleType.isValid();
          final language = state.selectedLanguage.isValid();

          if (roleType && language && isLocationValid && isRateHourValid) {
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
}
