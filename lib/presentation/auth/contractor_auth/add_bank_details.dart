// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/contractor_auth/bank_details_bloc/bank_details_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addBankDetailsScreen')
class AddBankDetailsScreen extends StatelessWidget {
  bool isFromSplash = false;

  AddBankDetailsScreen({super.key, this.isFromSplash = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unfocus(context);
      },
      child: BlocProvider(
        create: (context) => BankDetailsBloc(),
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
                  context.router.push(
                    const PageRouteInfo(LegalScreeningQuestionsPage.name),
                  );
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
                title: StringConstant.addBankDetails,
              ),
              body: Form(
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
                        accountHolderNameField(context, state),
                        paddingBetweenFields(),
                        bankNameDropdown(context, state),
                        paddingBetweenFields(),
                        transitNumberField(context, state),
                        paddingBetweenFields(),
                        bankInstitutionNumberField(context, state),
                        paddingBetweenFields(),
                        accountNumberField(context, state),
                        paddingBetweenFields(),
                        bankAddressField(context, state),
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
                            onPressed: () {
                              context
                                  .read<BankDetailsBloc>()
                                  .add(BankDetailsEvent.submitBtnPressed());
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

  Widget transitNumberField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.transitNumber,
      hintText: StringConstant.transitNumber,
      keyboardType: TextInputType.number,
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
      keyboardType: TextInputType.number,
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

  Widget accountNumberField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.accountNumber,
      hintText: StringConstant.accountNumber,
      textCapitalization: TextCapitalization.characters,
      keyboardType: TextInputType.number,
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

  Widget accountHolderNameField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.accountHolderName,
      hintText: StringConstant.accountHolderName,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.accountHolderNameChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.accountHolderName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddAccountHolderName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget bankAddressField(BuildContext context, BankDetailsState state) {
    return CustomTextField(
      labelText: StringConstant.bankAddress,
      hintText: StringConstant.bankAddress,
      onChanged: (value) => context
          .read<BankDetailsBloc>()
          .add(BankDetailsEvent.bankAddressChanged(value)),
      validator: (_, context) =>
          context.read<BankDetailsBloc>().state.bankAddress.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddBankAddress,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget termsCheckBox(BankDetailsState state, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10)),
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
                color: AppColors.black.withOpacity(0.5),
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
    );
  }
}
