part of 'contractor_earning_bloc.dart';

@freezed
class ContractorEarningEvent with _$ContractorEarningEvent {
  const factory ContractorEarningEvent.onDateSelected({
    required List<DateTime> dates,
  }) = _OnDateSelected;
  const factory ContractorEarningEvent.downloadContractorEarningEvent(
          BuildContext context,
          {required MonthlyStatementDTO statement}) =
      DownloadContractorEarningEvent;
  const factory ContractorEarningEvent.getTotalEarningStatement(
      {DateTime? startDate, DateTime? endDate}) = GetTotalEarningStatement;
}
