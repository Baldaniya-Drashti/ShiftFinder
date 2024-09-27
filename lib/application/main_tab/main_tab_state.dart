part of 'main_tab_bloc.dart';

@freezed
class MainTabState with _$MainTabState {
  factory MainTabState({
    required int selectedTab,
    required int pageIndex,
    required String homePage,
    required String employerShiftPage,
    required String notificationPage,
    required String profilePage,
  }) = _MainTabState;
  factory MainTabState.initial() => MainTabState(
        selectedTab: 0,
        pageIndex: 0,
        homePage: HomeView.name,
        employerShiftPage: EmployerShiftView.name,
        notificationPage: NotificationView.name,
        profilePage: ProfileView.name,
      );
}
