// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/auth/contractor_auth/bank_details_bloc/bank_details_bloc.dart';
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/auth/contractor/bank/bank_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/location_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_country_code_removing_formatter.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addBankDetailsScreen')
class AddBankDetailsScreen extends StatelessWidget {
  BankDTO? bankDetail;
  bool isFromSplash = false;
  bool isUpdate;

  AddBankDetailsScreen(
      {super.key,
      this.isFromSplash = false,
      this.bankDetail,
      this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unfocus(context);
      },
      child: BlocProvider(
        create: (context) => getIt<BankDetailsBloc>()
          ..add(BankDetailsEvent.getCurrentBank(context,
              currentBank: bankDetail, isUpdate: isUpdate)),
        child: BlocConsumer<BankDetailsBloc, BankDetailsState>(
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
                  if (isUpdate) {
                    context.router.maybePop(true);
                  } else {
                    context.router.push(
                        const PageRouteInfo(LegalScreeningQuestionsPage.name));
                  }
                },
              ),
            );
          },
          builder: (context, state) {
            return Scaffold(
              appBar: CommonAppBar(
                isShowBackBtn: !isFromSplash,
                onBackPressed: () {
                  context.router.maybePop();
                },
                title: (isUpdate)
                    ? StringConstant.editBankDetails
                    : StringConstant.addBankDetails,
              ),
              body: (state.isLoading)
                  ? CenterLoadingIndicator()
                  : Form(
                      autovalidateMode: (state.showErrorMessages)
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getSize(20),
                          ),
                          child: Column(
                            children: [
                              bankNameDropdown(context, state),
                              paddingBetweenFields(),
                              jobTitleField(context, state),
                              paddingBetweenFields(),
                              accountNumberField(context, state),
                              paddingBetweenFields(),
                              transitNumberField(context, state),
                              paddingBetweenFields(),
                              bankInstitutionNumberField(context, state),
                              paddingBetweenFields(),
                              accountTypeDropdown(context, state),
                              paddingBetweenFields(),
                              firstNameField(context, state),
                              paddingBetweenFields(),
                              lastNameField(context, state),
                              paddingBetweenFields(),
                              phoneNumberTextField(context, state),
                              paddingBetweenFields(),
                              dobField(context, state),
                              paddingBetweenFields(),
                              bankAddressField(context, state),
                              paddingBetweenFields(),
                              cityField(context, state),
                              paddingBetweenFields(),
                              stateField(context, state),
                              paddingBetweenFields(),
                              postalCodeField(context, state),
                              paddingBetweenFields(height: getSize(30)),
                              termsCheckBox(state, context),
                              paddingBetweenFields(height: getSize(10)),
                              if (state.showErrorMessages && !state.isCheck)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getSize(20),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: BaseText(
                                      text: StringConstant.bankTermsErrorText,
                                      style: TextStyle(
                                        color: AppColors.red,
                                        fontSize: getFontSize(11),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: getSize(40),
                                  bottom: getSize(20),
                                ),
                                child: CommonButton(
                                  isSubmitting: state.isSubmitting,
                                  onPressed: () {
                                    context.read<BankDetailsBloc>().add(
                                        BankDetailsEvent.submitBtnPressed(
                                            context));
                                  },
                                  buttonText: StringConstant.txtContinue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget bankNameDropdown(BuildContext context, BankDetailsState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.bankName,
      hintText: StringConstant.bankName,
      isLabelPadding: true,
      showTextfield: false,
      items: BankDetailsBloc.bankNameList.map((val) {
        return DropdownMenuItem<String>(
          value: val.name,
          child: BaseText(
            text: val.name ?? "",
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      validator: (p0) =>
          context.read<BankDetailsBloc>().state.bankName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectBankName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      value: (state.bankName.isValid()) ? state.bankName.getValue() : null,
      onChanged: (value) {
        if (value != null) {
          context
              .read<BankDetailsBloc>()
              .add(BankDetailsEvent.bankNameChanged(value));
        }
      },
    );
  }

  Widget jobTitleField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.jobTitle,
      hintText: StringConstant.jobTitle,
      initialValue: state.jobTitle.getValue(),
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.jobTitleChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.jobTitle.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddJobTitle,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget accountNumberField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.accountNumber,
      hintText: StringConstant.accountNumber,
      initialValue: state.accountNumber.getValue(),
      textCapitalization: TextCapitalization.characters,
      keyboardType: TextInputType.number,
      maxLength: 15,
      inputFormatters: [
        // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.accountNumberChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.accountNumber.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddAccountNumber,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget accountTypeDropdown(BuildContext context, BankDetailsState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.accountType,
      hintText: StringConstant.accountType,
      fieldInitialValue:
          (state.accountType.isValid()) ? state.accountType.getValue() : null,
      isLabelPadding: true,
      showTextfield: false,
      items: CommonList.accountTypeList.map((val) {
        return DropdownMenuItem<String>(
          value: val.name,
          child: BaseText(
            text: val.name ?? "",
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      validator: (p0) =>
          context.read<BankDetailsBloc>().state.accountType.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectAccountType,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      value:
          (state.accountType.isValid()) ? state.accountType.getValue() : null,
      onChanged: (value) {
        if (value != null) {
          context
              .read<BankDetailsBloc>()
              .add(BankDetailsEvent.accountTypeChanged(value));
        }
      },
    );
  }

  Widget transitNumberField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.transitNumber,
      hintText: StringConstant.transitNumber,
      initialValue: state.transitNumber.getValue(),
      keyboardType: TextInputType.number,
      maxLength: 5,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.transitNumberChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.transitNumber.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddTransitNumber,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget bankInstitutionNumberField(
      BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.bankInstitutionNumber,
      hintText: StringConstant.bankInstitutionNumber,
      initialValue: state.bankInstitutionNumber.getValue(),
      keyboardType: TextInputType.number,
      maxLength: 3,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.instituteNumberChanged(value)),
      validator: (_, context) => context
          .read<BankDetailsBloc>()
          .state
          .bankInstitutionNumber
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseAddBankInstitutionNumber,
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }

  Widget firstNameField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.firstName,
      hintText: StringConstant.firstName,
      initialValue: state.firstName.getValue(),
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.firstNameChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.firstName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddFirstName,
                  invalidUsername: (value) =>
                      StringConstant.pleaseEnterYourValidFirstName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget lastNameField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.lastName,
      hintText: StringConstant.lastName,
      initialValue: state.lastName.getValue(),
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.lastNameChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.lastName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddLastName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget phoneNumberTextField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.phoneNumber,
      hintText: StringConstant.phoneNumber,
      initialValue: state.phoneNumber.getValue(),
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
        context.read<BankDetailsBloc>().add(
              BankDetailsEvent.phoneNumberChanged(value),
            );
      },
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.phoneNumber.value.fold(
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
          context.read<BankDetailsBloc>().add(
                BankDetailsEvent.selectCountryCode(
                  countryCode.phoneCode,
                  countryCode.flagEmoji,
                  countryCode.countryCode,
                ),
              );
        },
      ),
    );
  }

  /*  Widget dobField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.dateOfBirth,
      hintText: StringConstant.dateOfBirth,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.dobChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.dateOfBirth.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectDob,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }
 */

  Widget dobField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.dateOfBirth,
      hintText: (state.dateOfBirth.isValid())
          ? DateFormat('d MMM, yyyy')
              .format(DateTime.parse(state.dateOfBirth.getValue() ?? ""))
          : StringConstant.dateOfBirth,
      hintAsValue: (state.dateOfBirth.isValid()) ? true : false,
      readOnly: true,
      onTap: () {
        DocumentExpiryDatePicker.customDatePicker(
          context,
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          onPickedDate: (pickedDate) {
            context.read<BankDetailsBloc>().add(BankDetailsEvent.dobChanged(
                  pickedDate.toString(),
                ));
          },
          onCancelClick: () {},
          selectedDate: (state.dateOfBirth.isValid())
              ? DateTime.parse(state.dateOfBirth.getValue() ?? "")
              : DateTime.now(),
        );
      },
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.dateOfBirth.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectDob,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget bankAddressField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.bankAddress,
      isLabelPadding: true,
      hintText: StringConstant.bankAddress,
      readOnly: true,
      readOnlyTextStyle: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.black),
      onTap: () {
        LocationDialog.showLocationDialog(
          context,
          predictions: state.selectedLocationPrediction,
          location: BankDetailsBloc.locationCtrl.text,
        ).then((value) {
          if (value != null) {
            print("selected location ---> $value");
            context
                .read<BankDetailsBloc>()
                .add(BankDetailsEvent.locationSelectedFromSearchList(value));
          }
        });
      },
      controller: BankDetailsBloc.locationCtrl,
      validator: (p0, p1) =>
          context.read<BankDetailsBloc>().state.bankAddress.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectBankAddress,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget cityField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.city,
      hintText:
          (state.city.isValid()) ? state.city.getValue() : StringConstant.city,
      hintAsValue: (state.city.isValid()),
      // readOnly: true,
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.cityChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.city.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddCityName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget stateField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.state,
      hintText: (state.stateName.isValid())
          ? state.stateName.getValue()
          : StringConstant.state,
      hintAsValue: (state.stateName.isValid()),
      // readOnly: true,
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.stateChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.stateName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddStateName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget postalCodeField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.postalCode,
      hintText: (state.postalCode.isValid())
          ? state.postalCode.getValue()
          : StringConstant.postalCode,
      maxLength: 7,
      hintAsValue: (state.postalCode.isValid()),
      // readOnly: true,
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.postalCodeChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.postalCode.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddPostalCode,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget termsCheckBox(BankDetailsState state, BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool value = state.isCheck;
        value = !value;
        context
            .read<BankDetailsBloc>()
            .add(BankDetailsEvent.checkTermsCondition(value));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(10),
        ),
        decoration: BoxDecoration(
            color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: state.isCheck,
                activeColor: AppColors.primaryColor,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withValues(alpha: 0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  if (value != null) {
                    context
                        .read<BankDetailsBloc>()
                        .add(BankDetailsEvent.checkTermsCondition(value));
                  }
                },
              ),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Flexible(
              child: BaseText(
                text: StringConstant.bankDetailsTerms,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
