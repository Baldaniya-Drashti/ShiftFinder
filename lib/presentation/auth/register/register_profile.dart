// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/register_form/register_form_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/auth/register/verify_mobile_number.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'registerProfilePage')
// ignore: must_be_immutable
class RegisterProfileScreen extends StatelessWidget {
  RegisterProfileScreen({super.key});
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.back();
        },
        title: StringConstant.companyDetails,
      ),
      body: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: BlocProvider(
          create: (context) => RegisterFormBloc(),
          child: BlocConsumer<RegisterFormBloc, RegisterFormState>(
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
                    const VerifyPhoneNumber().getVerifyPhoneNoBottomSheet(
                        context,
                        "${state.selectedCountrycode}  ${phoneNoController.text}");
                  },
                ),
              );
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                child: Form(
                  autovalidateMode: (state.showErrorMessages)
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      // shrinkWrap: true,
                      // physics: const BouncingScrollPhysics(),
                      // padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                      children: [
                        profileImageSection(context, state),
                        paddingBetweenFields(),
                        companyNameTextField(context, state),
                        paddingBetweenFields(),
                        phoneNumberTextField(context, state),
                        paddingBetweenFields(),
                        emailTextField(context, state),
                        paddingBetweenFields(),
                        passwordTextField(context, state),
                        paddingBetweenFields(),
                        confirmPasswordTextField(context, state),
                        paddingBetweenFields(),
                        associationTextField(context, state),
                        paddingBetweenFields(),
                        referralCodeTextField(context, state),
                        paddingBetweenFields(),
                        companyDescTextField(context, state),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(50)),
                          child: CommonButton(
                            onPressed: () {
                              context.read<RegisterFormBloc>().add(
                                  const RegisterFormEvent
                                      .registerProfileBtnPressed());
                            },
                            buttonText: StringConstant.register,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget profileImageSection(BuildContext context, RegisterFormState state) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: getSize(100),
                width: getSize(100),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  image: state.selectImage.isNotEmpty
                      ? state.selectImage.contains('https')
                          ? DecorationImage(
                              image:
                                  CachedNetworkImageProvider(state.selectImage),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: FileImage(
                                File(state.selectImage),
                              ),
                              fit: BoxFit.cover,
                            )
                      : null,
                  border: Border.all(
                    color: AppColors.darkGreen,
                    width: getSize(2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getSize(10),
            ),
            BaseText(
              text: StringConstant.companyLogo,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black.withOpacity(0.7),
            ),
          ],
        ),
        Positioned(
          top: getSize(75),
          left: getSize(215),
          child: GestureDetector(
            onTap: () {
              ImageChooserDialog().showImageChooserDialog(
                takePhotoCallback: () async {
                  String path = await ImagePickerUtils().pickImage(
                          imageSource: ImageSource.camera, context: context) ??
                      '';
                  if (path.isNotEmpty) {
                    print("CAMERA IMAGE PATH: $path");
                    context.read<RegisterFormBloc>().add(
                          RegisterFormEvent.changeProfilePicture(path),
                        );
                  }
                  context.router.maybePop();
                },
                selectPhotoCallback: () async {
                  String path = await ImagePickerUtils().pickImage(
                          imageSource: ImageSource.gallery, context: context) ??
                      '';

                  if (path.isNotEmpty) {
                    print("GALLERY IMAGE PATH: $path");
                    context.read<RegisterFormBloc>().add(
                          RegisterFormEvent.changeProfilePicture(path),
                        );
                  }
                  context.router.maybePop();
                },
                context: context,
              );
            },
            child: Container(
              height: getSize(25),
              width: getSize(25),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: getSize(1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    blurRadius: 14,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                SvgImageConstant.camera,
                height: getSize(15),
                width: getSize(15),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget paddingBetweenFields() {
    return SizedBox(
      height: getSize(15),
    );
  }

  Widget companyNameTextField(BuildContext context, RegisterFormState state) {
    return CustomTextField(
      labelText: StringConstant.companyName,
      isLabelPadding: true,
      hintText: StringConstant.companyName,
      textCapitalization: TextCapitalization.words,
      errorMaxLines: 2,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.building,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) => context
          .read<RegisterFormBloc>()
          .add(RegisterFormEvent.companyNameChanged(value)),
      validator: (p0, p1) =>
          context.read<RegisterFormBloc>().state.companyName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => "Please enter company name",
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget phoneNumberTextField(BuildContext context, RegisterFormState state) {
    return CustomTextField(
      controller: phoneNoController,
      labelText: StringConstant.phoneNumber,
      hintText: StringConstant.phoneNumber,
      keyboardType: TextInputType.phone,
      isLabelPadding: true,
      errorMaxLines: 2,
      onChanged: (value) => context.read<RegisterFormBloc>().add(
            RegisterFormEvent.phoneNumberChanged(value),
          ),
      validator: (_, context) =>
          context.read<RegisterFormBloc>().state.phoneNumber.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => 'Please enter mobile number',
                  invalidMobileNumber: (_) =>
                      'Phone number should be between 10 and 15 digits',
                  orElse: () => null,
                ),
                (_) => null,
              ),
      prefixIcon: CommonCountryCodePicker(
        initialSelection: state.selectedCountryFlag,
        onChanged: (countryCode) {
          print(countryCode.flagEmoji);
          context.read<RegisterFormBloc>().add(
                RegisterFormEvent.selectCountryCode(
                  countryCode.phoneCode,
                  countryCode.flagEmoji,
                ),
              );
        },
      ),
    );
  }

  Widget emailTextField(BuildContext context, RegisterFormState state) {
    return CustomTextField(
      labelText: StringConstant.email,
      isLabelPadding: true,
      hintText: StringConstant.email,
      textCapitalization: TextCapitalization.words,
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
          .read<RegisterFormBloc>()
          .add(RegisterFormEvent.emailChanged(value)),
      validator: (p0, p1) =>
          context.read<RegisterFormBloc>().state.email.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => 'Please enter email',
                  invalidEmail: (_) => 'Please enter valid email',
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget passwordTextField(BuildContext context, RegisterFormState state) {
    return CustomTextField(
      controller: passwordController,
      labelText: StringConstant.password,
      isLabelPadding: true,
      hintText: StringConstant.password,
      textCapitalization: TextCapitalization.words,
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
      obscureText: state.isNewPassObscure,
      suffixIcon: GestureDetector(
        onTap: () {
          context.read<RegisterFormBloc>().add(
                const RegisterFormEvent.obscureText(1),
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
      onChanged: (value) => context
          .read<RegisterFormBloc>()
          .add(RegisterFormEvent.passwordChanged(value)),
      validator: (p0, p1) =>
          context.read<RegisterFormBloc>().state.password.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => 'Please enter confirm password',
                  shortPassword: (_) => 'Password should be minimum 10 digit',
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget confirmPasswordTextField(
      BuildContext context, RegisterFormState state) {
    return CustomTextField(
      labelText: StringConstant.confirmPassword,
      isLabelPadding: true,
      hintText: StringConstant.confirmPassword,
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
      obscureText: state.isConfirmPassObscure,
      suffixIcon: GestureDetector(
        onTap: () {
          context.read<RegisterFormBloc>().add(
                const RegisterFormEvent.obscureText(2),
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
      onChanged: (value) => context
          .read<RegisterFormBloc>()
          .add(RegisterFormEvent.confirmPasswordChanged(
            value,
            passwordController.text,
          )),
      validator: (_, context) => context
          .read<RegisterFormBloc>()
          .state
          .confirmPassword
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => 'Please enter confirm password',
              shortPassword: (_) =>
                  'Confirm password should be minimum 10 digit',
              passwordsDontMatch: (_) => 'Both Passwords are does not match.',
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }

  Widget associationTextField(BuildContext context, RegisterFormState state) {
    return CustomTextField(
      labelText: StringConstant.associationYouBelongTo,
      isLabelPadding: true,
      isOptional: true,
      hintText: StringConstant.association,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.association,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) => context
          .read<RegisterFormBloc>()
          .add(RegisterFormEvent.associationTextChanged(value)),
    );
  }

  Widget referralCodeTextField(BuildContext context, RegisterFormState state) {
    return CustomTextField(
      labelText: StringConstant.referralCode,
      isLabelPadding: true,
      isOptional: true,
      hintText: StringConstant.referralCode,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.referral,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) => context
          .read<RegisterFormBloc>()
          .add(RegisterFormEvent.referralCodeChanged(value)),
    );
  }

  Widget companyDescTextField(BuildContext context, RegisterFormState state) {
    return CustomTextField(
      labelText: StringConstant.companyDescription,
      hintText: StringConstant.typeHere,
      isLabelPadding: true,
      isOptional: true,
      maxLines: 4,
      keyboardType: TextInputType.multiline,
      onChanged: (value) => context
          .read<RegisterFormBloc>()
          .add(RegisterFormEvent.companyDescChanged(value)),
    );
  }
}
