// ignore_for_file: use_build_context_synchronously, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_card_number_formatter.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addCardDetailPage')
class AddCardDetailPage extends StatelessWidget {
  final bool isFromSplash;
  final bool fromRegister;

  const AddCardDetailPage({
    super.key,
    this.isFromSplash = false,
    this.fromRegister = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unfocus(context);
      },
      child: BlocProvider(
        create: (context) => getIt<CardBloc>(),
        child: BlocConsumer<CardBloc, CardState>(
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
                  print("Succeffff");
                  // showSuccess(
                  //         message: r.dioMessage ??
                  //             StringConstant.cardHasBeenSuccessFullAdded)
                  //     .show(context);
                  // AppDialog.showInfo(context, r.dioMessage ?? "Card has been sucessfully Added!");
                  // context.router.replace(const PageRouteInfo(MainTabView.name));
                  if (fromRegister) {
                    context.router
                        .replaceAll([const PageRouteInfo(MainTabView.name)]);
                  } else {
                    context.router.maybePop(true);
                  }
                },
              ),
            );
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: CommonAppBar(
                isShowBackBtn: !isFromSplash,
                onBackPressed: () {
                  context.router.maybePop();
                },
                title: StringConstant.addCard,
                showSkipBtn: fromRegister,
                onSkipped: () {
                  // context.router.replace(const PageRouteInfo(MainTabView.name));
                  context.router
                      .replaceAll([const PageRouteInfo(MainTabView.name)]);
                  // AppDialog.showInfo(context, StringConstant.underDevelopment);
                },
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      autovalidateMode: (state.showErrorMessages)
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          cardDesc(),
                          paddingBetweenFields(),
                          holderNameField(context, state),
                          paddingBetweenFields(),
                          cardNumberField(context, state),
                          paddingBetweenFields(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              expDateTextField(context, state),
                              cvvNoField(context, state),
                            ],
                          ),
                        ],
                      ),
                    ),
                    paddingBetweenFields(),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: getSize(30),
                      ),
                      child: CommonButton(
                        isSubmitting: state.isSubmitting,
                        onPressed: () {
                          context
                              .read<CardBloc>()
                              .add(CardEvent.addCardBtnPressed(context));
                        },
                        buttonText: StringConstant.addYourCard,
                      ),
                    ),
                  ],
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

  cardDesc() {
    return Container(
      height: getSize(90),
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
      ),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgImageConstant.card,
            height: getSize(33),
            width: getSize(49),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: SvgPicture.asset(
              SvgImageConstant.verticalLine,
              height: getSize(50),
              width: getSize(49),
            ),
          ),
          Flexible(
            child: BaseText(
              text: StringConstant.cardDesc,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  holderNameField(BuildContext context, CardState state) {
    return CustomTextField(
      labelText: StringConstant.cardHoldersName,
      hintText: StringConstant.cardHoldersName,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
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
      onChanged: (value) =>
          context.read<CardBloc>().add(CardEvent.holderNameChanged(value)),
      validator: (p0, p1) =>
          context.read<CardBloc>().state.cardHolderName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddCardHolderName,
                  invalidUsername: (value) =>
                      StringConstant.pleaseAddValidCardHolderName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  cardNumberField(BuildContext context, CardState state) {
    return CustomTextField(
      labelText: StringConstant.cardNumber,
      hintText: StringConstant.cardNumber,
      // maxLength: 19,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        CardNumberInputFormatter(),
      ],
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.icCard,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) =>
          context.read<CardBloc>().add(CardEvent.cardNoChanged(value)),
      validator: (p0, p1) => context
          .read<CardBloc>()
          .state
          .cardNumber
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseAddCardNumber,
              invalidCardNumber: (value) => StringConstant.cardNumberIsInValid,
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }

  Widget expDateTextField(BuildContext context, CardState state) {
    return SizedBox(
      width: getSize(150),
      child: CustomTextField(
        errorMaxLines: 2,
        labelText: StringConstant.expDate,
        hintText: StringConstant.mmYY,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
          CardMonthInputFormatter(),
        ],
        onChanged: (date) => context.read<CardBloc>().add(
              CardEvent.expDateChanged(date),
            ),
        validator: (p0, p1) =>
            context.read<CardBloc>().state.expDate.value.fold(
                (l) => l.maybeMap(
                      orElse: () => null,
                      empty: (value) => StringConstant.pleaseAddExpiryDate,
                      invalidaCardMonth: (value) =>
                          StringConstant.enterValidExpiryDate,
                      invalidaCardYear: (value) =>
                          StringConstant.enterValidExpiryDate,
                      cardExpired: (value) =>
                          StringConstant.enterValidExpiryDate,
                    ),
                (r) => null),
      ),
    );
  }

  cvvNoField(BuildContext context, CardState state) {
    return SizedBox(
      width: getSize(150),
      child: CustomTextField(
        labelText: StringConstant.cvv,
        hintText: StringConstant.cvv,
        maxLength: 4,
        errorMaxLines: 2,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) =>
            context.read<CardBloc>().add(CardEvent.cvvNoChanged(value)),
        validator: (p0, p1) => context.read<CardBloc>().state.cvvNo.value.fold(
              (f) => f.maybeMap(
                empty: (value) => StringConstant.pleaseAddCvvNumber,
                invalidCvv: (value) => StringConstant.cvvNumberIsInValid,
                orElse: () => null,
              ),
              (_) => null,
            ),
      ),
    );
  }

  Future<void> customDatePicker(
    BuildContext context,
    CardState state, {
    required DateTime? selectedDate,
  }) async {
    print("selectedDate------->  $selectedDate");

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950, 1),
      lastDate: DateTime(2100, 1),
      initialDate: selectedDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
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
      context
          .read<CardBloc>()
          .add(CardEvent.expDateChanged(pickedDate.toString()));
    }
  }
}
