part of 'contractor_home_bloc.dart';

@freezed
class ContractorHomeEvent with _$ContractorHomeEvent {
  const factory ContractorHomeEvent.initialEvent() = InitialEvent;
  const factory ContractorHomeEvent.deletePost(int postId) = DeletePost;
  const factory ContractorHomeEvent.getContractorDashboardList(bool isRefresh,
      {int? filterType, String? search}) = GetContractorDashboardList;
  factory ContractorHomeEvent.filterShiftEvent(String filterType) =
      FilterShiftEvent;
  const factory ContractorHomeEvent.getShiftDetailEvent(int postId) =
      GetShiftDetailEvent;
  const factory ContractorHomeEvent.applyShiftSubmittedEvent(
      int? postId, BuildContext context) = ApplyShiftSubmittedEvent;

  const factory ContractorHomeEvent.onSearchJobRole({
    required String query,
  }) = OnSearchJobRole;

  const factory ContractorHomeEvent.getSearchText({required String val}) =
      GetSearchText;
}
