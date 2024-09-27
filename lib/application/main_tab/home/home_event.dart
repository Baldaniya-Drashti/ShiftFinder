part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.initialEvent() = InitialEvent;
  const factory HomeEvent.deletePost(int postId) = DeletePost;
  const factory HomeEvent.getEmployerDashboardList(bool isRefresh) =
      GetEmployerDashboardList;
  const factory HomeEvent.checkTeamAvailableEvent(BuildContext context,
      {int? index}) = CheckTeamAvailableEvent;
}
