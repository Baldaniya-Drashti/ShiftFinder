part of 'post_shift_bloc.dart';

@freezed
class PostShiftState with _$PostShiftState {
  const factory PostShiftState({
    required int shiftType,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _PostShiftState;

  factory PostShiftState.initial() => PostShiftState(
        shiftType: -1,
        isSubmitting: false,
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),
      );
}
