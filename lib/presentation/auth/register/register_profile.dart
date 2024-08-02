// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/register_form/register_form_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/auth/register/verify_mobile_number.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:badges/badges.dart' as badges;

@RoutePage(name: 'registerProfilePage')
// ignore: must_be_immutable
class RegisterProfileScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final int checkTermsPrivacy;
  RegisterProfileScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.checkTermsPrivacy,
  });
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getSize(65)),
        child: CommonAppBar(
          onBackPressed: () {
            RegisterFormBloc.locationCtrl.clear();

            context.router.maybePop();
          },
          title: (getCurrentRole() == 1)
              ? StringConstant.completeProfile
              : StringConstant.companyDetails,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: BlocProvider(
          create: (context) => getIt<RegisterFormBloc>(),
          child: BlocConsumer<RegisterFormBloc, RegisterFormState>(
            listener: (context, state) {
              state.authFailureOrSuccessOption.fold(
                () {},
                (either) => either.fold(
                  (failure) {
                    AppFocus.unfocus(context);
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
                    AppFocus.unfocus(context);

                    const VerifyPhoneNumber().getVerifyPhoneNoBottomSheet(
                      context,
                      (getCurrentRole() == 1)
                          ? "${state.selectedCountrycode} ${state.enteredPhoneNo}"
                          : state.email.getValue(),
                      state.password.getValue(),
                    );
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
                      children: [
                        profileImageSection(context, state),
                        if (getCurrentRole() == 2) ...[
                          paddingBetweenFields(),
                          companyNameTextField(context, state),
                        ],
                        paddingBetweenFields(),
                        phoneNumberTextField(context, state),
                        paddingBetweenFields(),
                        emailTextField(context, state),
                        paddingBetweenFields(),
                        passwordTextField(context, state),
                        paddingBetweenFields(),
                        confirmPasswordTextField(context, state),
                        if (getCurrentRole() == 2) ...[
                          paddingBetweenFields(),
                          associationTextField(context, state),
                          paddingBetweenFields(),
                          companyDescTextField(context, state),
                        ],
                        if (getCurrentRole() == 1) ...[
                          paddingBetweenFields(),
                          locationAddressTextField(context, state),
                          paddingBetweenFields(),
                          referralCodeTextField(context, state),
                        ],
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(50)),
                          child: CommonButton(
                            isSubmitting: state.isSubmitting,
                            onPressed: () {
                              context.read<RegisterFormBloc>().add(
                                      RegisterFormEvent
                                          .registerProfileBtnPressed(
                                    firstName: firstName,
                                    lastName: lastName,
                                    isCheckTerms: checkTermsPrivacy,
                                  ));
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
        SizedBox(
          height: getSize(130),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  ImageChooserDialog().showImageChooserDialog(
                    takePhotoCallback: () async {
                      String path = await ImagePickerUtils().pickImage(
                              imageSource: ImageSource.camera,
                              context: context) ??
                          '';
                      if (path.isNotEmpty) {
                        print("CAMERA IMAGE PATH: $path");
                        context.read<RegisterFormBloc>().add(
                              RegisterFormEvent.changeProfilePic(path),
                            );
                      }
                    },
                    selectPhotoCallback: () async {
                      String path = await ImagePickerUtils().pickImage(
                              imageSource: ImageSource.gallery,
                              context: context) ??
                          '';

                      if (path.isNotEmpty) {
                        print("GALLERY IMAGE PATH: $path");
                        context.read<RegisterFormBloc>().add(
                              RegisterFormEvent.changeProfilePic(path),
                            );
                      }
                    },
                    context: context,
                  );
                },
                child: Center(
                  child: badges.Badge(
                    position: badges.BadgePosition.bottomEnd(
                      bottom: getSize(2),
                      end: getSize(5),
                    ),
                    badgeContent: SvgPicture.asset(
                      SvgImageConstant.camera,
                      height: getSize(15),
                      width: getSize(15),
                    ),
                    badgeStyle: badges.BadgeStyle(
                        badgeColor: AppColors.white,
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 0.4)),
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
                                    image: CachedNetworkImageProvider(
                                        state.selectImage),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: FileImage(
                                      File(state.selectImage),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                            : DecorationImage(
                                image: AssetImage(
                                  (getCurrentRole() == 1)
                                      ? PngImageConstants.contractor_employer
                                      : PngImageConstants.contractor_employer,
                                ),
                              ),
                        border: Border.all(
                          color: AppColors.darkGreen,
                          width: getSize(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BaseText(
                text: (getCurrentRole() == 1)
                    ? StringConstant.profilePhoto
                    : StringConstant.companyLogo,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textColor: AppColors.black.withOpacity(0.7),
              ),
            ],
          ),
        ),
        // Positioned(
        //   top: getSize(75),
        //   left: getSize(210),
        //   child: GestureDetector(
        //     onTap: () {},
        //     child: Container(
        //       height: getSize(25),
        //       width: getSize(25),
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: AppColors.white,
        //         border: Border.all(
        //           color: AppColors.primaryColor,
        //           width: getSize(1),
        //         ),
        //         boxShadow: [
        //           BoxShadow(
        //             color: AppColors.black.withOpacity(0.2),
        //             blurRadius: 14,
        //           ),
        //         ],
        //       ),
        //       child: SvgPicture.asset(
        //         SvgImageConstant.camera,
        //         height: getSize(15),
        //         width: getSize(15),
        //       ),
        //     ),
        //   ),
        // )
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
                  empty: (value) => StringConstant.pleaseEnterCompanyName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget phoneNumberTextField(BuildContext context, RegisterFormState state) {
    return CustomTextField(
      labelText: StringConstant.phoneNumber,
      hintText: StringConstant.phoneNumber,
      keyboardType: TextInputType.phone,
      isLabelPadding: true,
      maxLength: 10,
      errorMaxLines: 2,
      onChanged: (value) => context.read<RegisterFormBloc>().add(
            RegisterFormEvent.phoneNumberChanged(value),
          ),
      validator: (_, context) =>
          context.read<RegisterFormBloc>().state.phoneNumber.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterMobileNumber,
                  invalidMobileNumber: (_) =>
                      StringConstant.phoneNumberShouldBeBetween10And15Digits,
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
          .read<RegisterFormBloc>()
          .add(RegisterFormEvent.emailChanged(value)),
      validator: (p0, p1) =>
          context.read<RegisterFormBloc>().state.email.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterEmail,
                  invalidEmail: (_) => StringConstant.pleaseEnterValidEmail,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget passwordTextField(BuildContext context, RegisterFormState state) {
    return CustomTextField(
      labelText: StringConstant.password,
      isLabelPadding: true,
      hintText: StringConstant.password,
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
              ? SvgImageConstant.closeEye
              : SvgImageConstant.openEye,
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
                  empty: (value) => StringConstant.pleaseEnterPassword,
                  shortPassword: (_) =>
                      StringConstant.passwordShouldBeMinimum8Digit,
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
              ? SvgImageConstant.closeEye
              : SvgImageConstant.openEye,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) => context
          .read<RegisterFormBloc>()
          .add(RegisterFormEvent.confirmPasswordChanged(
            value,
            state.enteredPassword,
          )),
      validator: (_, context) =>
          context.read<RegisterFormBloc>().state.confirmPassword.value.fold(
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

  // Widget locationAddressTextField(
  //     BuildContext context, RegisterFormState state) {
  //   return CustomTextField(
  //     labelText: StringConstant.locationAddress,
  //     isLabelPadding: true,
  //     hintText: StringConstant.locationAddress,
  //     prefixIcon: Padding(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: getSize(14),
  //         vertical: getSize(14),
  //       ),
  //       child: SvgPicture.asset(
  //         SvgImageConstant.locationIcon,
  //         height: getSize(24),
  //         width: getSize(24),
  //         color: AppColors.primaryColor,
  //       ),
  //     ),
  //     onChanged: (value) => context
  //         .read<RegisterFormBloc>()
  //         .add(RegisterFormEvent.locationAddressChanged(value)),
  //     validator: (p0, p1) =>
  //         context.read<RegisterFormBloc>().state.locationAddress.value.fold(
  //               (f) => f.maybeMap(
  //                 empty: (value) => StringConstant.pleaseEnterLocationName,
  //                 orElse: () => null,
  //               ),
  //               (_) => null,
  //             ),
  //   );
  // }

  Widget locationAddressTextField(
      BuildContext context, RegisterFormState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          labelText: StringConstant.locationAddress,
          isLabelPadding: true,
          hintText: StringConstant.locationAddress,
          // controller: TextEditingController()
          //   ..text = state.locationAddress.getValue() ?? "",
          controller: RegisterFormBloc.locationCtrl,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(14),
              vertical: getSize(14),
            ),
            child: SvgPicture.asset(
              SvgImageConstant.locationIcon,
              height: getSize(24),
              width: getSize(24),
              color: AppColors.primaryColor,
            ),
          ),
          onChanged: (value) => context
              .read<RegisterFormBloc>()
              .add(RegisterFormEvent.locationAddressChanged(value)),
          validator: (p0, p1) =>
              context.read<RegisterFormBloc>().state.locationAddress.value.fold(
                    (f) => f.maybeMap(
                      empty: (value) => StringConstant.pleaseEnterLocationName,
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
        ),
        if (state.searchLocationList.isNotEmpty)
          Container(
            height: getSize(200),
            color: AppColors.white,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.searchLocationList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    final selectedLocation =
                        state.searchLocationList[index]["description"];

                    context.read<RegisterFormBloc>().add(
                        RegisterFormEvent.locationSelectedFromSearchList(
                            selectedLocation));
                  },
                  dense: true,
                  titleAlignment: ListTileTitleAlignment.top,
                  leading: SvgPicture.asset(SvgImageConstant.locationIcon),
                  title: BaseText(
                    text: state.searchLocationList[index]["description"],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
