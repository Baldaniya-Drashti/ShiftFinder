// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';

part 'bank_details_event.dart';
part 'bank_details_state.dart';
part 'bank_details_bloc.freezed.dart';

class BankDetailsBloc extends Bloc<BankDetailsEvent, BankDetailsState> {
  static List<SkillDTO> bankNameList = [
    SkillDTO(id: 1, name: "HDFC"),
    SkillDTO(id: 2, name: "State Bank of India"),
    SkillDTO(id: 3, name: "ICICI Bank"),
    SkillDTO(id: 4, name: "Axis Bank"),
    SkillDTO(id: 5, name: "Kotak Mahindra Bank"),
    SkillDTO(id: 6, name: "Punjab National Bank"),
    SkillDTO(id: 7, name: "Bank of Baroda"),
    SkillDTO(id: 8, name: "Canara Bank"),
    SkillDTO(id: 9, name: "IDBI Bank"),
    SkillDTO(id: 10, name: "Yes Bank"),
  ];

  BankDetailsBloc() : super(BankDetailsState.initial()) {
    on<BankDetailsEvent>((event, emit) {
      event.map(
        accountTypeChanged: (e) {},
        cityChanged: (e) {
          emit(
            state.copyWith(
              city: InputEmptyOrNot(e.city),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        dobChanged: (e) {
          emit(
            state.copyWith(
              dateOfBirth: InputEmptyOrNot(e.dob),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        firstNameChanged: (e) {
          emit(
            state.copyWith(
              firstName: Username(e.firstName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        jobTitleChanged: (e) {
          emit(
            state.copyWith(
              jobTitle: InputEmptyOrNot(e.jobTitle),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        lastNameChanged: (e) {
          emit(
            state.copyWith(
              lastName: Username(e.lastName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        phoneNumberChanged: (e) {
          emit(
            state.copyWith(
              phoneNumber: MobileNumber(e.phoneNumber),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        selectCountryCode: (e) {
          emit(
            state.copyWith(
              selectedCountrycode: e.countryCode,
              selectedCountryFlag: e.countryFlag,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        postalCodeChanged: (e) {
          emit(
            state.copyWith(
              postalCode: InputEmptyOrNot(e.postalCode),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        stateChanged: (e) {
          emit(
            state.copyWith(
              stateName: InputEmptyOrNot(e.state),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        bankNameChanged: (e) {
          emit(
            state.copyWith(
              bankName: InputEmptyOrNot(e.bankName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        accountHolderNameChanged: (e) {
          emit(
            state.copyWith(
              accountHolderName: Username(e.holderName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        transitNumberChanged: (e) {
          emit(
            state.copyWith(
              transitNumber: InputEmptyOrNot(e.transitNumber),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        instituteNumberChanged: (e) {
          emit(
            state.copyWith(
              bankInstitutionNumber: InputEmptyOrNot(e.instituteNumber),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        accountNumberChanged: (e) {
          emit(
            state.copyWith(
              accountNumber: InputEmptyOrNot(e.accountNumber),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        bankAddressChanged: (e) {
          emit(
            state.copyWith(
              bankAddress: InputEmptyOrNot(e.bankAddress),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        checkTermsCondition: (e) {
          emit(
            state.copyWith(
              isCheck: e.isCheck,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        submitBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isBankNameValid = state.bankName.isValid();
          final isJobTitleValid = state.jobTitle.isValid();
          final isAccountNumberValid = state.accountNumber.isValid();
          final isTransitNumberValid = state.transitNumber.isValid();
          final isInstituteNumberValid = state.bankInstitutionNumber.isValid();
          final isAccountTypeValid = state.accountType.isValid();
          final isFirstNameValid = state.firstName.isValid();
          final isLastNameValid = state.lastName.isValid();
          final isDobValid = state.dateOfBirth.isValid();
          final isBankAddressValid = state.bankAddress.isValid();
          final isCityValid = state.city.isValid();
          final isStateValid = state.stateName.isValid();
          final isPostalCodeValid = state.postalCode.isValid();
          final isPhoneNoValid = state.phoneNumber.isValid();

          final isCheckTerms = state.isCheck;

          if (isBankNameValid &&
              isTransitNumberValid &&
              isInstituteNumberValid &&
              isAccountNumberValid &&
              isBankAddressValid &&
              isCheckTerms) {
            // Find the ID of the selected bank name
            final selectedBankName = state.bankName.getValue();
            final selectedBank = bankNameList.firstWhere(
              (bank) => bank.name == selectedBankName,
              orElse: () => SkillDTO(id: -1, name: ""),
            );

            final selectedBankId = selectedBank.id;

            print("Selected Bank ID: $selectedBankId");

            print("All Details are validdddddd! ");
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            // failureOrSuccess = await _authFacade.login(
            //   mobileNumber: state.emailId,
            //   countryCode: '+${state.selectedCountrycode}',
            // );
            failureOrSuccess = right("success");
          } else {
            print("Some Details are invalid! ");
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
