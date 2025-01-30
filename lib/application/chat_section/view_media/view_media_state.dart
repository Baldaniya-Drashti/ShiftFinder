part of 'view_media_bloc.dart';

@freezed
class ViewMediaState with _$ViewMediaState {
  const factory ViewMediaState({
    required bool isPlaying,
    required bool isVideoComplete,
    required VideoPlayerController? controller,
    required String mediaUrl,
    required int type,
  }) = _ViewMediaState;

  factory ViewMediaState.initial() => ViewMediaState(
        isPlaying: false,
        isVideoComplete: false,
        controller: null,
        mediaUrl: '',
        type: 0,
      );
}
