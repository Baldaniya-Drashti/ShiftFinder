part of 'account_management_bloc.dart';

@freezed
class AccountManagementEvent with _$AccountManagementEvent {
  const factory AccountManagementEvent.deleteAccount({
    required int id,
  }) = DeleteAccount;
}
