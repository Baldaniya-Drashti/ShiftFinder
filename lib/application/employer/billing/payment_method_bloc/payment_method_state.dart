part of 'payment_method_bloc.dart';

@freezed
class PaymentMethodState with _$PaymentMethodState {
  const factory PaymentMethodState({
    required bool isLoading,
    required bool isDeleting,
    required List<PaymentCardDTO> cardList,
    required bool showErrorMessages,
    required Option<Either<MainFailure, List<PaymentCardDTO>>>
        failureOrSuccessOption,
  }) = _PaymentMethodState;

  factory PaymentMethodState.initial() => PaymentMethodState(
        isLoading: false,
        isDeleting: false,
        cardList: [],
        showErrorMessages: false,
        failureOrSuccessOption: none(),
      );
}
