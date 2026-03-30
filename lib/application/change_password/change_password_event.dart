part of 'change_password_bloc.dart';

@freezed
class ChangePasswordEvent with _$ChangePasswordEvent {
  const factory ChangePasswordEvent.changePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) = _ChangePassword;
}
