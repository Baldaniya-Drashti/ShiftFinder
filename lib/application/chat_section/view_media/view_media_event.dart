part of 'view_media_bloc.dart';

@freezed
class ViewMediaEvent with _$ViewMediaEvent {
  //setup video
  const factory ViewMediaEvent.setupVideo(String mediaUrl) = _SetupVideo;
  const factory ViewMediaEvent.videoCompleted() = _VideoCompleted;
  const factory ViewMediaEvent.playVideo() = _PlayVideo;
  const factory ViewMediaEvent.pauseVideo() = _PauseVideo;

  const factory ViewMediaEvent.getArgs(String mediaUrl, int type) = _GetArgs;
  const factory ViewMediaEvent.disposeVideo() = _DisposeVideo;
}
