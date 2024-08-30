// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';
part 'reference_event.dart';
part 'reference_state.dart';
part 'reference_bloc.freezed.dart';

@injectable
class ReferenceBloc extends Bloc<ReferenceEvent, ReferenceState> {
  final IAccountRepository _repository;
  final IAuthFacade _authFacade;

  ReferenceBloc(this._repository, this._authFacade)
      : super(ReferenceState.initial()) {
    on<ReferenceEvent>((event, emit) async {
      await event.map(
        referenceObjEvent: (e) async {
          if (e.referenceObj != null) {
            emit(state.copyWith(
              isLoading: true,
              selectedTab: (e.referenceObj!.type == 1) ? 0 : 1,
            ));
            await Future.delayed(Duration(seconds: 3));
            print("referenceObj called --> ${e.referenceObj}");
            final obj = e.referenceObj!;
            emit(
              state.copyWith(
                isLoading: false,

                /// PROFESSIONAL
                jobPosition: InputEmptyOrNot(obj.job_position ?? ""),
                organization: InputEmptyOrNot(obj.organization ?? ""),
                referrer: InputEmptyOrNot(obj.referrer ?? ""),
                referrerEmail: (obj.type == 1)
                    ? EmailAddress(obj.email ?? "")
                    : EmailAddress(""),
                referrerPhoneNo: (obj.type == 1)
                    ? MobileNumber(obj.phone.toString())
                    : MobileNumber(""),
                selectedCountrycode: obj.country_code ?? "",
                selectedCountryFlag: obj.country_name_code ?? "",
                jobLocation: InputEmptyOrNot(obj.job_location ?? ""),
                unitDepartment: InputEmptyOrNot(obj.unit ?? ""),
                startDate: (obj.start_date != null)
                    ? InputEmptyOrNot(DateTime.fromMillisecondsSinceEpoch(
                            obj.start_date! * 1000)
                        .toString())
                    : InputEmptyOrNot(""),
                endDate: (obj.end_date != null)
                    ? InputEmptyOrNot(DateTime.fromMillisecondsSinceEpoch(
                            obj.end_date! * 1000)
                        .toString())
                    : InputEmptyOrNot(""),

                /// PERSONAL
                contactPerson: InputEmptyOrNot(obj.contact_person ?? ""),
                personalEmail: (obj.type == 2)
                    ? EmailAddress(obj.email ?? "")
                    : EmailAddress(""),
                personalPhoneNo: (obj.type == 2)
                    ? MobileNumber(obj.phone.toString())
                    : MobileNumber(""),
                profession: InputEmptyOrNot(obj.profession_referrer ?? ""),
                personalCountrycode: obj.country_code ?? "",
                personalCountryFlag: obj.country_name_code ?? "",
              ),
            );
          }
        },
        getReferenceList: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              failureOrSuccessOptionPersonal: none(),
            ),
          );
          final failureOrSuccess = await _repository.getCurrentUserApi();
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                referenceList: [],
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isLoading: false,
                  referenceList: r.reference ?? [],
                ),
              );
            },
          );

          emit(
            state.copyWith(
              isLoading: false,
              failureOrSuccessOptionPersonal: optionOf(failureOrSuccess),
            ),
          );
        },

        skipReference: (e) async {
          Either<AuthFailure, Account>? failureOrSuccess;

          emit(
            state.copyWith(
              isLoading: true,
              skipFailureOrSuccessOption: none(),
            ),
          );

          failureOrSuccess = await _authFacade.addLastPageApi(
            lastPage: "Document",
          );

          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
              ),
            ),
            (r) {
              emit(
                state.copyWith(
                  isLoading: false,
                ),
              );
            },
          );

          emit(
            state.copyWith(
              isLoading: false,
              skipFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },

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
              endDate: InputEmptyOrNot(""),
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
        professinalBtnPressed: (e) async {
          print("isUpdate! ${e.isUpdate}");
          Either<AccountFailure, Account>? failureOrSuccess;

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
            print("All details are valid! ");

            emit(
              state.copyWith(
                isProfessionalSubmitting: true,
                authFailureOrSuccessOptionProfessional: none(),
              ),
            );
            if (e.id != null) {
              failureOrSuccess = await _repository.updateReferenceApi(
                id: e.id ?? -1,
                type: 1,
                jobPosition: state.jobPosition.getValue() ?? "",
                organization: state.organization.getValue() ?? "",
                referrer: state.referrer.getValue() ?? "",
                email: state.referrerEmail.getValue(),
                countryCode: state.selectedCountrycode,
                countryFlag: state.selectedCountryFlag,
                phone: state.referrerPhoneNo.getValue(),
                jobLocation: state.jobLocation.getValue() ?? "",
                unit: state.unitDepartment.getValue() ?? "",
                startDate: state.startDate.getValue() ?? "",
                endDate: state.endDate.getValue() ?? "",
                contactPerson: "",
                professionReferrer: "",
              );
            } else {
              failureOrSuccess = await _repository.addReferenceApi(
                type: 1,
                jobPosition: state.jobPosition.getValue() ?? "",
                organization: state.organization.getValue() ?? "",
                referrer: state.referrer.getValue() ?? "",
                email: state.referrerEmail.getValue(),
                countryCode: state.selectedCountrycode,
                countryFlag: state.selectedCountryFlag,
                phone: state.referrerPhoneNo.getValue(),
                jobLocation: state.jobLocation.getValue() ?? "",
                unit: state.unitDepartment.getValue() ?? "",
                startDate: state.startDate.getValue() ?? "",
                endDate: state.endDate.getValue() ?? "",
                contactPerson: "",
                professionReferrer: "",
              );
            }
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
        personalBtnPressed: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;
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

            if (e.id != null) {
              failureOrSuccess = await _repository.updateReferenceApi(
                id: e.id ?? -1,
                type: 2,
                jobPosition: "",
                organization: "",
                referrer: "",
                email: state.personalEmail.getValue(),
                countryCode: state.personalCountrycode,
                countryFlag: state.personalCountryFlag,
                phone: state.personalPhoneNo.getValue(),
                jobLocation: "",
                unit: "",
                startDate: "",
                endDate: "",
                contactPerson: state.contactPerson.getValue(),
                professionReferrer: state.profession.getValue(),
              );
            } else {
              failureOrSuccess = await _repository.addReferenceApi(
                type: 2,
                jobPosition: "",
                organization: "",
                referrer: "",
                email: state.personalEmail.getValue(),
                countryCode: state.personalCountrycode,
                countryFlag: state.personalCountryFlag,
                phone: state.personalPhoneNo.getValue(),
                jobLocation: "",
                unit: "",
                startDate: "",
                endDate: "",
                contactPerson: state.contactPerson.getValue(),
                professionReferrer: state.profession.getValue(),
              );
            }
          }
          emit(
            state.copyWith(
              isPersonalSubmitting: false,
              showPersonalErrorMessage: true,
              authFailureOrSuccessOptionPersonal: optionOf(failureOrSuccess),
            ),
          );
        },
        deleteReference: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          emit(
            state.copyWith(
              isLoading: true,
              failureOrSuccessOptionPersonal: none(),
            ),
          );

          print("Delete Id-> ${e.referenceId}");
          failureOrSuccess =
              await _repository.deleteReferenceApi(referenceId: e.referenceId);

          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                referenceList: List.from(state.referenceList),
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isLoading: false,
                  referenceList: r.reference ?? [],
                ),
              );
            },
          );
        },
      );
    });
  }
}
