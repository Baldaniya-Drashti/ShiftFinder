import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/main/payment_card_detail_dto/payment_card_detail_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'payment_method_event.dart';
part 'payment_method_state.dart';
part 'payment_method_bloc.freezed.dart';

@injectable
class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final IMainFacade _mainFacade;
  PaymentMethodBloc(this._mainFacade) : super(PaymentMethodState.initial()) {
    on<PaymentMethodEvent>((event, emit) async {
      await event.map(
        getCardList: (e) async {
          Either<MainFailure, List<PaymentCardDTO>>? failureOrSuccess;

          emit(state.copyWith(
            isLoading: true,
            failureOrSuccessOption: none(),
          ));

          failureOrSuccess = await _mainFacade.getCardListAPI();
          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(e.context);
              emit(state.copyWith(
                isLoading: false,
                showErrorMessages: true,
                failureOrSuccessOption: none(),
              ));
            },
            (r) {
              print("Card List --> $r");
              emit(state.copyWith(
                isLoading: false,
                showErrorMessages: false,
                cardList: r,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              ));
            },
          );
        },
        deleteCardEvent: (e) async {
          Either<MainFailure, String>? failureOrSuccess;

          emit(state.copyWith(isDeleting: true));
          failureOrSuccess = await _mainFacade.deletePaymentCardAPI(id: e.id);
          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(e.context);
              emit(state.copyWith(isDeleting: false));
            },
            (r) {
              showSuccess(message: r).show(e.context).then((value) {
                add(PaymentMethodEvent.getCardList(e.context));
              });
              emit(state.copyWith(isDeleting: false));
            },
          );
        },
      );
    });
  }
}
