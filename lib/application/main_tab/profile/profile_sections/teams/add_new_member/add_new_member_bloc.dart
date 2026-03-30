import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart';

part 'add_new_member_state.dart';
part 'add_new_member_event.dart';
part 'add_new_member_bloc.freezed.dart';

@injectable
class AddNewMemberBloc extends Bloc<AddNewMemberEvent, AddNewMemberState> {
  final IMainFacade mainFacade;
  AddNewMemberBloc(this.mainFacade) : super(AddNewMemberState.initial()) {
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
                failureOrSuccessOption: none(),
              ),
            );
          },
          jobLocationChange: (JobLocationChange value) async {
            emit(
              state.copyWith(
                jobPositionTextField: InputEmptyOrNot(value.jobLocationChange),
                failureOrSuccessOption: none(),
              ),
            );
          },
          phoneNumberChange: (PhoneNumberChange value) async {
            emit(
              state.copyWith(
                //locationTextField: InputEmptyOrNot(value.jobLocationChange),
                mobileNumber: MobileNumber(value.phoneNumber),
                failureOrSuccessOption: none(),
              ),
            );
          },
          emailChange: (EmailChange value) async {
            emit(
              state.copyWith(
                //locationTextField: InputEmptyOrNot(value.jobLocationChange),
                emailAddress: EmailAddress(value.email),
                failureOrSuccessOption: none(),
              ),
            );
          },
          addNewMember: (AddNewMember value) async {
            Either<MainFailure, String>? failureOrSuccess;
            var isLocationValid = state.jobPositionTextField.isValid();
            var isTeamNameValid = state.teamNameTextField.isValid();
            var isPhoneNumberValid = state.mobileNumber.isValid();
            var isEmailValid = state.emailAddress.isValid();
            if (isLocationValid &&
                isTeamNameValid &&
                isPhoneNumberValid &&
                isEmailValid &&
                state.selectedCountryCode.isNotEmpty &&
                state.selectedCountryFlag.isNotEmpty) {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  failureOrSuccessOption: none(),
                ),
              );
              failureOrSuccess = await mainFacade.createTeamMemberApi(
                teamId: state.teamID,
                teamMemberName: state.teamNameTextField,
                position: state.jobPositionTextField,
                countryCode: '+${state.selectedCountryCode}',
                countryNameCode: state.selectedCountryFlag,
                email: state.emailAddress,
                phoneNumber: state.mobileNumber,
              );
            }

            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMessages: true,
                failureOrSuccessOption: optionOf(failureOrSuccess),
                // authFailureOrSuccessOption: optionOf(failureOrSuccess),
                // verificationFailureOrSuccessOption: none(),
              ),
            );
          },
          changeCountryCode: (value) async {
            emit(
              state.copyWith(
                selectedCountryCode: value.countryCode,
                selectedCountryFlag: value.countryFlag,
                failureOrSuccessOption: none(),
              ),
            );
          },
          prefillDataForUpdateTeamMember:
              (PrefillDataForUpdateTeamMember value) async {
            emit(
              state.copyWith(
                teamNameTextField:
                    InputEmptyOrNot(value.getTeamsListDTO.name ?? ""),
                jobPositionTextField:
                    InputEmptyOrNot(value.getTeamsListDTO.position ?? ""),
                isEdit: value.isEdit,
                mobileNumber: MobileNumber(value.getTeamsListDTO.phone ?? ""),
                selectedCountryCode: value.getTeamsListDTO.country_code ?? "",
                selectedCountryFlag:
                    value.getTeamsListDTO.country_name_code ?? "",
                emailAddress: EmailAddress(value.getTeamsListDTO.email ?? ""),
              ),
            );
          },
          setTeamID: (SetTeamID value) async {
            emit(
              state.copyWith(
                teamID: value.teamID,
                failureOrSuccessOption: none(),
              ),
            );
          },
          updateTeamMember: (UpdateTeamMember value) async {
            Either<MainFailure, String>? failureOrSuccess;
            var isLocationValid = state.jobPositionTextField.isValid();
            var isTeamNameValid = state.teamNameTextField.isValid();
            var isPhoneNumberValid = state.mobileNumber.isValid();
            var isEmailValid = state.emailAddress.isValid();
            if (isLocationValid &&
                isTeamNameValid &&
                isPhoneNumberValid &&
                isEmailValid &&
                state.selectedCountryCode.isNotEmpty &&
                state.selectedCountryFlag.isNotEmpty) {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  failureOrSuccessOption: none(),
                ),
              );
              print("team Id111---> ${state.teamID}");
              failureOrSuccess = await mainFacade.updateTeamMemberApi(
                teamMemberId: value.updateTeamID,
                teamMemberName: state.teamNameTextField,
                position: state.jobPositionTextField,
                countryCode: '+${state.selectedCountryCode}',
                countryNameCode: state.selectedCountryFlag,
                email: state.emailAddress,
                phoneNumber: state.mobileNumber,
                teamId: state.teamID,
              );
            }

            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMessages: true,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          },
          deleteTeamMember: (DeleteTeamMember value) async {
            Either<MainFailure, String>? failureOrSuccess;
            emit(
              state.copyWith(
                isSubmitting: true,
                failureOrSuccessOption: none(),
              ),
            );
            failureOrSuccess = await mainFacade.deleteTeamMemberApi(
              teamMemberId: value.updateTeamID,
            );
            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMessages: true,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          },
        );
      },
    );
  }
}
