// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:video_player/video_player.dart';

@RoutePage(name: 'introVideoScreen')

// class IntroVideoScreen extends StatelessWidget {
//   const IntroVideoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Column(),
//     );
//   }
// }

class IntroVideoScreen extends StatefulWidget {
  @override
  IntroVideoScreenState createState() => IntroVideoScreenState();
}

class IntroVideoScreenState extends State<IntroVideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Expanded(
                      // aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(
                        _controller,
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              // FutureBuilder(
              //   future: _initializeVideoPlayerFuture,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       return AspectRatio(
              //         aspectRatio: _controller.value.aspectRatio,
              //         child: Stack(
              //           alignment: Alignment.bottomCenter,
              //           children: [
              //             VideoPlayer(_controller),
              //             _PlayPauseOverlay(controller: _controller),
              //             VideoProgressIndicator(_controller,
              //                 allowScrubbing: true),
              //           ],
              //         ),
              //       );
              //     } else {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //   },
              // ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              // width: getSize(230),
              width: getSize(300),
              margin: EdgeInsets.symmetric(
                  horizontal: getSize(20), vertical: getSize(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BaseText(
                    text: StringConstant.introVideo,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.white,
                    fontFamily: "Aclonica",
                  ),
                  SizedBox(height: getSize(8)),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: getFontSize(12),
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                      text: StringConstant.introVideoDesc,
                      children: [
                        TextSpan(
                          text: StringConstant.introShiftFinder,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: StringConstant.introApp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                      backgroundColor: AppColors.videoIndicatorBackgroundColor,
                      playedColor: AppColors.primaryColor),
                ),
              ),
            ),
          ),
          _PlayPauseOverlay(
            controller: _controller,
          ),
          CommonAppBar(
            onBackPressed: () {
              context.router.maybePop();
            },
            title: StringConstant.introVideoQuiz,
          ),
        ],
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  // color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}
