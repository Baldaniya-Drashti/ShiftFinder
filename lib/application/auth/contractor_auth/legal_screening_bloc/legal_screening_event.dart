part of 'legal_screening_bloc.dart';

@freezed
class LegalScreeningEvent with _$LegalScreeningEvent {
  const factory LegalScreeningEvent.getLegalScreeningQuestionList() =
      GetLegalScreeningQuestionList;
  const factory LegalScreeningEvent.checkTermsConfirmation(bool isCheck) =
      CheckTermsConfirmation;

  const factory LegalScreeningEvent.storeAnswerEvent(
      int currentIndex, String answer) = StoreAnswerEvent;
  const factory LegalScreeningEvent.continueBtnPressed() = ContinueBtnPressed;
}
