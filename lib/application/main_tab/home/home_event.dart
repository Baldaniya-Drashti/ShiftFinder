part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.initialEvent() = InitialEvent;
  const factory HomeEvent.getEmployerDashboardList(bool isRefresh) =
      GetEmployerDashboardList;
}
