import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';

part 'add_new_member_state.dart';
part 'add_new_member_event.dart';
part 'add_new_member_bloc.freezed.dart';

class AddNewMemberBloc extends Bloc<AddNewMemberEvent, AddNewMemberState> {
  AddNewMemberBloc() : super(AddNewMemberState.initial()) {
    on<AddNewMemberEvent>(
      (event, emit) async {
        await event.map(
          initialEvent: (e) async {
            emit(AddNewMemberState.initial());
          },
          changeTeamMemberName: (ChangeTeamMemberName value) async {
            emit(
              state.copyWith(
                teamNameTextField: InputEmptyOrNot(value.teamName),
              ),
            );
          },
          jobLocationChange: (JobLocationChange value) async {
            emit(
              state.copyWith(
                locationTextField: InputEmptyOrNot(value.jobLocationChange),
              ),
            );
          },
          phoneNumberChange: (PhoneNumberChange value) async {
            emit(
              state.copyWith(
                //locationTextField: InputEmptyOrNot(value.jobLocationChange),
                mobileNumber: MobileNumber(value.phoneNumber),
              ),
            );
          },
          emailChange: (EmailChange value) async {
            emit(
              state.copyWith(
                //locationTextField: InputEmptyOrNot(value.jobLocationChange),
                emailAddress: EmailAddress(value.email),
              ),
            );
          },
          addNewMember: (AddNewMember value) async {
            var isLocationValid = state.locationTextField.isValid();
            var isTeamNameValid = state.teamNameTextField.isValid();
            var isPhoneNumberValid = state.mobileNumber.isValid();
            var isEmailValid = state.emailAddress.isValid();
            if (isLocationValid &&
                isTeamNameValid &&
                isPhoneNumberValid &&
                isEmailValid) {
              print("Location: ${state.locationTextField.value}");
              print("Team Name: ${state.teamNameTextField.value}");
              emit(
                state.copyWith(
                  isSubmitting: true,
                  failureOrSuccessOption: none(),
                ),
              );
            }

            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMessages: true,
                // authFailureOrSuccessOption: optionOf(failureOrSuccess),
                // verificationFailureOrSuccessOption: none(),
              ),
            );
          },
        );
      },
    );
  }
}
