part of 'payment_method_bloc.dart';

@freezed
class PaymentMethodEvent with _$PaymentMethodEvent {
  const factory PaymentMethodEvent.getCardList(BuildContext context) =
      GetCardList;
  const factory PaymentMethodEvent.deleteCardEvent(
      BuildContext context, int id) = DeleteCardEvent;
}
