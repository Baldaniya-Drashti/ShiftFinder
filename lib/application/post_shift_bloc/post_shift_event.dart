part of 'post_shift_bloc.dart';

@freezed
class PostShiftEvent with _$PostShiftEvent {
  /// change shift type
  const factory PostShiftEvent.changeShiftType(String shiftType) =
      ChangeShiftType;
}
