part of 'previous_shift_bloc.dart';

@freezed
class PreviousShiftEvent with _$PreviousShiftEvent {
  factory PreviousShiftEvent.tabChangeEvent({
    required int tabIndex,
  }) = TabChangeEvent;

  factory PreviousShiftEvent.ratingChangeEvent({
    required int rating,
  }) = RatingChangeEvent;
  factory PreviousShiftEvent.fetchAllPreviousPost({
    required bool refresh,
  }) = FetchAllPreviousPost;

  factory PreviousShiftEvent.fetchFavoriteList({
    required bool refresh,
  }) = FetchFavoriteList;

  factory PreviousShiftEvent.fetchBlockedList({
    required bool refresh,
  }) = FetchBlockedList;
  factory PreviousShiftEvent.fetchRemarkedList({
    required bool refresh,
  }) = FetchRemarkedList;

  factory PreviousShiftEvent.deleteRemarkedPost({
    required int id,
  }) = DeleteRemarkedPost;

  factory PreviousShiftEvent.blockUnblockPost({
    required int userId,
    required int postId,
    required BuildContext context,
  }) = BlockPost;



  factory PreviousShiftEvent.leaveRating({
    required int id,
  }) = LeaveRating;
  factory PreviousShiftEvent.addFavorite({
    required int postId,
    required int userId,
    required BuildContext context,
  }) = AddFavorite;
  factory PreviousShiftEvent.addUnFavorite({
    required int postId,
    required int userId,
    required BuildContext context,
  }) = AddUnFavorite;
}




