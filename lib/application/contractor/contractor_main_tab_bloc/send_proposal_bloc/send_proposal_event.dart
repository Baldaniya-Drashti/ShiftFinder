part of 'send_proposal_bloc.dart';

@freezed
class SendProposalEvent with _$SendProposalEvent {
  const factory SendProposalEvent.tabChangeEvent(int tabIndex) = TabChangeEvent;
  const factory SendProposalEvent.getContractorShiftDetail(int postID) =
      GetContractorShiftDetail;
  const factory SendProposalEvent.getMultiDateEvent() = GetMultiDateEvent;
  const factory SendProposalEvent.setDateUnavailableEvent(
      List<DateTime> selectedDateList) = SetDateUnavailableEvent;
  const factory SendProposalEvent.submitProposalEvent() = SubmitProposalEvent;
  const factory SendProposalEvent.rateHourChanged(String rate) =
      RateHourChanged;

  const factory SendProposalEvent.commuteRateChanged(String rate) =
      CommuteRateChanged;

  const factory SendProposalEvent.commuteHourChanged(String hour) =
      CommuteHourChanged;
  const factory SendProposalEvent.accomdationHourChanged(String rate) =
      AccomdationHourChanged;
  const factory SendProposalEvent.accomdationRateChanged(String hour) =
      AccomdationRateChanged;
}
