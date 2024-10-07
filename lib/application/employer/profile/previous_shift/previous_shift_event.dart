part of 'previous_shift_bloc.dart';

@freezed
class PreviousShiftEvent with _$PreviousShiftEvent {
  factory PreviousShiftEvent.tabChangeEvent({
    required int tabIndex,
  }) = TabChangeEvent;

  factory PreviousShiftEvent.ratingChangeEvent({
    required double rating,
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
    required int id,
  }) = BlockUnblockPost;


  factory PreviousShiftEvent.leaveRating({
    required int id,
  }) = LeaveRating;

}




