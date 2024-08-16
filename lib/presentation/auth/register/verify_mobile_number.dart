// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/register_form/register_form_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/inputs/custom_pin_field.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

// ignore: must_be_immutable
class VerifyPhoneNumber extends StatelessWidget {
  const VerifyPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }

  getVerifyPhoneNoBottomSheet(
    BuildContext context,
    String emailOrPhone,
    String password,
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
          create: (context) => getIt<RegisterFormBloc>()
            ..add(const RegisterFormEvent.startCountdown()),
          child: BlocConsumer<RegisterFormBloc, RegisterFormState>(
            listener: (context, state) {
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
                    AppFocus.unfocus(context);
                  },
                  (r) {
                    if (getCurrentRole() == 1) {
                      context.router
                          .push(PageRouteInfo(AddContractorSkillsForm.name));
                    } else {
                      context.router
                          .push(PageRouteInfo(LocationDetailForm.name));
                    }
                    context.router.maybePop();
                  },
                ),
              );
              state.resendFailureOrSuccessOption.fold(
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
                    showSuccess(message: r).show(context);
                    print("Success");
                  },
                ),
              );
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.fromLTRB(getSize(20), 0, getSize(20),
                    MediaQuery.of(context).viewInsets.bottom),
                child: SafeArea(
                  child: otpView(context, state, emailOrPhone, password),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget otpView(
    BuildContext context,
    RegisterFormState state,
    String emailOrPhone,
    String password,
  ) {
    return Form(
      autovalidateMode: state.showOtpErrorMessages
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(30),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: BaseText(
                  textAlign: TextAlign.center,
                  text: (getCurrentRole() == 1)
                      ? StringConstant.verifyYourPhoneNumber
                      : StringConstant.verifyYourEmail,
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
          SizedBox(
            height: getSize(10),
          ),
          Container(
            width: getSize(255),
            alignment: Alignment.center,
            child: BaseText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: (getCurrentRole() == 1)
                  ? StringConstant.verificationDesc
                  : StringConstant.emailVerificationDesc,
              lineHeight: 1,
              fontSize: getSize(14),
              textColor: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: getSize(10),
          ),
          Align(
            alignment: Alignment.center,
            child: BaseText(
              textAlign: TextAlign.center,
              text: (getCurrentRole() == 1) ? emailOrPhone : emailOrPhone,
              fontSize: getSize(12),
              textColor: AppColors.black.withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: getSize(30),
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
                    text:
                        'Remaining 00:${(state.secondsRemaining.toString().length == 2) ? state.secondsRemaining : "0${state.secondsRemaining}"}',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.black.withOpacity(0.6),
                  ),
                ],
              ),
              onChanged: (value) => context.read<RegisterFormBloc>().add(
                    RegisterFormEvent.changeOTP(value),
                  ),
              validator: (_, context) =>
                  context.read<RegisterFormBloc>().state.enteredOTP.value.fold(
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
            height: getSize(2),
          ),
          Opacity(
            opacity: state.secondsRemaining == 0 ? 1 : 0.5,
            child: CommonButton(
              onPressed: (state.secondsRemaining == 0)
                  ? () {
                      context
                          .read<RegisterFormBloc>()
                          .add(RegisterFormEvent.resendOtp());
                    }
                  : () {},
              buttonText: "",
              backgroundColor: AppColors.transparent,
              customWidget: BaseText(
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
                  .read<RegisterFormBloc>()
                  .add(RegisterFormEvent.verifyOtp(password));
            },
            buttonText: StringConstant.verify,
            borderRadius: 30,
            height: 50,
          ),
          SizedBox(
            height: getSize(isFullScreenDevice(context) ? 0 : 55),
          ),
        ],
      ),
    );
  }
}
