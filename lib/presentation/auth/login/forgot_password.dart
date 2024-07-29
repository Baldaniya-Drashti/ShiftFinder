// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/core/inputs/custom_pin_field.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

// ignore: must_be_immutable
class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }

  getForgotPassBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.scaffoldColor,
      elevation: 0,
      enableDrag: true,
      useSafeArea: true,
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getSize(30)),
          topRight: Radius.circular(getSize(30)),
        ),
      ),
      builder: (context) {
        return BlocProvider(
          create: (context) => getIt<ForgotPasswordBloc>(),
          child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
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
                    context.read<ForgotPasswordBloc>().add(NextPage(1));
                  },
                ),
              );
              state.verifyOtpFailureOrSuccessOption.fold(
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
                    context.read<ForgotPasswordBloc>().add(NextPage(2));
                  },
                ),
              );

              state.saveNewPassFailureOrSuccessOption.fold(
                () {},
                (either) => either.fold(
                  (failure) {
                    showError(
                      message: failure.maybeMap(
                        showAPIResponseMessage: (value) => value.message,
                        networkError: (value) => 'Connection error',
                        orElse: () => "Server Error. Try again later.",
                      ),
                    ).show(context);
                  },
                  (r) {
                    context.router.maybePop();
                  },
                ),
              );
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.fromLTRB(getSize(20), 0, getSize(20),
                    MediaQuery.of(context).viewInsets.bottom),
                child: SafeArea(
                  child: (state.currentView == 1)
                      ? otpView(context, state)
                      : (state.currentView == 2)
                          ? resetPassword(context, state)
                          : phoneNoView(context, state),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget phoneNoView(BuildContext context, ForgotPasswordState state) {
    return Form(
      autovalidateMode: state.showErrorMessages
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(20),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: BaseText(
                      textAlign: TextAlign.center,
                      text: StringConstant.forgotPassword,
                      fontSize: getSize(20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.maybePop();
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.close_rounded),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: getSize(10),
          ),
          Container(
            width: getSize(280),
            alignment: Alignment.center,
            child: BaseText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: StringConstant.fogotPasswordDesc,
              lineHeight: 1,
              fontSize: getSize(14),
              textColor: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: getSize(50),
          ),
          (getCurrentRole() == 1)
              ? CustomTextField(
                  labelText: StringConstant.phoneNumber,
                  hintText: StringConstant.phoneNumber,
                  keyboardType: TextInputType.phone,
                  errorMaxLines: 2,
                  maxLength: 10,
                  // focusNode: state.mobileNumberFocusNode,
                  onChanged: (value) => context.read<ForgotPasswordBloc>().add(
                        ForgotPasswordEvent.mobileNumberChanged(value),
                      ),
                  validator: (_, context) => context
                      .read<ForgotPasswordBloc>()
                      .state
                      .mobileNumber
                      .value
                      .fold(
                        (f) => f.maybeMap(
                          empty: (value) =>
                              StringConstant.pleaseEnterMobileNumber,
                          invalidMobileNumber: (_) => StringConstant
                              .phoneNumberShouldBeBetween10And15Digits,
                          orElse: () => null,
                        ),
                        (_) => null,
                      ),
                  prefixIcon: CommonCountryCodePicker(
                    initialSelection: state.selectedCountrycode,
                    onChanged: (countryCode) {
                      print(countryCode.flagEmoji);
                      context.read<ForgotPasswordBloc>().add(
                            ForgotPasswordEvent.selectCountryCode(
                              countryCode.flagEmoji,
                            ),
                          );
                    },
                  ),
                )
              : emailTextField(context, state),
          SizedBox(
            height: getSize(90),
          ),
          CommonButton(
            isSubmitting: state.isSubmitting,
            onPressed: () {
              context.read<ForgotPasswordBloc>().add(
                    ForgotPasswordEvent.sendOtpPressed(),
                  );
            },
            buttonText: StringConstant.verify,
            borderRadius: 30,
            height: 50,
          ),
          SizedBox(
            height: getSize(isFullScreenDevice(context) ? 0 : 50),
          ),
        ],
      ),
    );
  }

  Widget emailTextField(BuildContext context, ForgotPasswordState state) {
    return CustomTextField(
      labelText: StringConstant.email,
      isLabelPadding: true,
      hintText: StringConstant.email,
      keyboardType: TextInputType.emailAddress,
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
      onChanged: (value) => context
          .read<ForgotPasswordBloc>()
          .add(ForgotPasswordEvent.emailChanged(value)),
      validator: (p0, p1) =>
          context.read<ForgotPasswordBloc>().state.emailAddress.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterEmail,
                  invalidEmail: (_) => StringConstant.pleaseEnterValidEmail,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget otpView(BuildContext context, ForgotPasswordState state) {
    return Form(
      autovalidateMode: state.showOtpErrorMessages
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(20),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: BaseText(
                      textAlign: TextAlign.center,
                      text: StringConstant.verification,
                      fontSize: getSize(20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.maybePop();
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.close_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: getSize(10),
          ),
          Container(
            width: getSize(280),
            alignment: Alignment.center,
            child: BaseText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: StringConstant.verificationDesc,
              lineHeight: 1,
              fontSize: getSize(14),
              textColor: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: getSize(50),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(58)),
            child: CustomPinField(
              labelWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(
                    text: StringConstant.code,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  BaseText(
                    text: 'Remaining 00:${state.secondsRemaining}',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.black.withOpacity(0.6),
                  ),
                ],
              ),
              onChanged: (value) => context
                  .read<ForgotPasswordBloc>()
                  .add(ForgotPasswordEvent.changeOTP(value)),
              validator: (_, context) => context
                  .read<ForgotPasswordBloc>()
                  .state
                  .enteredOTP
                  .value
                  .fold(
                    (f) => f.maybeMap(
                      empty: (value) => StringConstant.pleaseEnterOtp,
                      exceedingLength: (value) =>
                          StringConstant.otpShouldBe4Digit,
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
            ),
          ),
          SizedBox(
            height: getSize(30),
          ),
          Opacity(
            opacity: state.secondsRemaining == 0 ? 1 : 0.5,
            child: GestureDetector(
              onTap: state.secondsRemaining == 0
                  ? () {
                      context
                          .read<ForgotPasswordBloc>()
                          .add(ForgotPasswordEvent.resendOtp());
                    }
                  : null,
              child: BaseText(
                text: StringConstant.resendCode,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textColor: AppColors.primaryColor,
                textDecoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
            height: getSize(30),
          ),
          CommonButton(
            isSubmitting: state.isSubmitting,
            onPressed: () {
              context
                  .read<ForgotPasswordBloc>()
                  .add(ForgotPasswordEvent.verifyOtp());
            },
            buttonText: StringConstant.verify,
            borderRadius: 30,
            height: 50,
          ),
          SizedBox(
            height: getSize(isFullScreenDevice(context) ? 0 : 45),
          ),
        ],
      ),
    );
  }

  TextEditingController newPasswordController = TextEditingController();
  Widget resetPassword(BuildContext context, ForgotPasswordState state) {
    return Form(
      autovalidateMode: state.showNewPassErrorMessages
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(20),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: BaseText(
                      textAlign: TextAlign.center,
                      text: StringConstant.newPassword,
                      fontSize: getSize(20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.maybePop();
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.close_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: getSize(10),
          ),
          Container(
            width: getSize(280),
            alignment: Alignment.center,
            child: BaseText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: StringConstant.createNewPassword,
              lineHeight: 1,
              fontSize: getSize(14),
              textColor: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: getSize(30),
          ),
          CustomTextField(
            labelText: StringConstant.newPassword,
            hintText: StringConstant.newPassword,
            controller: newPasswordController,
            errorMaxLines: 2,
            maxLength: 10,
            onChanged: (value) => context.read<ForgotPasswordBloc>().add(
                  ForgotPasswordEvent.newPasswordChanged(value),
                ),
            validator: (_, context) =>
                context.read<ForgotPasswordBloc>().state.newPassword.value.fold(
                      (f) => f.maybeMap(
                        empty: (value) => StringConstant.pleaseEnterNewPassword,
                        shortPassword: (_) =>
                            StringConstant.passwordShouldBeMinimum8Digit,
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(14),
                vertical: getSize(14),
              ),
              child: SvgPicture.asset(
                SvgImageConstant.lock,
                height: getSize(24),
                width: getSize(24),
              ),
            ),
            obscureText: state.isNewPassObscure,
            suffixIcon: GestureDetector(
              onTap: () {
                context.read<ForgotPasswordBloc>().add(
                      const ForgotPasswordEvent.obscureText(1),
                    );
              },
              child: SvgPicture.asset(
                (state.isNewPassObscure)
                    ? SvgImageConstant.openEye
                    : SvgImageConstant.closeEye,
                height: getSize(24),
                width: getSize(24),
              ),
            ),
          ),
          SizedBox(
            height: getSize(25),
          ),
          CustomTextField(
            labelText: StringConstant.confirmPassword,
            hintText: StringConstant.confirmPassword,
            errorMaxLines: 2,
            maxLength: 10,
            onChanged: (value) => context.read<ForgotPasswordBloc>().add(
                  ForgotPasswordEvent.confirmPasswordChanged(
                    value,
                    newPasswordController.text,
                  ),
                ),
            validator: (_, context) => context
                .read<ForgotPasswordBloc>()
                .state
                .confirmPassword
                .value
                .fold(
                  (f) => f.maybeMap(
                    empty: (value) => StringConstant.pleaseEnterConfirmPassword,
                    shortPassword: (_) =>
                        StringConstant.passwordShouldBeMinimum8Digit,
                    passwordsDontMatch: (_) =>
                        StringConstant.bothPasswordsAreDoesNotMatch,
                    orElse: () => null,
                  ),
                  (_) => null,
                ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(14),
                vertical: getSize(14),
              ),
              child: SvgPicture.asset(
                SvgImageConstant.lock,
                height: getSize(24),
                width: getSize(24),
              ),
            ),
            obscureText: state.isConfirmPassObscure,
            suffixIcon: GestureDetector(
              onTap: () {
                context.read<ForgotPasswordBloc>().add(
                      const ForgotPasswordEvent.obscureText(2),
                    );
              },
              child: SvgPicture.asset(
                (state.isConfirmPassObscure)
                    ? SvgImageConstant.openEye
                    : SvgImageConstant.closeEye,
                height: getSize(24),
                width: getSize(24),
              ),
            ),
          ),
          SizedBox(
            height: getSize(50),
          ),
          CommonButton(
            isSubmitting: state.isSubmitting,
            onPressed: () {
              context.read<ForgotPasswordBloc>().add(
                    ForgotPasswordEvent.saveNewPassword(),
                  );
            },
            buttonText: StringConstant.save,
            borderRadius: 30,
            height: 50,
          ),
          SizedBox(
            height: getSize(isFullScreenDevice(context) ? 0 : 50),
          ),
        ],
      ),
    );
  }
}
