part of 'change_password_bloc.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    required bool postDataLoading
}) = _CounterProposalDetailState;

  factory ChangePasswordState.initial() => ChangePasswordState(postDataLoading: false);
}
