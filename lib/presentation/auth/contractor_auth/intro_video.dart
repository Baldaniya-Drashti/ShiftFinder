// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:video_player/video_player.dart';

@RoutePage(name: 'introVideoScreen')
class IntroVideoScreen extends StatefulWidget {
  bool isFromSplash = false;
  @override
  IntroVideoScreenState createState() => IntroVideoScreenState();
}

class IntroVideoScreenState extends State<IntroVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<IntroVideoBloc>()..add(const IntroVideoEvent.setupVideo()),
      child: BlocConsumer<IntroVideoBloc, IntroVideoState>(
        listener: (context, state) {
          if (state.isSubmitting) {
            context.router.push(PageRouteInfo(IntroQuizScreen.name));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: (state.controller != null &&
                    state.controller!.value.isInitialized)
                ? Stack(
                    children: [
                      // aspectRatio: _controller.value.aspectRatio,
                      VideoPlayer(
                        state.controller!,
                      ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //     image: AssetImage(
                      //       PngImageConstants.intro__video_image,
                      //     ),
                      //     fit: BoxFit.fill,
                      //   )),
                      // ),
                      introDescription(state.controller!),
                      videoIndicator(state.controller!),
                      _PlayPauseButton(
                        controller: state.controller!,
                      ),
                      CommonAppBar(
                        isShowBackBtn: !widget.isFromSplash,
                        onBackPressed: () {
                          context.router.maybePop();
                        },
                        title: StringConstant.introVideoQuiz,
                      ),
                    ],
                  )
                : CenterLoadingIndicator(),
          );
        },
      ),
    );
  }

  Widget introDescription(VideoPlayerController controller) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        // width: getSize(230),
        width: getHorizontalSize(300),
        margin: EdgeInsets.symmetric(
            horizontal: getSize(20), vertical: getSize(40)),
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
    );
  }

  Widget videoIndicator(VideoPlayerController controller) {
    return Visibility(
      // visible: controller.value.isPlaying,
      child: Padding(
        padding: EdgeInsets.all(getSize(20)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                backgroundColor: AppColors.videoIndicatorBackgroundColor,
                playedColor: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          if (controller.value.isPlaying) {
            context
                .read<IntroVideoBloc>()
                .add(const IntroVideoEvent.pauseVideo());
          } else {
            context
                .read<IntroVideoBloc>()
                .add(const IntroVideoEvent.playVideo());
          }
        },
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: (controller.value.isPlaying) ? pauseButton() : playButton(),
        ),
      ),
    );
  }

  Widget playButton() {
    return Container(
        height: getSize(60),
        width: getSize(60),
        padding: EdgeInsets.all(getSize(18)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            AppColors.primaryColor,
            AppColors.emeraldGreenColor,
          ]),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.play,
        ));
  }

  Widget pauseButton() {
    return Container(
        height: getSize(60),
        width: getSize(60),
        padding: EdgeInsets.all(getSize(18)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          gradient:
              LinearGradient(colors: const [AppColors.white, AppColors.white]),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.pause,
        ));
  }
}
