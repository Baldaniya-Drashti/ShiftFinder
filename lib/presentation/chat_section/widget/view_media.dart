import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/chat_section/view_media/view_media_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/pdf_viewer.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:video_player/video_player.dart';

@RoutePage(name: 'viewmedia')
class ViewMedia extends StatelessWidget {
  final String mediaUrl;
  final int type; //1:image, 2:video ,3:document

  const ViewMedia({super.key, required this.mediaUrl, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ViewMediaBloc>()
        ..add(
          type == 2
              ? ViewMediaEvent.setupVideo(mediaUrl)
              : ViewMediaEvent.getArgs(mediaUrl, type),
        ),
      child: BlocConsumer<ViewMediaBloc, ViewMediaState>(
        listener: (context, state) {},
        builder: (context, state) {
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) {
              if (type == 2) {
                context
                    .read<ViewMediaBloc>()
                    .add(const ViewMediaEvent.disposeVideo());
              }
            },
            child: Scaffold(
              appBar: CommonAppBar(
                title: type == 1
                    ? StringConstant.image
                    : type == 2
                        ? StringConstant.video
                        : StringConstant.document,
                onBackPressed: () {
                  context.router.maybePop();
                },
              ),
              body: SafeArea(
                child: Center(
                    child: type == 1
                        ? CachedNetworkImage(
                            imageUrl: mediaUrl,
                          )
                        : type == 2
                            ? state.controller != null &&
                                    state.controller!.value.isInitialized
                                ? VideoPlayer(
                                    state.controller!,
                                  )
                                : SizedBox()
                            : ContractorPdfViewer(
                                pdfUrl: mediaUrl, hideAppBar: true)),
              ),
              bottomNavigationBar: (type == 2 &&
                      state.controller != null &&
                      state.controller!.value.isInitialized)
                  ? SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _PlayPauseButton(
                              controller: state.controller!,
                            ),
                          ],
                        ),
                      ),
                    )
                  : null,
            ),
          );
        },
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
                .read<ViewMediaBloc>()
                .add(const ViewMediaEvent.pauseVideo());
          } else {
            context.read<ViewMediaBloc>().add(const ViewMediaEvent.playVideo());
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
      ),
    );
  }

  Widget pauseButton() {
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
          SvgImageConstant.pause,
          colorFilter: const ColorFilter.mode(
            AppColors.white,
            BlendMode.srcIn,
          ),
        ));
  }
}
