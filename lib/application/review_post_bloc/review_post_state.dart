part of 'review_post_bloc.dart';

@freezed
class ReviewPostState with _$ReviewPostState {
  const factory ReviewPostState({
    required HealthcarePostDTO post,
    required bool isLoading,
  }) = _ReviewPostState;

  factory ReviewPostState.initial() => ReviewPostState(
        post: HealthcarePostDTO(),
        isLoading: false,
      );
}
