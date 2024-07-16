// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';

part 'reference_event.dart';
part 'reference_state.dart';
part 'reference_bloc.freezed.dart';

@injectable
class ReferenceBloc extends Bloc<ReferenceEvent, ReferenceState> {
  ReferenceBloc() : super(ReferenceState.initial()) {
    on<ReferenceEvent>((event, emit) {
      event.map(
        tabChangeEvent: (value) async {
          emit(state.copyWith(selectedTab: value.tabIndex));
        },
        // FOR PROFESSIONAL
        jobPositionChanged: (e) {
          emit(
            state.copyWith(
              jobPosition: InputEmptyOrNot(e.jobPosition),
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        organizationChanged: (e) {
          emit(
            state.copyWith(
              organization: InputEmptyOrNot(e.organization),
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        referrerChanged: (e) {
          emit(
            state.copyWith(
              referrer: InputEmptyOrNot(e.referrer),
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        referrerEmailChanged: (e) {
          emit(
            state.copyWith(
              referrerEmail: EmailAddress(e.referrerEmail),
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        referrerPhoneNoChanged: (e) {
          emit(
            state.copyWith(
              referrerPhoneNo: MobileNumber(e.referrerPhoneNo),
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        selectCountryCode: (e) {
          emit(
            state.copyWith(
              selectedCountrycode: e.phoneCode,
              selectedCountryFlag: e.flag,
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        jobLocationChanged: (e) {
          emit(
            state.copyWith(
              jobLocation: InputEmptyOrNot(e.jobLocation),
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        unitDepartmentChanged: (e) {
          emit(
            state.copyWith(
              unitDepartment: InputEmptyOrNot(e.unitDepartment),
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        startDateChanged: (e) {
          emit(
            state.copyWith(
              startDate: InputEmptyOrNot(e.startDate),
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        endDateChanged: (e) {
          emit(
            state.copyWith(
              endDate: InputEmptyOrNot(e.endDate),
              authFailureOrSuccessOptionProfessional: none(),
            ),
          );
        },
        professinalBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isMobileNumberValid = state.referrerPhoneNo.isValid();
          final isJobPositonValid = state.jobPosition.isValid();
          final isOrganizationValid = state.organization.isValid();
          final isReferrerValid = state.referrer.isValid();
          final isReferrerEmailValid = state.referrerEmail.isValid();
          final isJobLocationValid = state.jobLocation.isValid();
          final isUnitDepartmentValid = state.unitDepartment.isValid();
          final isStartDateValid = state.startDate.isValid();
          final isEndDateValid = state.endDate.isValid();

          if (isMobileNumberValid &&
              isJobPositonValid &&
              isOrganizationValid &&
              isReferrerValid &&
              isReferrerEmailValid &&
              isJobLocationValid &&
              isUnitDepartmentValid &&
              isStartDateValid &&
              isEndDateValid) {
            print("All details are validdddddd!");
            emit(
              state.copyWith(
                isProfessionalSubmitting: true,
                authFailureOrSuccessOptionProfessional: none(),
              ),
            );
            // failureOrSuccess = await _authFacade.login(
            //   mobileNumber: state.emailId,
            //   countryCode: '+${state.selectedCountrycode}',
            // );
            failureOrSuccess = right("success");
          }
          emit(
            state.copyWith(
              isProfessionalSubmitting: false,
              showProfessionalErrorMessage: true,
              authFailureOrSuccessOptionProfessional:
                  optionOf(failureOrSuccess),
            ),
          );
        },
        // FOR PERSONAL
        contactPersonChanged: (e) {
          emit(
            state.copyWith(
              contactPerson: InputEmptyOrNot(e.contactPerson),
              authFailureOrSuccessOptionPersonal: none(),
            ),
          );
        },
        personalEmailChanged: (e) {
          emit(
            state.copyWith(
              personalEmail: EmailAddress(e.personalEmail),
              authFailureOrSuccessOptionPersonal: none(),
            ),
          );
        },
        personalPhoneNoChanged: (e) {
          emit(
            state.copyWith(
              personalPhoneNo: MobileNumber(e.personalPhoneNo),
              authFailureOrSuccessOptionPersonal: none(),
            ),
          );
        },
        professionChanged: (e) {
          emit(
            state.copyWith(
              profession: InputEmptyOrNot(e.profession),
              authFailureOrSuccessOptionPersonal: none(),
            ),
          );
        },
        personalCountryCode: (e) {
          emit(
            state.copyWith(
              personalCountrycode: e.phoneCode,
              personalCountryFlag: e.flag,
              authFailureOrSuccessOptionPersonal: none(),
            ),
          );
        },
        personalBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isContactPersonValid = state.contactPerson.isValid();
          final isPersonalEmailValid = state.personalEmail.isValid();
          final isPersonalPhoneNoValid = state.personalPhoneNo.isValid();
          final isProfessionValid = state.profession.isValid();

          if (isContactPersonValid &&
              isPersonalEmailValid &&
              isPersonalPhoneNoValid &&
              isProfessionValid) {
            print("All details are validdddddd!");
            emit(
              state.copyWith(
                isPersonalSubmitting: true,
                authFailureOrSuccessOptionPersonal: none(),
              ),
            );
            // failureOrSuccess = await _authFacade.login(
            //   mobileNumber: state.emailId,
            //   countryCode: '+${state.selectedCountrycode}',
            // );
            failureOrSuccess = right("success");
          }
          emit(
            state.copyWith(
              isPersonalSubmitting: false,
              showPersonalErrorMessage: true,
              authFailureOrSuccessOptionPersonal: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
