// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'quizResultScreen')
class QuizResultScreen extends StatelessWidget {
  String totalCorrectAnswer = "00";
  String totalWrongAnswer = "00";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<IntroVideoBloc>()..add(IntroVideoEvent.getQuizResultlist()),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.result,
        ),
        body: BlocConsumer<IntroVideoBloc, IntroVideoState>(
          listener: (context, state) {
            state.quizResultFailureOrSuccessOption.fold(
              () {},
              (either) => either.fold(
                (failure) {
                  print("showAPIResponseMessage---> $failure");

                  showError(
                    message: failure.maybeMap(
                      showAPIResponseMessage: (value) => value.message,
                      networkError: (value) =>
                          'Please check your internet connectivity',
                      orElse: () => "Server Error. Try again later.",
                    ),
                  ).show(context);
                },
                (r) {
                  totalCorrectAnswer = "${r.total_correct_question ?? 00}";
                  totalWrongAnswer = "${r.total_wrong_question ?? 00}";
                  print("GO TO NEXT SCREEN!");
                  // context.router.push(const PageRouteInfo(MainTabView.name));
                },
              ),
            );
          },
          builder: (context, state) {
            return (state.isSubmitting)
                ? CenterLoadingIndicator()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        resultImage(),
                        ListView.builder(
                          itemCount: state.questions.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final question = state.questions[index];
                            return Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(
                                  horizontal: getSize(20),
                                  vertical: getSize(10)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: getSize(10),
                                  vertical: getSize(10)),
                              decoration: BoxDecoration(
                                  color: AppColors.grey04,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getSize(10),
                                        vertical: getSize(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BaseText(
                                          text: "${index + 1}. ",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        Flexible(
                                          child: BaseText(
                                            text: question.question ?? "",
                                            textAlign: TextAlign.start,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: getSize(10),
                                  ),
                                  if (question.answers != null)
                                    ...question.answers!.map((option) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: getSize(7)),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              (option.correct_answer == true)
                                                  ? SvgImageConstant
                                                      .checkedArrow
                                                  : SvgImageConstant.wrong,
                                              height: getSize(20),
                                              width: getSize(20),
                                            ),
                                            SizedBox(
                                              width: getSize(15),
                                            ),
                                            BaseText(
                                              text: option.answer ?? "",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                ],
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getSize(20), horizontal: getSize(20)),
                            child: CommonButton(
                              onPressed: () {
                                showUnderDevelopment(context);
                              },
                              buttonText: StringConstant.txtContinue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget resultImage() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getSize(20), horizontal: getSize(36.025)),
      margin:
          EdgeInsets.symmetric(horizontal: getSize(20), vertical: getSize(10)),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          leading: SvgPicture.asset(
            SvgImageConstant.clockWithVerticalLine,
            height: getSize(63),
            width: getSize(57.95),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: StringConstant.yourScore,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                lineHeight: 1.5,
              ),
              SizedBox(
                height: getSize(5),
              ),
              answerTile(
                title: StringConstant.correctAnswers,
                image: SvgImageConstant.checkedArrow,
                answer: totalCorrectAnswer,
              ),
              SizedBox(
                height: getSize(5),
              ),
              answerTile(
                title: StringConstant.incorrectAnswers,
                image: SvgImageConstant.wrong,
                answer: totalWrongAnswer,
              ),
            ],
          )
          // ],
          ),
    );
  }

  Widget answerTile({
    required String title,
    required String image,
    required String answer,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          image,
          height: getSize(15),
          width: getSize(15),
        ),
        SizedBox(
          width: getSize(10),
        ),
        BaseText(
          text: title,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          width: getSize(10),
        ),
        BaseText(
          text: (answer.length == 2) ? answer : "0$answer",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          fontFamily: "Aclonica",
        ),
      ],
    );
  }

  Widget mcqCheckbox({required String mcqOption}) {
    return Row(
      children: [
        SizedBox(
          height: getSize(20),
          width: getSize(16.67),
          // color: Colors.green,
          child: Checkbox(
            value: true,
            activeColor: AppColors.primaryColor,
            side: BorderSide(
              width: getSize(1.5),
              color: AppColors.black.withOpacity(0.5),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onChanged: (value) {
              if (value != null) {}
            },
          ),
        ),
        BaseText(text: mcqOption)
      ],
    );
  }
}
