// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/legal_screening_dto/legal_screening_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';

import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'legalScreeningQuestionsPage')
class LegalScreeningQuestionsPage extends StatelessWidget {
  bool isFromSplash = false;

  LegalScreeningQuestionsPage({super.key, this.isFromSplash = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LegalScreeningBloc>()
        ..add(LegalScreeningEvent.getLegalScreeningQuestionList()),
      child: BlocConsumer<LegalScreeningBloc, LegalScreeningState>(
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
          state.submitFailureOrSuccessOption.fold(
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
              (r) {
                context.router
                    .push(const PageRouteInfo(TermsAndConditionsScreen.name));
              },
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              isShowBackBtn: !isFromSplash,
              onBackPressed: () {
                context.router.maybePop();
              },
              title: StringConstant.legalScreening,
            ),
            body: (state.isSubmitting)
                ? CenterLoadingIndicator()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: state.questionList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              print("IS SUBMITTING--->  ${state.isSubmitting}");
                              LegalScreeningDTO currentQuestion =
                                  state.questionList[index];
                              return questionBox(
                                state,
                                numberOfQuestion: index + 1,
                                questionModel: currentQuestion,
                                questionText: currentQuestion.name ?? "",
                                showNAButton: currentQuestion.isNa ?? 1,
                                yesOnPressed: () {
                                  context.read<LegalScreeningBloc>().add(
                                      LegalScreeningEvent.storeAnswerEvent(
                                          index, 1));
                                },
                                noOnPressed: () {
                                  context.read<LegalScreeningBloc>().add(
                                      LegalScreeningEvent.storeAnswerEvent(
                                          index, 2));
                                },
                                notApplicableOnPressed: () {
                                  context.read<LegalScreeningBloc>().add(
                                      LegalScreeningEvent.storeAnswerEvent(
                                          index, 0));
                                },
                              );
                            },
                          ),
                          if (state.showErrorMessages && !state.isAllAnswered)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: BaseText(
                                text:
                                    StringConstant.youMustAnswerAllTheQuestions,
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: getFontSize(11),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: getSize(10)),
                            child: confirmationCheckBox(context, state),
                          ),
                          Visibility(
                            visible:
                                (state.showErrorMessages && !state.isCheck),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: BaseText(
                                text:
                                    StringConstant.legalScreeningTermsErrorText,
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: getFontSize(11),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: getSize(40), bottom: getSize(20)),
                            child: CommonButton(
                              onPressed: () {
                                context.read<LegalScreeningBloc>().add(
                                    LegalScreeningEvent.continueBtnPressed());
                              },
                              buttonText: StringConstant.txtContinue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget questionBox(
    LegalScreeningState state, {
    required LegalScreeningDTO questionModel,
    required int numberOfQuestion,
    required int showNAButton,
    required String questionText,
    required VoidCallback yesOnPressed,
    required VoidCallback noOnPressed,
    required VoidCallback notApplicableOnPressed,
  }) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getSize(12), vertical: getSize(12)),
      margin: EdgeInsets.symmetric(vertical: getSize(10)),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: "$numberOfQuestion. ",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              Flexible(
                child: BaseText(
                  text: questionText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              (questionModel.answer == 0)
                  ? SvgPicture.asset(
                      SvgImageConstant.notApplicable,
                      height: getSize(16),
                      width: getSize(23),
                    )
                  : (questionModel.answer == 1 || questionModel.answer == 2)
                      ? SvgPicture.asset(
                          (questionModel.answer == 1)
                              ? SvgImageConstant.icYes
                              : SvgImageConstant.icNo,
                          height: getSize(24),
                          width: getSize(24),
                        )
                      : Container(),
            ],
          ),
          if (questionModel.answer == null) ...[
            SizedBox(
              height: getSize(10),
            ),
            Row(
              children: [
                answerButton(
                  onPressed: yesOnPressed,
                  buttonText: StringConstant.yes,
                  buttonColor: AppColors.primaryColor,
                ),
                SizedBox(width: getSize(20)),
                answerButton(
                  onPressed: noOnPressed,
                  buttonText: StringConstant.no,
                  buttonColor: AppColors.redAccent,
                ),
                SizedBox(width: getSize(20)),
                if (showNAButton == 1)
                  answerButton(
                    onPressed: notApplicableOnPressed,
                    buttonText: StringConstant.notApplicable,
                    buttonColor: AppColors.purple,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget confirmationCheckBox(BuildContext context, LegalScreeningState state) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getSize(12), vertical: getSize(12)),
      // margin: EdgeInsets.symmetric(vertical: getSize(10)),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: getSize(20),
            width: getSize(16.67),
            // color: Colors.green,
            child: Checkbox(
              value: state.isCheck,
              activeColor: AppColors.primaryColor,
              side: BorderSide(
                width: getSize(1.5),
                color: AppColors.black.withOpacity(0.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onChanged: (value) {
                if (value != null) {
                  context
                      .read<LegalScreeningBloc>()
                      .add(LegalScreeningEvent.checkTermsConfirmation(value));
                }
              },
            ),
          ),
          SizedBox(
            width: getSize(10),
          ),
          Flexible(
            child: BaseText(
              text: StringConstant.legalScreeningConfirmationDesc,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget answerButton({
    required VoidCallback onPressed,
    required Color buttonColor,
    required String buttonText,
  }) {
    return CommonButton(
      onPressed: onPressed,
      buttonText: buttonText,
      buttonFontSize: 12,
      width: getSize(60),
      height: getSize(26),
      borderRadius: 7,
      backgroundColor: buttonColor.withOpacity(0.15),
      buttonTextColor: buttonColor,
    );
  }
}

// class QuestionModel {
//   String? question;
//   bool showNotApplicableButton;
//   String? answer;
//   QuestionModel(
//       {this.question, this.showNotApplicableButton = false, this.answer});
// }
