// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/auth/register_form/register_form_bloc.dart';
import 'package:shift/application/splash/splash_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/inputs/custom_pin_field.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_country_code_removing_formatter.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

// ignore: must_be_immutable
class VerifyPhoneNumber extends StatelessWidget {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }

  String emailOrPhoneValue = "";
  String countryCodeValue = "";
  String countryFlagValue = "";

  getVerifyPhoneNoBottomSheet(
    BuildContext context,
    String emailOrPhone,
    String countryCode,
    String countryFlag,
    String password,
  ) {
    print("Phone number--- $emailOrPhone");
    emailOrPhoneValue = emailOrPhone;
    countryCodeValue = countryCode;
    countryFlagValue = countryFlag;
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
                    codeController.clear();
                    AppFocus.unfocus(context);
                  },
                  (r) {
                    context
                        .read<SplashBloc>()
                        .add(SplashEvent.initDynamicLink(context));

                    if (getCurrentRole() == 1) {
                      /*context.router.replace(PageRouteInfo(
                          AddContractorSkillsForm.name,
                          args:
                              AddContractorSkillsFormArgs(isFromSplash: true)));*/
                      context.router.pushAndPopUntil(
                        PageRouteInfo(
                          AddContractorSkillsForm.name,
                          args: AddContractorSkillsFormArgs(isFromSplash: true),
                        ),
                        predicate: (route) => false,
                      );
                    } else {
                      /*context.router.replace(PageRouteInfo(
                          LocationDetailForm.name,
                          args: LocationDetailFormArgs(isFromSplash: true)));*/
                      context.router.pushAndPopUntil(
                        PageRouteInfo(
                          LocationDetailForm.name,
                          args: LocationDetailFormArgs(isFromSplash: true),
                        ),
                        predicate: (route) => false,
                      );
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
                  child: otpView(context, state, password),
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
          SizedBox(height: getSize(10)),
          Container(
            width: getSize(255),
            alignment: Alignment.center,
            child: BaseText(
              textAlign: TextAlign.center,
              maxLines: 3,
              text: (getCurrentRole() == 1)
                  ? StringConstant.verificationDesc
                  : StringConstant.emailVerificationDesc,
              lineHeight: 1,
              fontSize: getSize(14),
              textColor: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseText(
                textAlign: TextAlign.center,
                text: (getCurrentRole() == 1)
                    ? "$countryCodeValue $emailOrPhoneValue"
                    : emailOrPhoneValue,
                fontSize: getSize(12),
                textColor: AppColors.black.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
              GestureDetector(
                onTap: () {
                  if (getCurrentRole() == 1) {
                    editPhone(context, context.read<RegisterFormBloc>(), state,
                        emailOrPhoneValue);
                  } else {
                    editEmail(context, context.read<RegisterFormBloc>(), state,
                        emailOrPhoneValue);
                  }
                },
                child: Container(
                  color: AppColors.transparent,
                  padding: EdgeInsets.all(getSize(10)),
                  child: Container(
                    padding: EdgeInsets.all(getSize(5)),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      SvgImageConstant.edit,
                      color: AppColors.primaryColor,
                      height: getSize(15),
                      width: getSize(15),
                    ),
                  ),
                ),
              ),
            ],
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
              controller: codeController,
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
              width: 150,
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

  editEmail(BuildContext context, RegisterFormBloc bloc,
      RegisterFormState state, String initialValue) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (__) {
          return BlocBuilder<RegisterFormBloc, RegisterFormState>(
            bloc: bloc..add(RegisterFormEvent.editedEmailEvent(initialValue)),
            builder: (context, state) {
              return AlertDialog(
                  elevation: 80,
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  title: BaseText(
                    text: StringConstant.editEmail,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Aclonica",
                    textAlign: TextAlign.center,
                  ),
                  clipBehavior: Clip.none,
                  content: Form(
                    autovalidateMode: state.showEditedErrorMessage
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(
                          text: StringConstant
                              .pleaseEditYourEmailToGetVerificationCode,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                          textColor: AppColors.black.withOpacity(0.7),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(20)),
                          child: CustomTextField(
                            labelText: StringConstant.email,
                            initialValue: initialValue,
                            onChanged: (value) {
                              bloc.add(
                                  RegisterFormEvent.editedEmailEvent(value));
                            },
                            validator: (p0, p1) =>
                                bloc.state.editedEmail.value.fold(
                              (f) => f.maybeMap(
                                empty: (value) =>
                                    StringConstant.pleaseEnterEmail,
                                invalidEmail: (_) =>
                                    StringConstant.pleaseEnterValidEmail,
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                            fillColor: AppColors.grey04,
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
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonButton(
                              onPressed: () {
                                context.router.maybePop();
                                AppFocus.unfocus(context);
                              },
                              width: 150,
                              buttonText: StringConstant.cancle,
                              backgroundColor: AppColors.white,
                              buttonTextColor: AppColors.primaryColor,
                              borderColor: AppColors.primaryColor,
                            ),
                            CommonButton(
                              isSubmitting: state.isEditing,
                              onPressed: () {
                                bloc.add(RegisterFormEvent.editEmailOrPhone(
                                    context));
                                AppFocus.unfocus(context);
                              },
                              width: 150,
                              buttonText: StringConstant.resendCode,
                            )
                          ],
                        ),
                      ],
                    ),
                  ));
            },
          );
        }).then((value) {
      if (value != null && value == true) {
        emailOrPhoneValue = getCurrentUser().email ?? '';
        bloc.add(RegisterFormEvent.startCountdown());
      }
    });
  }

  editPhone(BuildContext context, RegisterFormBloc bloc,
      RegisterFormState state, String initialValue) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (__) {
          return BlocBuilder<RegisterFormBloc, RegisterFormState>(
            bloc: bloc
              ..add(RegisterFormEvent.editedPhoneEvent(initialValue,
                  countryCode: countryCodeValue,
                  countryFlag: countryFlagValue)),
            builder: (context, state) {
              return AlertDialog(
                  elevation: 80,
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  title: BaseText(
                    text: StringConstant.editPhoneNumber,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Aclonica",
                    textAlign: TextAlign.center,
                  ),
                  clipBehavior: Clip.none,
                  content: Form(
                    autovalidateMode: state.showEditedErrorMessage
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(
                          text: StringConstant
                              .pleaseEditYourPhoneNnumberToGetVerificationCode,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                          textColor: AppColors.black.withOpacity(0.7),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(20)),
                          child: CustomTextField(
                            labelText: StringConstant.phoneNumber,
                            hintText: StringConstant.phoneNumber,
                            initialValue: initialValue,
                            keyboardType: TextInputType.phone,
                            isLabelPadding: true,
                            maxLength: 10,
                            errorMaxLines: 2,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CountryCodeRemovingFormatter(),
                            ],
                            onChanged: (value) {
                              print("Filter Phone number --> $value");
                              bloc.add(
                                RegisterFormEvent.editedPhoneEvent(value),
                              );
                            },
                            validator: (_, context) => context
                                .read<RegisterFormBloc>()
                                .state
                                .editedPhone
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
                              initialSelection: state.editedCountryFlag,
                              onChanged: (countryCode) {
                                print(countryCode.flagEmoji);
                                bloc.add(
                                  RegisterFormEvent.selectEditedCountryCode(
                                    countryCode.phoneCode,
                                    countryCode.flagEmoji,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonButton(
                              onPressed: () {
                                context.router.maybePop();
                                AppFocus.unfocus(context);
                              },
                              width: 150,
                              buttonText: StringConstant.cancle,
                              backgroundColor: AppColors.white,
                              buttonTextColor: AppColors.primaryColor,
                              borderColor: AppColors.primaryColor,
                            ),
                            CommonButton(
                              isSubmitting: state.isEditing,
                              onPressed: () {
                                bloc.add(RegisterFormEvent.editEmailOrPhone(
                                    context));
                                AppFocus.unfocus(context);
                              },
                              width: 150,
                              buttonText: StringConstant.resendCode,
                            )
                          ],
                        ),
                      ],
                    ),
                  ));
            },
          );
        }).then((value) {
      if (value != null && value == true) {
        emailOrPhoneValue = "${getCurrentUser().phone ?? ''}";
        countryCodeValue = getCurrentUser().countryCode ?? '';
        countryFlagValue = getCurrentUser().countryNameCode ?? '';

        bloc.add(RegisterFormEvent.startCountdown());
      }
    });
  }
}
