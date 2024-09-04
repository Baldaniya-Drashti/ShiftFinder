// ignore_for_file: use_build_context_synchronously, deprecated_member_use, avoid_print, unnecessary_brace_in_string_interps, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_country_code_removing_formatter.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class ProfessionalReferenceWidget extends StatelessWidget {
  ReferenceDTO? referenceObj;

  ProfessionalReferenceWidget({super.key, this.referenceObj});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferenceBloc, ReferenceState>(
      builder: (context, state) {
        return (state.isLoading)
            ? CenterLoadingIndicator(isOnlyLoader: true)
            : Form(
                autovalidateMode: (state.showProfessionalErrorMessage)
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      jobPositionTextField(context, state),
                      paddingBetweenFields(),
                      organizationTextField(context, state),
                      paddingBetweenFields(),
                      referrerTextField(context, state),
                      paddingBetweenFields(),
                      referrerEmailTextField(context, state),
                      paddingBetweenFields(),
                      referrerPhoneNumberTextField(context, state),
                      paddingBetweenFields(),
                      jobLocationFacilityTextField(context, state),
                      paddingBetweenFields(),
                      unitDepartmentTextField(context, state),
                      paddingBetweenFields(),
                      startDateTextField(context, state),
                      paddingBetweenFields(),
                      endDateTextField(context, state),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: getSize(40)),
                        child: CommonButton(
                          isSubmitting: state.isProfessionalSubmitting,
                          onPressed: () {
                            context
                                .read<ReferenceBloc>()
                                .add(ReferenceEvent.professinalBtnPressed(
                                  referenceObj != null,
                                  id: referenceObj?.id,
                                ));
                          },
                          buttonText: (referenceObj != null)
                              ? StringConstant.update
                              : StringConstant.txtContinue,
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget jobPositionTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.jobPosition,
      isLabelPadding: true,
      hintText: StringConstant.jobPosition,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      initialValue: state.jobPosition.getValue(),
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
      validator: (p0, p1) =>
          context.read<ReferenceBloc>().state.jobPosition.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddJobPosition,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.jobPositionChanged(value));
      },
    );
  }

  Widget organizationTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.organization,
      isLabelPadding: true,
      hintText: StringConstant.organization,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      initialValue: state.organization.getValue(),
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.personPlus,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (p0, p1) =>
          context.read<ReferenceBloc>().state.organization.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddOrganization,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.organizationChanged(value));
      },
    );
  }

  Widget referrerTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.referrer,
      isLabelPadding: true,
      hintText: StringConstant.referrer,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      initialValue: state.referrer.getValue(),
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
          context.read<ReferenceBloc>().state.referrer.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddReferrer,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.referrerChanged(value));
      },
    );
  }

  Widget referrerEmailTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.referrerEmail,
      isLabelPadding: true,
      hintText: StringConstant.referrerEmail,
      keyboardType: TextInputType.emailAddress,
      maxLength: 340,
      initialValue: state.referrerEmail.getValue(),
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
          context.read<ReferenceBloc>().state.referrerEmail.value.fold(
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
            .add(ReferenceEvent.referrerEmailChanged(value));
      },
    );
  }

  Widget jobLocationFacilityTextField(
      BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.jobLocationFacility,
      isLabelPadding: true,
      hintText: StringConstant.jobLocationFacility,
      initialValue: state.jobLocation.getValue(),
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.locationIcon,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (p0, p1) =>
          context.read<ReferenceBloc>().state.jobLocation.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddJobLocationFacility,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.jobLocationChanged(value));
      },
    );
  }

  Widget unitDepartmentTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.unitDepartment,
      isLabelPadding: true,
      hintText: StringConstant.unitDepartment,
      initialValue: state.unitDepartment.getValue(),
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.departmentSetting,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (p0, p1) =>
          context.read<ReferenceBloc>().state.unitDepartment.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddUnitDepartment,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.unitDepartmentChanged(value));
      },
    );
  }

  Widget startDateTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.startDate,
      isLabelPadding: true,
      readOnly: true,
      hintText: (state.startDate.getValue()!.isNotEmpty)
          ? DateFormat('d MMM, yyyy')
              .format(DateTime.parse(state.startDate.getValue() ?? ""))
          : StringConstant.startDate,
      hintAsValue: (state.startDate.getValue()!.isNotEmpty) ? true : false,
      onTap: () {
        customDatePicker(
          context,
          state,
          isStartDate: true,
          selectedDate: (state.startDate.getValue()!.isNotEmpty)
              ? DateTime.parse(state.startDate.getValue()!)
              : DateTime.now(),
        );
      },
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.calendar,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (p0, p1) =>
          context.read<ReferenceBloc>().state.startDate.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectStartDate,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget endDateTextField(BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.endDate,
      isLabelPadding: true,
      readOnly: true,
      hintText: (state.endDate.getValue()!.isNotEmpty)
          ? DateFormat('d MMM, yyyy')
              .format(DateTime.parse(state.endDate.getValue() ?? ""))
          : StringConstant.endDate,
      hintAsValue: (state.endDate.getValue()!.isNotEmpty) ? true : false,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.calendar,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onTap: () {
        print("Date Time satrt---->  ${state.startDate}");
        customDatePicker(
          context,
          state,
          startDate:
              (state.startDate.getValue() != null && state.startDate.isValid())
                  ? DateTime.parse(state.startDate.getValue()!)
                  : null,
          isStartDate: false,
          selectedDate: (state.endDate.getValue()!.isNotEmpty)
              ? DateTime.parse(state.endDate.getValue()!)
              : DateTime.now(),
        );
      },
      validator: (p0, p1) =>
          context.read<ReferenceBloc>().state.endDate.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectEndDate,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      // onChanged: (value) {
      //   context.read<ReferenceBloc>().add(ReferenceEvent.endDateChanged(value));
      // },
    );
  }

  Widget referrerPhoneNumberTextField(
      BuildContext context, ReferenceState state) {
    return CustomTextField(
      labelText: StringConstant.referrerPhoneNumber,
      hintText: StringConstant.referrerPhoneNumber,
      keyboardType: TextInputType.phone,
      initialValue: state.referrerPhoneNo.getValue(),
      isLabelPadding: true,
      maxLength: 10,
      errorMaxLines: 2,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CountryCodeRemovingFormatter(),
      ],
      onChanged: (value) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.referrerPhoneNoChanged(value));
      },
      validator: (_, context) =>
          context.read<ReferenceBloc>().state.referrerPhoneNo.value.fold(
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
          context.read<ReferenceBloc>().add(
                ReferenceEvent.selectCountryCode(
                  countryCode.phoneCode,
                  countryCode.flagEmoji,
                ),
              );
        },
      ),
    );
  }

  Future<void> customDatePicker(
    BuildContext context,
    ReferenceState state, {
    required DateTime? selectedDate,
    DateTime? startDate,
    required bool isStartDate,
  }) async {
    print("selectedDate------->  ${selectedDate}");

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: startDate ?? DateTime(1950, 1),
      lastDate: DateTime.now(),
      initialDate: selectedDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      if (isStartDate) {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.startDateChanged(pickedDate.toString()));
      } else {
        context
            .read<ReferenceBloc>()
            .add(ReferenceEvent.endDateChanged(pickedDate.toString()));
      }
    }
    // await showDialog(
    //   context: context,
    //   builder: (_) {
    //     return Theme(
    //       data: Theme.of(context).copyWith(
    //         colorScheme: ColorScheme.light(
    //           primary: AppColors.primaryColor, // header background color
    //           onPrimary: AppColors.black, // header text color
    //           onSurface: AppColors.black,
    //         ),
    //       ),
    //       child: AlertDialog(
    //         title: const BaseText(
    //           text: "Select Year",
    //           textAlign: TextAlign.center,
    //         ),
    //         content: SizedBox(
    //           width: getSize(500),
    //           height: getSize(400),
    //           child: YearPicker(
    //             firstDate: DateTime(1950, 1),
    //             lastDate: DateTime.now(),
    //             selectedDate: selectedDate,
    //             onChanged: onChanged,
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // ).then((value) {
    //   if (value != null && value is DateTime) {
    //     print("onback value---> ${value}");
    //     if (isStartDate) {
    //       context
    //           .read<ReferenceBloc>()
    //           .add(ReferenceEvent.startDateChanged(value.toString()));
    //     } else {
    //       context
    //           .read<ReferenceBloc>()
    //           .add(ReferenceEvent.endDateChanged(value.toString()));
    //     }
    //   }
    // });
  }
}
