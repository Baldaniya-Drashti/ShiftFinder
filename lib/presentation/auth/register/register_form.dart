// ignore_for_file: avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:shift/application/auth/register_form/register_form_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/back_ground_image.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_keboard_config.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterFormBloc, RegisterFormState>(
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
            (r) {
              print(
                  "${state.firstName.getValue()}  ${state.lastName.getValue()}  ${state.isCheck}");
              context.router.push(
                PageRouteInfo(
                  RegisterProfilePage.name,
                  args: RegisterProfilePageArgs(
                    firstName: state.firstName.getValue(),
                    lastName: state.lastName.getValue(),
                    checkTermsPrivacy: (state.isCheck == true) ? 1 : 0,
                  ),
                ),
              );
            },
          ),
        );
      },
      builder: (context, state) {
        return BackGroundImage(
          imageString: PngImageConstants.register_frame,
          child: Expanded(
            child: KeyboardActions(
              config: CustomKeyboardConfig(
                focusNode: [
                  state.firstNameFocusNode,
                ],
              ).buildConfig(context),
              child: Form(
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    mainView(state, context),
                    GestureDetector(
                      onTap: () {
                        print("Already account clicked!");
                        context.router.pushAndPopUntil(
                            const PageRouteInfo(LoginPage.name),
                            predicate: (route) => false);
                        // context.router.popUntil(
                        //     (route) => route.settings.name == LoginPage.name);
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(33)),
                          child: alreadyHaveAnAccount(
                            title: StringConstant.alreadyHaveAnAccount,
                            description: StringConstant.login,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  RichText alreadyHaveAnAccount(
      {required String title, required String description}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: AppColors.black.withOpacity(0.80),
          fontSize: getFontSize(14),
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(text: '$title  '),
          TextSpan(
            text: description,
            style: TextStyle(
              fontSize: getFontSize(14),
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
      textScaler: const TextScaler.linear(1),
    );
  }

  RichText termsAndCondition({
    required String title,
    required String title1,
    required String terms,
    required String priacyPolicy,
    VoidCallback? onTermsClick,
    VoidCallback? onPrivacyPolicyClick,
  }) {
    return RichText(
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: true,
        leadingDistribution: TextLeadingDistribution.even,
      ),
      maxLines: 2,

      text: TextSpan(
        style: TextStyle(
          color: AppColors.black,
          fontSize: getFontSize(11),
          fontWeight: FontWeight.w400,
          // height: getSize(2),
          // backgroundColor: Colors.yellow,
        ),
        children: [
          TextSpan(
            text: '$title ',
            style: const TextStyle(height: 2),
          ),
          TextSpan(
            text: '$title1 ',
          ),
          TextSpan(
            text: terms,
            style: TextStyle(
              fontSize: getFontSize(11),
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTermsClick,
          ),
          const TextSpan(
            text: ' and ',
          ),
          TextSpan(
            text: priacyPolicy,
            style: TextStyle(
              fontSize: getFontSize(11),
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onPrivacyPolicyClick,
          ),
        ],
      ),
      // textScaler: const TextScaler.linear(1),
    );
  }

  Widget mainView(RegisterFormState state, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(20),
          ),
          BaseText(
            text: StringConstant.register,
            style: TextStyle(
              fontSize: getFontSize(20),
              fontWeight: FontWeight.w400,
              fontFamily: "Aclonica",
            ),
          ),
          BaseText(
            text: (getCurrentRole() == 1)
                ? StringConstant.createYourAccount
                : StringConstant.shiftCoordinatorDetails,
            style: TextStyle(
              fontSize: getFontSize(14),
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto Flex",
            ),
          ),
          SizedBox(
            height: getSize(30),
          ),
          CustomTextField(
            hintText: StringConstant.firstName,
            labelText: StringConstant.firstName,
            textCapitalization: TextCapitalization.words,
            errorMaxLines: 2,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(14),
                vertical: getSize(14),
              ),
              child: SvgPicture.asset(
                SvgImageConstant.person,
                height: getSize(24),
                width: getSize(24),
              ),
            ),
            focusNode: state.firstNameFocusNode,
            onChanged: (value) => context
                .read<RegisterFormBloc>()
                .add(RegisterFormEvent.firstNameChanged(value)),
            validator: (_, context) => context
                .read<RegisterFormBloc>()
                .state
                .firstName
                .value
                .fold(
                  (f) => f.maybeMap(
                    empty: (value) => StringConstant.pleaseEnterYourFirstName,
                    invalidUsername: (value) =>
                        StringConstant.pleaseEnterYourValidFirstName,
                    orElse: () => null,
                  ),
                  (_) => null,
                ),
          ),
          SizedBox(
            height: getSize(20),
          ),
          CustomTextField(
            hintText: StringConstant.lastName,
            labelText: StringConstant.lastName,
            errorMaxLines: 2,
            textCapitalization: TextCapitalization.words,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(14),
                vertical: getSize(14),
              ),
              child: SvgPicture.asset(
                SvgImageConstant.person,
                height: getSize(24),
                width: getSize(24),
              ),
            ),
            onChanged: (value) => context
                .read<RegisterFormBloc>()
                .add(RegisterFormEvent.lastNameChanged(value)),
            validator: (_, context) => context
                .read<RegisterFormBloc>()
                .state
                .lastName
                .value
                .fold(
                  (f) => f.maybeMap(
                    empty: (value) => StringConstant.pleaseEnterYourLastName,
                    invalidUsername: (value) =>
                        StringConstant.pleaseEnterYourValidLastName,
                    orElse: () => null,
                  ),
                  (_) => null,
                ),
          ),
          SizedBox(
            height: getSize(30),
          ),
          termsCheckBox(state, context),
          SizedBox(
            height: getSize(10),
          ),
          if (state.showErrorMessages && !state.isCheck)
            Align(
              alignment: Alignment.centerLeft,
              child: BaseText(
                text: StringConstant.termsPolicyErrorText,
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: getFontSize(11),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          SizedBox(
            height: getSize(50),
          ),
          CommonButton(
            isSubmitting: state.isSubmitting,
            onPressed: () {
              context
                  .read<RegisterFormBloc>()
                  .add(const RegisterFormEvent.registerPressed());
            },
            buttonText: StringConstant.txtContinue,
          ),
        ],
      ),
    );
  }

  Widget termsCheckBox(RegisterFormState state, BuildContext context) {
    return Row(
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
                    .read<RegisterFormBloc>()
                    .add(RegisterFormEvent.checkTermsCondition(value));
              }
            },
          ),
        ),
        SizedBox(
          width: getSize(20),
        ),
        Flexible(
          // color: Colors.red,
          // margin: EdgeInsets.only(left: getSize(10)),
          // width: getFontSize(280),
          child: termsAndCondition(
            title: StringConstant.pleaseCheckTheBoxToConfirmThatYouHaveReviewed,
            title1: StringConstant.andAgreeToOur,
            terms: StringConstant.termsOfService,
            priacyPolicy: StringConstant.privacyPolicy,
          ),
        ),
      ],
    );
  }
}
