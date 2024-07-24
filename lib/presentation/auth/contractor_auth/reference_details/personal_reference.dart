// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class PersonalReferenceWidget extends StatelessWidget {
  const PersonalReferenceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferenceBloc, ReferenceState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              autovalidateMode: (state.showPersonalErrorMessage)
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      contactPersonTextField(context, state),
                      paddingBetweenFields(),
                      emailTextField(context, state),
                      paddingBetweenFields(),
                      phoneNumberTextField(context, state),
                      paddingBetweenFields(),
                      professionReferrerTextField(context, state),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: getSize(40)),
              child: CommonButton(
                onPressed: () {
                  context
                      .read<ReferenceBloc>()
                      .add(const ReferenceEvent.personalBtnPressed());
                },
                buttonText: StringConstant.txtContinue,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget contactPersonTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.contactPerson,
      isLabelPadding: true,
      hintText: StringConstant.contactPerson,
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
      validator: (p0, p1) =>
          context.read<ReferenceBloc>().state.contactPerson.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddContactPerson,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.contactPersonChanged(value));
      },
    );
  }

  Widget emailTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.e_mail,
      isLabelPadding: true,
      hintText: StringConstant.e_mail,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.email,
          color: AppColors.primaryColor,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (p0, p1) =>
          context.read<ReferenceBloc>().state.personalEmail.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterEmail,
                  invalidEmail: (_) => StringConstant.pleaseEnterValidEmail,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.personalEmailChanged(value));
      },
    );
  }

  Widget professionReferrerTextField(
      BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.professionOfTheReferrer,
      isLabelPadding: true,
      hintText: StringConstant.professionOfTheReferrer,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.bag,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (p0, p1) => context
          .read<ReferenceBloc>()
          .state
          .profession
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseAddProfessionOfTheReferrer,
              orElse: () => null,
            ),
            (_) => null,
          ),
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.professionChanged(value));
      },
    );
  }

  Widget phoneNumberTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.phoneNumber,
      hintText: StringConstant.phoneNumber,
      keyboardType: TextInputType.phone,
      isLabelPadding: true,
      errorMaxLines: 2,
      maxLength: 10,
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.personalPhoneNoChanged(value));
      },
      validator: (_, context) =>
          context.read<ReferenceBloc>().state.personalPhoneNo.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterMobileNumber,
                  invalidMobileNumber: (_) =>
                      StringConstant.phoneNumberShouldBeBetween10And15Digits,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      prefixIcon: CommonCountryCodePicker(
        initialSelection: state.personalCountryFlag,
        onChanged: (countryCode) {
          context.read<ReferenceBloc>().add(
                ReferenceEvent.personalCountryCode(
                  countryCode.phoneCode,
                  countryCode.flagEmoji,
                ),
              );
        },
      ),
    );
  }
}
