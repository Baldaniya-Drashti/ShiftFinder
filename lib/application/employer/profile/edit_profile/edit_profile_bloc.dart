import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/core/logger/logger.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

part 'edit_profile_bloc.freezed.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final IAuthFacade _authFacade;

  EditProfileBloc(this._authFacade) : super(EditProfileState.initial()) {
    on<EditProfileEvent>((event, emit) async {
      await event.map(
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

          Log.debug(value.flag);
          Log.debug(value.phoneCode);
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
        updateProfile: (value) async {
          Either<AuthFailure, Account>? failureOrSuccess;
          final user = getCurrentUser();
          emit(state.copyWith(isSubmitting: true));
          failureOrSuccess = await _authFacade.editEmployerProfile(
            firstName: value.firstName,
            lastName: value.lastName,
            companyName: value.companyName,
            phoneNumber: value.phoneNumber,
            association: value.association,
            companyDes: value.companyDescription,
            profileImage: state.selectedImage,
            countryCode: state.selectedCountrycode.isEmpty ? "${user.countryCode}" : state.selectedCountrycode,
            countryNameCode: state.selectedCountryFlag.isEmpty ? "${user.countryNameCode}" : state.selectedCountryFlag,
          );

          emit(
            state.copyWith(
              editProfileFailureOrSuccessOption: optionOf(failureOrSuccess),
              isSubmitting: false,
            ),
          );
        },
        changeProfilePic: (ChangeProfilePic value) {
          emit(state.copyWith(selectedImage: value.path));
        },
      );
    });
  }

  @override
  void onEvent(EditProfileEvent event) {
    Log.debug("event $event");
    super.onEvent(event);
  }
}
