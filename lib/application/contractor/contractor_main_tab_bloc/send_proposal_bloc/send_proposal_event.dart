part of 'send_proposal_bloc.dart';

@freezed
class SendProposalEvent with _$SendProposalEvent {
  const factory SendProposalEvent.tabChangeEvent(int tabIndex) = TabChangeEvent;
  const factory SendProposalEvent.setDateUnavailableEvent(
      List<DateTime> selectedDateList) = SetDateUnavailableEvent;
  const factory SendProposalEvent.getContractorShiftDetail(int postID) =
      GetContractorShiftDetail;

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

  /// For Single shift
  const factory SendProposalEvent.startHourChanged(String hour) =
      StartHourChanged;
  const factory SendProposalEvent.startMinuteChanged(String minute) =
      StartMinuteChanged;
  const factory SendProposalEvent.endHourChanged(String hour) = EndHourChanged;
  const factory SendProposalEvent.endMinuteChanged(String minute) =
      EndMinuteChanged;
  const factory SendProposalEvent.totalPayableHoursChanged() =
      TotalPayableHoursChanged;
  const factory SendProposalEvent.submitSingleShiftProposalEvent(
      BuildContext context) = SubmitSingleShiftProposalEvent;

  /// For Multi shift
  const factory SendProposalEvent.startHourListChanged(
      String hour, int index, String date) = StartHourListChanged;
  const factory SendProposalEvent.startMinuteListChanged(
      String minute, int index, String date) = StartMinuteListChanged;
  const factory SendProposalEvent.endHourListChanged(
      String hour, int index, String date) = EndHourListChanged;
  const factory SendProposalEvent.endMinuteListChanged(
      String minute, int index, String date) = EndMinuteListChanged;
  const factory SendProposalEvent.getMultiDateEvent(
          HealthcarePostDTO post, List<DateTimeDTO>? updatedDates) =
      GetMultiDateEvent;
  const factory SendProposalEvent.setMultiDate(
    List<DateTimeDTO> updatedDates,
  ) = SetMultiDate;
  const factory SendProposalEvent.submitMultiShiftProposalEvent(
      BuildContext context) = SubmitMultiShiftProposalEvent;
}
