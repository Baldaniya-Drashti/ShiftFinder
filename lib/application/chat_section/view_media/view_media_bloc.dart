import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';
part 'view_media_state.dart';
part 'view_media_event.dart';
part 'view_media_bloc.freezed.dart';

@injectable
class ViewMediaBloc extends Bloc<ViewMediaEvent, ViewMediaState> {
  ViewMediaBloc() : super(ViewMediaState.initial()) {
    on<ViewMediaEvent>((event, emit) async {
      await event.map(
        setupVideo: (e) async {
          final controller = VideoPlayerController.networkUrl(
            Uri.parse(e.mediaUrl),
          );
          await controller.initialize();
          controller.addListener(() {
            if (controller.value.position == controller.value.duration) {
              add(const ViewMediaEvent.videoCompleted());
            }
          });
          emit(state.copyWith(
            controller: controller,
            isPlaying: false,
            isVideoComplete: false,
            mediaUrl: e.mediaUrl,
            type: 2,
          ));
        },
        videoCompleted: (e) async {
          emit(
            state.copyWith(isVideoComplete: true, isPlaying: false),
          );
        },
        playVideo: (e) async {
          final controller = state.controller;
          if (controller != null && !controller.value.isPlaying) {
            await controller.play();
            emit(state.copyWith(isPlaying: true));
          }
        },
        pauseVideo: (e) async {
          final controller = state.controller;
          if (controller != null && controller.value.isPlaying) {
            await controller.pause();
            emit(
              state.copyWith(
                isPlaying: false,
              ),
            );
          }
        },
        getArgs: (e) async {
          emit(state.copyWith(
            mediaUrl: e.mediaUrl,
            type: e.type,
          ));
        },
        disposeVideo: (e) async {
          final controller = state.controller;
          if (controller != null) {
            controller.dispose();
          }
        },
      );
    });
  }
}
