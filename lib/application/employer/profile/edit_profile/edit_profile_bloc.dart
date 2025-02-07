import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';
part 'edit_profile_bloc.freezed.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final IAccountRepository respository;

  EditProfileBloc(this.respository) : super(EditProfileState.initial()) {
    on<EditProfileEvent>((event, emit) async {
      await event.map(
        getCurrentProfileDetail: (e) async {
          emit(state.copyWith(isLoading: true));
          final failureOrSuccess = await respository.getCurrentUserApi();
          failureOrSuccess.fold(
            (l) {
              emit(state.copyWith(isLoading: false));
            },
            (r) {
              print("Current user complete profile----> $r");
              return emit(state.copyWith(
                currentUser: r,
                selectImage: r.profileImage ?? "",
                companyName: InputEmptyOrNot(r.companyName ?? ""),
                firstName: Username(r.firstName ?? ""),
                lastName: Lastname(r.lastName ?? ""),
                email: EmailAddress(r.email ?? ""),
                phoneNumber: MobileNumber("${r.phone}"),
                selectedCountrycode: r.countryCode ?? "",
                selectedCountryFlag: r.countryNameCode ?? "",
                association: r.association ?? "",
                companyDescription: r.companyDescription ?? "",
                isLoading: false,
              ));
            },
          );
        },
        changeProfilePic: (e) {
          emit(
            state.copyWith(selectImage: e.path),
          );
        },
        firstNameChanged: (e) {
          emit(
            state.copyWith(
              firstName: Username(e.firstName),
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        lastNameChanged: (e) {
          emit(
            state.copyWith(
              lastName: Lastname(e.lastname),
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        companyNameChanged: (e) {
          emit(
            state.copyWith(
              companyName: InputEmptyOrNot(e.companyName),
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        phoneNumberChanged: (e) {
          emit(
            state.copyWith(
              phoneNumber: MobileNumber(e.phoneNumber),
              enteredPhoneNo: e.phoneNumber,
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        selectCountryCode: (e) {
          emit(
            state.copyWith(
              selectedCountrycode: e.phoneCode,
              selectedCountryFlag: e.flag,
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        associationTextChanged: (e) {
          emit(
            state.copyWith(
              association: e.value,
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        companyDescChanged: (e) {
          emit(
            state.copyWith(
              companyDescription: e.companyDesc,
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        updateProfile: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          final isFirstNameValid = state.firstName.isValid();
          final isLastNameValid = state.lastName.isValid();
          final isCompanyNameValid = state.companyName.isValid();
          final isPhoneNumberValid = state.phoneNumber.isValid();
          final isProfilePicValid = (state.selectImage.isNotEmpty);

          if (isFirstNameValid &&
              isLastNameValid &&
              isCompanyNameValid &&
              isPhoneNumberValid &&
              isProfilePicValid) {
            print("All details are valid");
            emit(
              state.copyWith(
                isSubmitting: true,
              ),
            );
            failureOrSuccess = await respository.editEmployerProfile(
              firstName: state.firstName.getValue(),
              lastName: state.lastName.getValue(),
              companyName: state.companyName.getValue() ?? "",
              phone: state.phoneNumber.getValue(),
              countryCode: state.selectedCountrycode,
              countryFlag: state.selectedCountryFlag,
              association: state.association,
              companyDesc: state.companyDescription,
              profileImage: state.selectImage,
              lastPage: state.currentUser?.lastPage ?? "",
            );

            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(e.context);
                emit(state.copyWith(isSubmitting: false));
              },
              (r) {
                emit(state.copyWith(isSubmitting: false));

                showSuccess(
                        message: "Your profile has been successfully updated!")
                    .show(e.context)
                    .then((value) {
                  e.context.router.maybePop(r);
                });
              },
            );
          } else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              // authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
