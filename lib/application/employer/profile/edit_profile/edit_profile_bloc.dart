import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
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

        },
        lastNameChanged: (value) {},
        companyDescChanged: (value) {},
        companyNameChanged: (value) {},
        selectCountryCode: (value) {},
        phoneNumberChanged: (value) {},
        associationTextChanged: (value) {},
        updateProfile: (value) {},
      );
    });
  }
}
