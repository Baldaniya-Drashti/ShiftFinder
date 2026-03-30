part of 'card_bloc.dart';

@freezed
class CardEvent with _$CardEvent {
  const factory CardEvent.holderNameChanged(String holderName) =
      HolderNameChanged;
  const factory CardEvent.cardNoChanged(String cardNo) = CardNoChanged;
  const factory CardEvent.cvvNoChanged(String cvv) = CvvNoChanged;
  const factory CardEvent.expDateChanged(String expDate) = ExpDateChanged;
  const factory CardEvent.addCardBtnPressed(BuildContext context) = AddCardBtnPressed;
}
