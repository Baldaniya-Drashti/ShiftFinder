part of 'review_post_bloc.dart';

@freezed
class ReviewPostEvent with _$ReviewPostEvent {
  const factory ReviewPostEvent.getShiftData({
    int? postId,
    HealthcarePostDTO? post,
  }) = getShiftData;
}
