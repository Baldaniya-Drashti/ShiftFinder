// ignore_for_file: avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'card_event.dart';
part 'card_state.dart';
part 'card_bloc.freezed.dart';

@Injectable()
class CardBloc extends Bloc<CardEvent, CardState> {
  final IMainFacade mainFacade;

  CardBloc(this.mainFacade) : super(CardState.initial()) {
    on<CardEvent>((event, emit) async {
      await event.map(
        holderNameChanged: (e) {
          emit(
            state.copyWith(
              cardHolderName: Username(e.holderName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        cardNoChanged: (e) {
          emit(
            state.copyWith(
              cardNumber: CardNumber(e.cardNo),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        cvvNoChanged: (e) {
          emit(
            state.copyWith(
              cvvNo: CVV(e.cvv),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        expDateChanged: (e) {
          emit(
            state.copyWith(
              expDate: CardDate(e.expDate),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        addCardBtnPressed: (e) async {
          Either<MainFailure, CommonResponse<dynamic>>? failureOrSuccess;

          final isHolderNameValid = state.cardHolderName.isValid();
          final isCardNoValid = state.cardNumber.isValid();
          final isCvvNoValid = state.cvvNo.isValid();
          final isCardDateValid = state.expDate.isValid();

          if (isHolderNameValid &&
              isCardNoValid &&
              isCvvNoValid &&
              isCardDateValid) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );

            try {
              final card = CardDetails(
                number: state.cardNumber.getOrCrash()?.trim() ?? "",
                expirationMonth:
                    int.parse(state.expDate.getOrCrash()?.split('/')[0] ?? ""),
                expirationYear:
                    int.parse(state.expDate.getOrCrash()?.split('/')[1] ?? ""),
                cvc: state.cvvNo.getOrCrash()?.trim() ?? "",
              );

              await Stripe.instance.dangerouslyUpdateCardDetails(card);

              final paymentMethod = await Stripe.instance.createPaymentMethod(
                params: PaymentMethodParams.card(
                  paymentMethodData: PaymentMethodData(),
                ),
              );

              if (paymentMethod.id.isNotEmpty) {
                failureOrSuccess = await mainFacade.addCardAPI(
                  paymentMethodId: paymentMethod.id,
                );
              }
            } catch (error) {
              print("error--> $error");

              String errorMessage = "Something went wrong.";

              if (error is StripeException) {
                errorMessage = error.error.localizedMessage ??
                    error.error.message ??
                    errorMessage;
              }

              showError(message: errorMessage).show(e.context);
              emit(
                state.copyWith(
                  showErrorMessages: true,
                  isSubmitting: false,
                  authFailureOrSuccessOption: none(),
                ),
              );
              return;
            }
          } else {
            emit(
              state.copyWith(
                showErrorMessages: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            return;
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: false,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        /*    addCardBtnPressed: (e) async {
          // Either<AuthFailure, String>? failureOrSuccess;
          Either<MainFailure, CommonResponse<dynamic>>? failureOrSuccess;
          final isHolderNameValid = state.cardHolderName.isValid();
          final isCardNoValid = state.cardNumber.isValid();
          final isCvvNoValid = state.cvvNo.isValid();
          final isCardDateValid = state.expDate.isValid();

          if (isHolderNameValid &&
              isCardNoValid &&
              isCvvNoValid &&
              isCardDateValid) {
            print("All Details are validdddddd! ");
            print("Card Holder Name: ${state.cardHolderName}");
            print("Card No: ${state.cardNumber}");
            print("Card CVV No: ${state.cvvNo}");
            print("Card Date: ${state.expDate}");

            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );

            try {
              CardDetails card = CardDetails(
                number: state.cardNumber.getOrCrash()?.trim() ?? "",
                expirationMonth:
                    int.parse(state.expDate.getOrCrash()?.split('/')[0] ?? ""),
                expirationYear:
                    int.parse(state.expDate.getOrCrash()?.split('/')[1] ?? ""),
                cvc: state.cvvNo.getOrCrash()?.trim() ?? "",
              );
              await Stripe.instance.dangerouslyUpdateCardDetails(card);
              print("Stripe card details--->  $card");

              final paymentMethod = await Stripe.instance.createPaymentMethod(
                  params: PaymentMethodParams.card(
                paymentMethodData: PaymentMethodData(),
              ));
              print("Payment Method: $paymentMethod");
              if (paymentMethod.id.isNotEmpty) {
                failureOrSuccess = await mainFacade.addCardAPI(
                  paymentMethodId: paymentMethod.id,
                );
              }
            } catch (error) {
              showError(message: error.toString()).show(e.context);
              emit(
                state.copyWith(
                  showErrorMessages: true,
                  isSubmitting: false,
                  authFailureOrSuccessOption: none(),
                ),
              );
            }
            // failureOrSuccess = right("success");
            // e.context.router.maybePop();
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      */
      );
    });
  }
}
