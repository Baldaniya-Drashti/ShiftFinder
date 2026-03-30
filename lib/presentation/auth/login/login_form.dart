// ignore_for_file: avoid_print, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:shift/application/auth/login_form/login_form_bloc.dart';
import 'package:shift/application/splash/splash_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/auth/login/forgot_password.dart';
import 'package:shift/presentation/auth/register/verify_mobile_number.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
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
import 'package:shift/presentation/splash/splash_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginFormBloc, LoginFormState>(
      listener: (_, state) {
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
              context
                  .read<SplashBloc>()
                  .add(SplashEvent.initDynamicLink(context));
              if (r.isProfileComplete == 1) {
                if (getCurrentRole() == 2) {
                  context.router.replace(PageRouteInfo(MainTabView.name));
                } else {
                  context.router
                      .replace(PageRouteInfo(ContractorMainTabView.name));
                }
              } else {
                context.router.replace(
                    getCurrentPage(r.lastPage ?? '', fromSplash: true));
              }
            },
          ),
        );
        state.verificationFailureOrSuccessOption.fold(
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
              AppFocus.unfocus(context);
            },
            (r) {
              AppFocus.unfocus(context);
              VerifyPhoneNumber().getVerifyPhoneNoBottomSheet(
                context,
                (getCurrentRole() == 1)
                    ? "${r.phone}"
                    : state.emailId.getValue(),
                getCurrentUser().countryCode ?? '',
                getCurrentUser().countryNameCode ?? '',
                state.password.getValue() ?? '',
              );
            },
          ),
        );
      },
      builder: (context, state) {
        return KeyboardActions(
          config: CustomKeyboardConfig(
            focusNode: [
              state.mobileNumberFocusNode,
            ],
          ).buildConfig(context),
          child: SingleChildScrollView(
            child: BackGroundImage(
              imageString: PngImageConstants.login_frame,
              child: Form(
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    mainView(state, context),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: getSize(33)),
                        child: createAccount(
                          onRegisterTap: () async {
                            context.router.replace(
                                const PageRouteInfo(RegisterPage.name));
                          },
                          title: StringConstant.dontHaveAnAccount,
                          description: StringConstant.register,
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

  RichText createAccount(
      {required String title,
      required String description,
      required VoidCallback onRegisterTap}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: AppColors.black,
          fontSize: getFontSize(14),
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: '$title  ',
          ),
          TextSpan(
            text: description,
            style: TextStyle(
              fontSize: getFontSize(14),
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = onRegisterTap,
          ),
        ],
      ),
      textScaler: const TextScaler.linear(1),
    );
  }

  Widget mainView(LoginFormState state, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(35)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(25),
          ),
          BaseText(
            text: StringConstant.login,
            style: TextStyle(
              fontSize: getFontSize(20),
              fontWeight: FontWeight.w400,
              fontFamily: "Aclonica",
            ),
          ),
          BaseText(
            text: StringConstant.welcomeBack,
            style: TextStyle(
              fontSize: getFontSize(14),
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto Flex",
            ),
          ),
          SizedBox(
            height: getSize(28),
          ),
          CustomTextField(
            hintText: StringConstant.email,
            labelText: StringConstant.email,
            keyboardType: TextInputType.emailAddress,
            maxLength: 340,
            errorMaxLines: 2,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(14),
                vertical: getSize(14),
              ),
              child: SvgPicture.asset(
                SvgImageConstant.email,
                height: getSize(24),
                width: getSize(24),
                color: AppColors.primaryColor,
              ),
            ),
            focusNode: state.mobileNumberFocusNode,
            onChanged: (value) => context
                .read<LoginFormBloc>()
                .add(LoginFormEvent.emailChanged(value)),
            validator: (_, context) => context
                .read<LoginFormBloc>()
                .state
                .emailId
                .value
                .fold(
                  (f) => f.maybeMap(
                    empty: (value) => StringConstant.pleaseEnterEmail,
                    invalidEmail: (_) => StringConstant.pleaseEnterValidEmail,
                    orElse: () => null,
                  ),
                  (_) => null,
                ),
          ),
          SizedBox(
            height: getSize(20),
          ),
          CustomTextField(
            hintText: StringConstant.password,
            labelText: StringConstant.password,
            maxLength: 16,
            errorMaxLines: 3,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(14),
                vertical: getSize(14),
              ),
              child: SvgPicture.asset(
                SvgImageConstant.lock,
                height: getSize(24),
                width: getSize(24),
                color: AppColors.primaryColor,
              ),
            ),
            obscureText: state.isObscure,
            suffixIcon: GestureDetector(
              onTap: () {
                context.read<LoginFormBloc>().add(LoginFormEvent.obscureText());
              },
              child: Container(
                color: AppColors.transparent,
                padding: EdgeInsets.all(getSize(9)),
                child: SvgPicture.asset(
                  (state.isObscure)
                      ? SvgImageConstant.closeEye
                      : SvgImageConstant.openEye,
                  height: getSize(24),
                  width: getSize(24),
                ),
              ),
            ),
            onChanged: (value) => context
                .read<LoginFormBloc>()
                .add(LoginFormEvent.passwordChanged(value)),
            validator: (_, context) =>
                context.read<LoginFormBloc>().state.password.value.fold(
                      (f) => f.maybeMap(
                        empty: (value) => StringConstant.pleaseEnterPassword,
                        /* shortPassword: (_) =>
                            StringConstant.passwordShouldBeMinimum8Digit,
                        invalidPassword: (value) =>
                            StringConstant.pleaseEnterCorrectPasswordFormat, */
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
          ),
          SizedBox(
            height: getSize(10),
          ),
          GestureDetector(
            onTap: () {
              FilterBottomSheet().getForgotPassBottomSheet(context);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: BaseText(
                text: "${StringConstant.forgotPassword}?",
                textAlign: TextAlign.end,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textColor: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: getSize(105),
          ),
          CommonButton(
            isSubmitting: state.isSubmitting,
            onPressed: () {
              context
                  .read<LoginFormBloc>()
                  .add(const LoginFormEvent.loginPressed());
            },
            borderRadius: 30,
            buttonText: StringConstant.login,
          ),
        ],
      ),
    );
  }
}
