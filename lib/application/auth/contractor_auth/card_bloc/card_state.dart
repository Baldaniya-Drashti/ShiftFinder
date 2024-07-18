part of 'card_bloc.dart';

@freezed
class CardState with _$CardState {
  const factory CardState({
    required Username cardHolderName,
    required CardNumber cardNumber,
    required CVV cvvNo,
    required CardDate expDate,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _CardState;

  factory CardState.initial() => CardState(
        cardHolderName: Username(""),
        cardNumber: CardNumber(""),
        cvvNo: CVV(""),
        expDate: CardDate(""),
        isSubmitting: false,
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),
      );
}
