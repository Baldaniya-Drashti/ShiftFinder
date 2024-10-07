import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

part 'edit_profile_bloc.freezed.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final IAuthFacade _authFacade;

  EditProfileBloc(this._authFacade) : super(EditProfileState.initial()) {
    on<EditProfileEvent>((event, emit) {
      event.map(
        firstNameChanged: (value) {
          emit(
            state.copyWith(
              lastName: Lastname(value.firstName),
            ),
          );
        },
        lastNameChanged: (value) {
          emit(
            state.copyWith(
              lastName: Lastname(value.lastname),
            ),
          );
        },
        companyDescChanged: (value) {
          emit(
            state.copyWith(companyName: InputEmptyOrNot(value.companyDesc)),
          );
        },
        companyNameChanged: (value) {
          emit(
            state.copyWith(companyName: InputEmptyOrNot(value.companyName)),
          );
        },
        selectCountryCode: (value) {
          emit(
            state.copyWith(
              selectedCountrycode: value.phoneCode,
              selectedCountryFlag: value.flag,
            ),
          );
        },
        phoneNumberChanged: (value) {
          emit(
            state.copyWith(
              phoneNumber: MobileNumber(value.phoneNumber),
            ),
          );
        },
        associationTextChanged: (value) {
          emit(
            state.copyWith(association: value.value),
          );
        },
        updateProfile: (value) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isFirstNameValid = state.firstName.isValid();
          final isLastNameValid = state.lastName.isValid();
          final isCompanyNameValid = state.companyName.isValid();
          final isPhoneNumberValid = state.phoneNumber.isValid();
          final isProfilePicValid = (state.selectedImage.isNotEmpty);

          if (isFirstNameValid && isLastNameValid && isCompanyNameValid && isPhoneNumberValid && isProfilePicValid) {

          }
        },
      );
    });
  }
}
