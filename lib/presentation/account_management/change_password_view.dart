// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/change_password/change_password_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ChangePasswordView")
class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: StringConstant.changePassword,
        ),
        body: BlocSelector<ChangePasswordBloc, ChangePasswordState, bool>(
          selector: (state) => state.postDataLoading,
          builder: (context, postDataLoading) {
            return Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      SvgPicture.asset(SvgImageConstant.changePassword,
                          height: 92),
                      Gap(getSize(14)),
                      BaseText(
                          text: "Update Password",
                          fontFamily: "Aclonica",
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: BaseText(
                          text:
                              "Securely change your password to keep your account safe.",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gap(getSize(35)),
                      _ChangePasswordForm()
                    ],
                  ),
                ),
                if (postDataLoading) CenterLoadingIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ChangePasswordForm extends StatefulWidget {
  const _ChangePasswordForm();

  @override
  State<_ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: OverflowBar(
        overflowSpacing: 16,
        children: [
          _PasswordInputField(
            hintText: "Current Password",
            labelText: "Current Password",
            validator: (value, context) {
              value = value?.trim() ?? '';

              if (value.isEmpty) {
                return StringConstant.pleaseEnterCurrentPassword;
              }
              return null;
            },
            controller: _currentPasswordController,
          ),
          _PasswordInputField(
            hintText: "New Password",
            labelText: "New Password",
            validator: (value, context) =>
                validateCurrentPass(value?.trim() ?? ""),
            controller: _newPasswordController,
          ),
          _PasswordInputField(
            hintText: "Confirm Password",
            labelText: "Confirm Password",
            validator: (value, context) =>
                validateConfirmPassword(value, _newPasswordController.text),
            controller: _confirmPasswordController,
          ),
          Gap(16),
          CommonButton(
            onPressed: () {
              if (_formKey.currentState?.validate() != true) return;
              context.read<ChangePasswordBloc>().add(
                    ChangePasswordEvent.changePassword(
                      oldPassword: _currentPasswordController.text.trim(),
                      password: _newPasswordController.text.trim(),
                      confirmPassword: _confirmPasswordController.text.trim(),
                      context: context,
                    ),
                  );
            },
            buttonText: "Update",
          )
        ],
      ),
    );
  }

  String? validateCurrentPass(String input) {
    if (input.isEmpty) {
      return StringConstant.pleaseEnterNewPassword;
    } else if (input.trim() == _currentPasswordController.text.trim()) {
      return StringConstant.pleaseTryDifferentPasswordThenCurrent;
    } else {
      if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).+$')
          .hasMatch(input)) {
        return StringConstant.invalidPasswordErrorText;
      } else if (input.length < 8) {
        return StringConstant.passwordShouldBeMinimum8Digit;
      } else {
        return null;
      }
    }
  }

  String? validateConfirmPassword(String? value, String password) {
    value = value?.trim() ?? '';
    if (value.isEmpty) return StringConstant.pleaseEnterConfirmPassword;
    if (password != value.trim()) {
      return StringConstant.bothPasswordsAreDoesNotMatch;
    }
    return null;
  }
}

class _PasswordInputField extends StatefulWidget {
  const _PasswordInputField({
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.controller,
  });

  final String labelText;
  final String hintText;
  final String? Function(String? value, BuildContext context)? validator;

  final TextEditingController controller;

  @override
  State<_PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<_PasswordInputField> {
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isPasswordVisible,
      builder: (context, value, _) => CustomTextField(
        autoValidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        hintText: widget.hintText,
        labelText: widget.labelText,
        validator: widget.validator,
        maxLength: 16,
        errorMaxLines: 3,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(14), vertical: getSize(14)),
          child: SvgPicture.asset(
            SvgImageConstant.lock,
            height: getSize(24),
            width: getSize(24),
            color: AppColors.primaryColor,
          ),
        ),
        obscureText: _isPasswordVisible.value,
        suffixIcon: GestureDetector(
          onTap: () => _isPasswordVisible.value = !_isPasswordVisible.value,
          child: Container(
            color: AppColors.transparent,
            padding: EdgeInsets.all(getSize(9)),
            child: SvgPicture.asset(
              (_isPasswordVisible.value)
                  ? SvgImageConstant.closeEye
                  : SvgImageConstant.openEye,
              height: getSize(24),
              width: getSize(24),
            ),
          ),
        ),
      ),
    );
  }
}

String? _validatePassword(String? input) {
  if (input == null || input.isEmpty) {
    return StringConstant.pleaseEnterPassword;
  } else {
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).+$')
        .hasMatch(input)) {
      return StringConstant.pleaseEnterCorrectPasswordFormat;
    } else if (input.length < 8) {
      return StringConstant.passwordShouldBeMinimum8Digit;
    } else {
      return null;
    }
  }
}
