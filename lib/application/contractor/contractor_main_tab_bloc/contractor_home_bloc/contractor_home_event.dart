part of 'contractor_home_bloc.dart';

@freezed
class ContractorHomeEvent with _$ContractorHomeEvent {
  const factory ContractorHomeEvent.initialEvent() = InitialEvent;
  const factory ContractorHomeEvent.deletePost(int postId) = DeletePost;
  const factory ContractorHomeEvent.getContractorDashboardList(bool isRefresh,
      {int? filterType}) = GetContractorDashboardList;
  factory ContractorHomeEvent.filterShiftEvent(String filterType) =
      FilterShiftEvent;
  const factory ContractorHomeEvent.getShiftDetailEvent(int postId) =
      GetShiftDetailEvent;
}
