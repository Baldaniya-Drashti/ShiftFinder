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
    required Widget? currentPage,
    required bool teamStatusErrorMessage,
    required Option<Either<MainFailure, TeamAvailableDTO>>
        teamStatusFailureOrSuccessOption,
    required bool showTeamDialog,
  }) = _MainTabState;
  factory MainTabState.initial() => MainTabState(
        selectedTab: 0,
        pageIndex: 0,
        homePage: route.HomeView.name,
        employerShiftPage: route.EmployerShiftView.name,
        notificationPage: route.NotificationView.name,
        profilePage: route.ProfileView.name,
        currentPage: null,
        teamStatusFailureOrSuccessOption: none(),
        teamStatusErrorMessage: false,
        showTeamDialog: false,
      );
}
