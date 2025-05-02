// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/auth/contractor/bank/bank_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';

part 'bank_details_event.dart';
part 'bank_details_state.dart';
part 'bank_details_bloc.freezed.dart';

@injectable
class BankDetailsBloc extends Bloc<BankDetailsEvent, BankDetailsState> {
  final IAccountRepository repository;

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

  static TextEditingController locationCtrl = TextEditingController(text: "");

  BankDetailsBloc(this.repository) : super(BankDetailsState.initial()) {
    on<BankDetailsEvent>((event, emit) async {
      await event.map(
        getCurrentBank: (e) async {
          BankDTO? bank;
          locationCtrl.clear();
          emit(state.copyWith(isLoading: true));

          if (e.currentBank != null) {
            bank = e.currentBank;
          } else {
            final res = await repository.getBankDetailAPI();
            res.fold(
              (l) {
                emit(state.copyWith(isLoading: false));
              },
              (r) {
                bank = r;
              },
            );
          }

          await Future.delayed(Duration(seconds: 1)).then((value) {
            if (bank != null) {
              locationCtrl.text = bank?.bank_address ?? "";
              emit(state.copyWith(
                bankDetail: bank,
                bankName: InputEmptyOrNot(bank?.bank_name ?? ""),
                jobTitle: InputEmptyOrNot(bank?.job_title ?? ""),
                accountHolderName: Username(""),
                accountNumber: InputEmptyOrNot(bank?.full_account_number ?? ""),
                transitNumber: InputEmptyOrNot(bank?.transit_number ?? ""),
                bankInstitutionNumber:
                    InputEmptyOrNot(bank?.institution_number ?? ""),
                accountType: InputEmptyOrNot(bank?.account_type ?? ""),
                firstName: Username(bank?.first_name ?? ""),
                lastName: Lastname(bank?.last_name ?? ""),
                phoneNumber: MobileNumber(bank?.phone ?? ""),
                dateOfBirth: (bank?.dob != null)
                    ? InputEmptyOrNot(CustomDateTimeFormat.timeStampToDateTime(
                        bank?.dob ?? -1,
                      ).toIso8601String())
                    : InputEmptyOrNot(""),
                bankAddress: InputEmptyOrNot(bank?.bank_address ?? ""),
                city: InputEmptyOrNot(bank?.city ?? ""),
                stateName: InputEmptyOrNot(bank?.state ?? ""),
                postalCode: InputEmptyOrNot(bank?.postal_code ?? ""),
                selectedCountrycode: bank?.country_code ?? "",
                selectedCountryFlag: bank?.country_flag ?? "",
                selectedCountryCodeName: bank?.country ?? "",
                isLoading: false,
              ));
            } else {
              emit(state.copyWith(isLoading: false));
            }
          });
        },
        getBankDetails: (e) async {
          emit(state.copyWith(isLoading: true));
          final res = await repository.getBankDetailAPI();
          res.fold(
            (l) {
              emit(state.copyWith(isLoading: false));
            },
            (r) {
              return emit(state.copyWith(
                bankDetail: r,
                isLoading: false,
              ));
            },
          );
        },
        locationSelectedFromSearchList: (e) async {
          Location? locationDetails;
          locationCtrl.text = e.selectedLocation.description ?? "";

          emit(state.copyWith(
            isLoading: true,
            authFailureOrSuccessOption: none(),
          ));

          var res = await LocationHelper.getPlaceDetail(
              e.selectedLocation.place_id ?? "");
          if (res != null &&
              res.result != null &&
              res.result!.geometry != null &&
              res.result!.geometry!.location != null) {
            var location = res.result!.geometry!.location;
            locationDetails = await LocationHelper.getLocationDetailsFromLatLng(
                location?.lat, location?.lng);

            if (locationDetails != null) {
              emit(
                state.copyWith(
                  isLoading: false,
                  bankAddress:
                      InputEmptyOrNot(e.selectedLocation.description ?? ""),
                  searchLocationList: [],
                  city: InputEmptyOrNot(locationDetails.city ?? ""),
                  stateName: InputEmptyOrNot(locationDetails.state ?? ""),
                  postalCode: InputEmptyOrNot(locationDetails.postalCode ?? ""),
                  selectedLocationPrediction: e.selectedLocation,
                  authFailureOrSuccessOption: none(),
                ),
              );
            } else {
              emit(
                state.copyWith(
                  isLoading: false,
                  authFailureOrSuccessOption: none(),
                ),
              );
            }
          }
        },
        accountTypeChanged: (e) {
          emit(
            state.copyWith(
              accountType: InputEmptyOrNot(e.accountType),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
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
              lastName: Lastname(e.lastName),
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
              selectedCountryCodeName: e.countryCodeName,
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
        submitBtnPressed: (e) async {
          Either<AccountFailure, String>? failureOrSuccess;
          final isBankNameValid = state.bankName.isValid();
          final isAccountNumberValid = state.accountNumber.isValid();
          final isTransitNumberValid = state.transitNumber.isValid();
          final isInstituteNumberValid = state.bankInstitutionNumber.isValid();
          final isBankAddressValid = state.bankAddress.isValid();
          final isJobTitleValid = state.jobTitle.isValid();
          final isAccountTypeValid = state.accountType.isValid();
          final isFirstNameValid = state.firstName.isValid();
          final isLastNameValid = state.lastName.isValid();
          final isDobValid = state.dateOfBirth.isValid();
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
              isJobTitleValid &&
              isAccountTypeValid &&
              isFirstNameValid &&
              isLastNameValid &&
              isDobValid &&
              isCityValid &&
              isStateValid &&
              isPostalCodeValid &&
              isPhoneNoValid &&
              isCheckTerms) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            failureOrSuccess = await repository.addBankDetail(
              bankName: state.bankName.getValue() ?? "",
              jobTitle: state.jobTitle.getValue() ?? "",
              accountNumber: state.accountNumber.getValue() ?? "",
              transitNumber: state.transitNumber.getValue() ?? "",
              institutionNumber: state.bankInstitutionNumber.getValue() ?? "",
              accountType: (state.accountType.getValue() ?? "").toLowerCase(),
              firstName: state.firstName.getValue(),
              lastName: state.lastName.getValue(),
              dateOfBirth: CustomDateTimeFormat.dateTimeToUtcTimestamp(
                      DateTime.parse(state.dateOfBirth.getValue() ?? ""))
                  .toString(),
              bankAddress: state.bankAddress.getValue() ?? "",
              city: state.city.getValue() ?? "",
              state: state.stateName.getValue() ?? "",
              postalCode: state.postalCode.getValue() ?? "",
              countryFlag: state.selectedCountryFlag,
              countryNameCode: state.selectedCountryCodeName,
              countryCode: state.selectedCountrycode.contains('+')
                  ? state.selectedCountrycode
                  : '+${state.selectedCountrycode}',
              phone: state.phoneNumber.getValue(),
              lastPage: 'LegalScreening',
            );
          } else {
            print("Some Details are invalid!");
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
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
