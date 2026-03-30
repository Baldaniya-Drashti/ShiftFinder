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

  const factory ViewSingleApplicantsEvent.saveButtonPressed(
      BuildContext context) = SaveButtonPressed;

  const factory ViewSingleApplicantsEvent.getApplicantsList(
      int id, bool isRefresh) = GetApplicantsList;

  const factory ViewSingleApplicantsEvent.acceptApplicants(
      BuildContext context, int id) = AcceptApplicants;

  const factory ViewSingleApplicantsEvent.rejectApplicants(
      BuildContext context, int id) = RejectApplicants;

  const factory ViewSingleApplicantsEvent.onRevoke(
      {required int postId,
      required int userId,
      required BuildContext context}) = OnRevoke;

  const factory ViewSingleApplicantsEvent.getShiftDetailEvent(int postId,
      {@Default(false) bool fromDashboard}) = GetShiftDetailEvent;

  const factory ViewSingleApplicantsEvent.startRevokingTimer(
      {required Duration duration,
      required int postId,
      required int revokeTime}) = StartRevokingTimer;
}
