import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';

part 'card_event.dart';
part 'card_state.dart';
part 'card_bloc.freezed.dart';

@Injectable()
class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState.initial()) {
    on<CardEvent>((event, emit) {
      event.map(
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
        addCardBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isHolderNameValidated = state.cardHolderName.isValid();
          final isCardNoValidated = state.cardNumber.isValid();
          final isCvvNoValidated = state.cvvNo.isValid();

          if (isHolderNameValidated && isCardNoValidated && isCvvNoValidated) {
            print("All Details are validdddddd! ");
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            // failureOrSuccess = await _authFacade.login(
            //   mobileNumber: state.emailId,
            //   countryCode: '+${state.selectedCountrycode}',
            // );
            failureOrSuccess = right("success");
          }
          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
