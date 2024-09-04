// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart';
// import 'package:shift/domain/core/math_utils.dart';
// import 'package:shift/domain/core/string_constant.dart';
// import 'package:shift/injection.dart';
// import 'package:shift/presentation/common/widgets/base_text.dart';
// import 'package:shift/presentation/core/style/app_colors.dart';
// import 'package:shift/presentation/main/widgets/home_app_bar.dart';

// @RoutePage(name: 'introQuizScreen')
// class IntroQuizScreen extends StatelessWidget {
//   IntroQuizScreen({super.key});

//   var questionList = [
//     QuizModel(
//       question:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna?",
//       mcqList: [
//         QuizMcq(
//           option1: "Long Term Care",
//           option2: "Hospital",
//           option3: "Community",
//           option4: "Retail",
//         ),
//       ],
//     ),
//     QuizModel(
//       question:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna?",
//       mcqList: [
//         QuizMcq(
//           option1: "Long Term Care",
//           option2: "Hospital",
//           option3: "Community",
//           option4: "Retail",
//         ),
//       ],
//     ),
//     QuizModel(
//       question:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna?",
//       mcqList: [
//         QuizMcq(
//           option1: "Long Term Care",
//           option2: "Hospital",
//           option3: "Community",
//           option4: "Retail",
//         ),
//       ],
//     ),
//     QuizModel(
//       question:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna?",
//       mcqList: [
//         QuizMcq(
//           option1: "Long Term Care",
//           option2: "Hospital",
//           option3: "Community",
//           option4: "Retail",
//         ),
//       ],
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<IntroVideoBloc>(),
//       child: BlocConsumer<IntroVideoBloc, IntroVideoState>(
//         listener: (context, state) {
//
//         },
//         builder: (context, state) {
//           return Scaffold(
//             appBar: CommonAppBar(
//               onBackPressed: () {
//                 context.router.maybePop();
//               },
//               title: StringConstant.quiz,
//             ),
//             body: Padding(
//               padding: EdgeInsets.symmetric(horizontal: getSize(20)),
//               child: ListView.builder(
//                   itemCount: questionList.length,
//                   itemBuilder: (context, index) {
//                     return questionBox(index);
//                   }),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget questionBox(int index) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.grey04,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(7),
//             ),
//             child: BaseText(
//               text: questionList[index].question ?? "",
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: questionList[index].mcqList?.length,
//               itemBuilder: (context, index) {
//                 var mcqList = questionList[index].mcqList ?? [];
//                 return mcqCheckbox(
//                   mcqOption: mcqList[index].option2 ?? "",
//                 );
//               }),
//         ],
//       ),
//     );
//   }

//   Widget mcqCheckbox({required String mcqOption}) {
//     return Row(
//       children: [
//         SizedBox(
//           height: getSize(20),
//           width: getSize(16.67),
//           // color: Colors.green,
//           child: Checkbox(
//             value: true,
//             activeColor: AppColors.primaryColor,
//             side: BorderSide(
//               width: getSize(1.5),
//               color: AppColors.black.withOpacity(0.5),
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//             onChanged: (value) {
//               if (value != null) {}
//             },
//           ),
//         ),
//         BaseText(text: mcqOption ?? "")
//       ],
//     );
//   }
// }

// class QuizModel {
//   String? question;
//   List<QuizMcq>? mcqList;
//   QuizModel({this.mcqList, this.question});
// }

// class QuizMcq {
//   String? option1;
//   String? option2;
//   String? option3;
//   String? option4;

//   QuizMcq({this.option1, this.option2, this.option3, this.option4});
// }

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/quiz_dto/quiz_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/common_card_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'introQuizScreen')
class IntroQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<IntroVideoBloc>()..add(IntroVideoEvent.getQuizQuestionlist()),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.quiz,
        ),
        body: BlocConsumer<IntroVideoBloc, IntroVideoState>(
          listener: (context, state) {
            state.authFailureOrSuccessOption.fold(
              () {},
              (either) => either.fold(
                (failure) {
                  showError(
                    message: failure.maybeMap(
                      showAPIResponseMessage: (value) => value.message,
                      networkError: (value) =>
                          'Please check your internet connectivity',
                      orElse: () => "Server Error. Try again later.",
                    ),
                  ).show(context);
                },
                (r) {},
              ),
            );
            state.quizAuthFailureOrSuccessOption.fold(
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
                  print("GO TO NEXT SCREEN!");
                  showResultDialog(context, r);
                  // showunderDevelopment(context);
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
                              color: AppColors.grey04,
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
                                  if (question.answers != null)
                                    ...question.answers!.map((option) {
                                      return GestureDetector(
                                        onTap: () {
                                          context.read<IntroVideoBloc>().add(
                                                IntroVideoEvent.optionSelected(
                                                  questionIndex: index,
                                                  selectedOption: option,
                                                ),
                                              );
                                        },
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: (question
                                                          .selectedAnswers !=
                                                      null)
                                                  ? question.selectedAnswers!
                                                      .contains(option)
                                                  : false,
                                              onChanged: (isSelected) {
                                                context
                                                    .read<IntroVideoBloc>()
                                                    .add(
                                                      IntroVideoEvent
                                                          .optionSelected(
                                                        questionIndex: index,
                                                        selectedOption: option,
                                                      ),
                                                    );
                                              },
                                              activeColor:
                                                  AppColors.primaryColor,
                                              side: BorderSide(
                                                width: getSize(1.5),
                                                color: AppColors.black
                                                    .withOpacity(0.5),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
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
                        if (state.showQuizErrorMessages &&
                            !(state.questions.every((element) {
                              return (element.selectedAnswers != null &&
                                  element.selectedAnswers!.isNotEmpty);
                            })))
                          commonErrorText(
                              "* ${StringConstant.pleaseCompleteAllQuestionOfQuiz}"),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getSize(20), horizontal: getSize(20)),
                            child: CommonButton(
                              onPressed: () {
                                context
                                    .read<IntroVideoBloc>()
                                    .add(const IntroVideoEvent.submitQuiz());
                              },
                              buttonText: StringConstant.submitTheQuiz,
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

  showResultDialog(BuildContext context, QuizAnswerDTO result) {
    // return AppDialog.showSuccess(
    //   context,
    //   title: StringConstant.result,
    //   infoMessage: StringConstant.resultDesc,
    //   image: Image.asset(PngImageConstants.result),
    //   otherContent: Container(
    //     alignment: Alignment.center,
    //     padding:
    //         EdgeInsets.symmetric(horizontal: getSize(10), vertical: getSize(5)),
    //     margin: EdgeInsets.only(top: getSize(20)),
    //     decoration: BoxDecoration(
    //       color: AppColors.grey04,
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         answreTile(
    //             title: StringConstant.correctAnswers,
    //             image: SvgImageConstant.checkedArrow,
    //             answer: "${result.total_correct_question ?? 0}"),
    //         answreTile(
    //             title: StringConstant.incorrectAnswers,
    //             image: SvgImageConstant.wrong,
    //             answer: "${result.total_wrong_question ?? 0}"),
    //       ],
    //     ),
    //   ),
    //   onOkClick: () {
    //     Navigator.pop(context);
    //   },
    // );

    return CommonCardDialog(
      onPressed: () {
        Navigator.pop(context, true);
      },
      onCallback: (value) {
        if (value == true) {
          print("callback value---> ${value}");
          context.router.push(PageRouteInfo(QuizResultScreen.name));
        }
      },
      title: StringConstant.result,
      description: StringConstant.resultDesc,
      buttonText: StringConstant.ok,
      image: SvgImageConstant.result,
      barrierDismissible: false,
      otherContent: Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.symmetric(horizontal: getSize(10), vertical: getSize(5)),
        margin: EdgeInsets.only(top: getSize(20)),
        decoration: BoxDecoration(
          color: AppColors.grey04,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            answerTile(
                title: StringConstant.correctAnswers,
                image: SvgImageConstant.checkedArrow,
                answer: "${result.total_correct_question ?? 0}"),
            answerTile(
                title: StringConstant.incorrectAnswers,
                image: SvgImageConstant.wrong,
                answer: "${result.total_wrong_question ?? 0}"),
          ],
        ),
      ),
    ).addCardDialog(context);
  }

  Widget answerTile({
    required String title,
    required String image,
    required String answer,
  }) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      horizontalTitleGap: getSize(10),
      leading: SvgPicture.asset(
        image,
        height: getSize(20),
        width: getSize(20),
      ),
      title: BaseText(
        text: title,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      trailing: BaseText(
        text: (answer.length == 2) ? answer : "0$answer",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: "Aclonica",
      ),
    );
  }
}
