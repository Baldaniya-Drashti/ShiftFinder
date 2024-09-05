import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/home/view_single_applicants/view_single_applicants_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_card_number_formatter.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/common_card_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'AddCardView')
class AddCardView extends StatelessWidget {
  const AddCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ViewSingleApplicantsBloc>(),
      child: BlocConsumer<ViewSingleApplicantsBloc, ViewSingleApplicantsState>(
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    badRequest: (value) => value.error,
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(context);
              },
              (r) {
                showSuccess(message: r).show(context).then((value) async {
                  await context.router.maybePop(true);
                });
              },
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () {
                context.router.maybePop();
              },
              title: 'Add Card',
            ),
            body: GestureDetector(
              onTap: () {
                AppFocus.unfocus(context);
              },
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(getSize(20)),
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(20),
                      vertical: getSize(14),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDEDED),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgImageConstant.card),
                        SizedBox(
                          width: getSize(15),
                        ),
                        Image.asset(
                          PngImageConstants.line,
                          height: getSize(80),
                        ),
                        SizedBox(
                          width: getSize(15),
                        ),
                        Expanded(
                          child: BaseText(
                            text:
                                'Please upload your card details, Adding a card is mandatory to accept any application or proposal.',
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  Form(
                    autovalidateMode: state.showErrorMessages
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(18),
                        vertical: getSize(32),
                      ),
                      children: [
                        cardHolderNameTextFiled(context),
                        SizedBox(
                          height: getSize(20),
                        ),
                        cardNumberTextFiled(context, state),
                        SizedBox(
                          height: getSize(20),
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    validUpToTextFiled(context, state),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: getSize(19),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    cvvTextFiled(context, state),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(18),
                  vertical: isFullScreenDevice(context) ? 0 : getSize(18),
                ),
                child: CommonButton(
                  onPressed: () {
                    CommonCardDialog(
                      title: 'Awaiting Confirmation',
                      description:
                          'Application accepted, Contractor\nnotified for Confirmation.',
                      buttonText: 'Ok',
                      onPressed: () {
                        context.router.maybePop();
                        // context.router.push(PageRouteInfo(AddCardView.name));
                      },
                      image: SvgImageConstant.awaitingConfirmation,
                    ).addCardDialog(context);
                    // context.read<ViewSingleApplicantsBloc>().add(
                    //     ViewSingleApplicantsEvent.saveButtonPressed(context));
                  },
                  buttonText: 'Add Your Card',
                  isSubmitting: state.isSubmitting,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  CustomTextField cvvTextFiled(
      BuildContext context, ViewSingleApplicantsState state) {
    return CustomTextField(
      labelText: 'Cvv',
      hintText: 'Cvv',
      //  focusNode: state.cvvNumberFocusNode,
      maxLength: 4,
      keyboardType: TextInputType.number,
      obscureText: true,
      onChanged: (cvv) => context
          .read<ViewSingleApplicantsBloc>()
          .add(ViewSingleApplicantsEvent.cvvChanged(cvv, context)),
      validator: (p0, p1) =>
          context.read<ViewSingleApplicantsBloc>().state.cvv.value.fold(
              (l) => l.maybeMap(
                    empty: (value) => 'Please enter cvv',
                    invalidCvv: (value) => 'Please enter valid cvv',
                    orElse: () => null,
                  ),
              (r) => null),
    );
  }

  CustomTextField validUpToTextFiled(
      BuildContext context, ViewSingleApplicantsState state) {
    return CustomTextField(
      errorMaxLines: 3,
      //focusNode: state.validUptoFocusNode,
      labelText: 'Exp Date',
      hintText: 'Exp Date',
      suffixIcon: SvgPicture.asset(
        SvgImageConstant.expDateCalendar,
        height: getSize(24),
        width: getSize(24),
        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
        //color: AppColors.primaryColor,
      ),
      keyboardType: TextInputType.number,

      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        CardMonthInputFormatter(),
      ],
      onChanged: (date) => context.read<ViewSingleApplicantsBloc>().add(
            ViewSingleApplicantsEvent.validUpToChanged(
              date,
            ),
          ),
      validator: (p0, p1) =>
          context.read<ViewSingleApplicantsBloc>().state.cardDate.value.fold(
              (l) => l.maybeMap(
                    orElse: () => null,
                    empty: (value) => 'Please enter valid date in MM/YY format',
                    invalidaCardMonth: (value) =>
                        'Please enter valid month in MM format',
                    invalidaCardYear: (value) =>
                        'Please enter valid year in YY format',
                    cardExpired: (value) => 'Your card has been expired',
                  ),
              (r) => null),
    );
  }

  CustomTextField cardNumberTextFiled(
      BuildContext context, ViewSingleApplicantsState state) {
    return CustomTextField(
      labelText: 'Card Number',
      hintText: 'Card Number',
      keyboardType: TextInputType.number,

      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.card,
          height: getSize(24),
          width: getSize(24),
          colorFilter:
              ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          //color: AppColors.primaryColor,
        ),
      ),
      //  focusNode: state.mobileNumberFocusNode,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(19),
        CardNumberInputFormatter(),
      ],
      onChanged: (cardNo) => context
          .read<ViewSingleApplicantsBloc>()
          .add(ViewSingleApplicantsEvent.cardNumberChanged(cardNo)),
      validator: (p0, p1) =>
          context.read<ViewSingleApplicantsBloc>().state.cardNumber.value.fold(
              (l) => l.maybeMap(
                    empty: (value) => 'Please enter card number',
                    invalidCardNumber: (value) =>
                        'Please enter valid card number',
                    orElse: () => null,
                  ),
              (r) => null),
    );
  }

  CustomTextField cardHolderNameTextFiled(BuildContext context) {
    return CustomTextField(
      labelText: 'Card Holder’s Name',
      hintText: 'Card Holder’s Name',
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
          colorFilter:
              ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          //color: AppColors.primaryColor,
        ),
      ),
      textCapitalization: TextCapitalization.words,
      onChanged: (cardHolderName) => context
          .read<ViewSingleApplicantsBloc>()
          .add(ViewSingleApplicantsEvent.cardHolderNameChanged(cardHolderName)),
      validator: (p0, p1) => context
          .read<ViewSingleApplicantsBloc>()
          .state
          .cardHoldersName
          .value
          .fold(
              (l) => l.maybeMap(
                    empty: (value) => 'Please enter card holder name',
                    invalidUsername: (value) =>
                        'Please enter valid card holder name',
                    orElse: () => null,
                  ),
              (r) => null),
    );
  }
}
