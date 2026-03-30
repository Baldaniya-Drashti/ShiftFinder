part of 'shift_action_bloc.dart';

@freezed
class ShiftActionState with _$ShiftActionState {
  const factory ShiftActionState({
    @Default(false) final bool loading,
    @Default(false) final bool postLoading,
    @Default(false) final bool error,
    @Default(false) final bool noDateFound,
    final int? postId,
    final int? userId,
    final EmployerPreviousShiftDto? employerPreviousShift,
  }) = _ShiftActionState;
}
