part of 'shift_action_bloc.dart';

@freezed
class ShiftActionEvent with _$ShiftActionEvent {
  const factory ShiftActionEvent.getEmployerData({
    required BuildContext context,
    required int postId,
    required int userId,
  }) = GetEmployerData;

  factory ShiftActionEvent.addRemark({
    required int userId,
    required int postId,
    required BuildContext context,
    required String remark,
  }) = AddRemark;

  factory ShiftActionEvent.addFavorite({
    required int postId,
    required int userId,
    required BuildContext context,
  }) = AddFavorite;

  factory ShiftActionEvent.addUnFavorite({
    required int postId,
    required int userId,
    required BuildContext context,
  }) = AddUnFavorite;

  factory ShiftActionEvent.leaveRating({
    required int userId,
    required int postId,
    required int rating,
    required BuildContext context,
  }) = LeaveRating;

  factory ShiftActionEvent.blockUnblockPost({
    required int userId,
    required int postId,
    required BuildContext context,
  }) = BlockPost;

}
