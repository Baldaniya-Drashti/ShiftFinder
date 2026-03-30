part of 'employer_completed_shift_bloc.dart';

@freezed
class EmployerCompletedShiftEvent with _$EmployerCompletedShiftEvent {
  factory EmployerCompletedShiftEvent.tabChangeEvent({
    required int tabIndex,
  }) = TabChangeEvent;

  factory EmployerCompletedShiftEvent.ratingChangeEvent({
    required RatingDropdownModel rating,
  }) = RatingChangeEvent;

  factory EmployerCompletedShiftEvent.fetchAllCompletedPost({
    required bool refresh,
    required int sortBy,
  }) = FetchAllCompletedPost;

  factory EmployerCompletedShiftEvent.fetchFavoriteList({
    required bool refresh,
  }) = FetchFavoriteList;

  factory EmployerCompletedShiftEvent.fetchBlockedList({
    required bool refresh,
  }) = FetchBlockedList;

  factory EmployerCompletedShiftEvent.fetchRemarkedList({
    required bool refresh,
  }) = FetchRemarkedList;

  factory EmployerCompletedShiftEvent.deleteRemarkedPost({
    required int id,
  }) = DeleteRemarkedPost;

  factory EmployerCompletedShiftEvent.blockUnblockPost({
    required int userId,
    required int postId,
    required BuildContext context,
  }) = BlockPost;

  factory EmployerCompletedShiftEvent.leaveRating({
    required int userId,
    required int postId,
    required int rating,
    required BuildContext context,
  }) = LeaveRating;

  factory EmployerCompletedShiftEvent.addFavorite({
    required int postId,
    required int userId,
    required BuildContext context,
  }) = AddFavorite;

  factory EmployerCompletedShiftEvent.addUnFavorite({
    required int postId,
    required int userId,
    required BuildContext context,
  }) = AddUnFavorite;

  factory EmployerCompletedShiftEvent.addRemark({
    required int userId,
    required int postId,
    required BuildContext context,
    required String remark,
  }) = AddRemark;

  factory EmployerCompletedShiftEvent.deleteRemark({
    required int id,
    required BuildContext context,
  }) = DeleteRemark;

  factory EmployerCompletedShiftEvent.onFilledSorting(
      LocationDTO currentSorting) = OnFilledSorting;

  const factory EmployerCompletedShiftEvent.getLocationListAPI() =
      GetLocationListAPI;
}
