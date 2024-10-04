part of 'view_single_applicants_bloc.dart';

@freezed
class ViewSingleApplicantsEvent with _$ViewSingleApplicantsEvent {
  const factory ViewSingleApplicantsEvent.cardHolderNameChanged(
      String cardHolderName) = CardHolderNameChanged;

  const factory ViewSingleApplicantsEvent.cardNumberChanged(String cardNo) =
      CardNumberChanged;

  const factory ViewSingleApplicantsEvent.validUpToChanged(String date) =
      ValidUpToChanged;

  const factory ViewSingleApplicantsEvent.cvvChanged(
      String cvv, BuildContext context) = CvvChanged;

  const factory ViewSingleApplicantsEvent.getViewSingleApplicantsAPI() =
      GetViewSingleApplicantsAPI;
  const factory ViewSingleApplicantsEvent.saveButtonPressed(
      BuildContext context) = SaveButtonPressed;
  const factory ViewSingleApplicantsEvent.getShiftDetailEvent(int postId,
      {@Default(false) bool fromDashboard}) = GetShiftDetailEvent;
}
