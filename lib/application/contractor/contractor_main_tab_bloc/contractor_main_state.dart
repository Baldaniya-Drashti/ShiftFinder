part of 'contractor_main_bloc.dart';

@freezed
class ContractorMainTabState with _$ContractorMainTabState {
  factory ContractorMainTabState({
    required int selectedTab,
    required int pageIndex,
    required String homePage,
    required String historyPage,
    required String notificationPage,
    required String profilePage,
  }) = _ContractorMainTabState;
  factory ContractorMainTabState.initial() => ContractorMainTabState(
        selectedTab: 0,
        pageIndex: 0,
        homePage: ContractorHomeView.name,
        historyPage: HistoryView.name,
        notificationPage: NotificationView.name,
        profilePage: ProfileView.name,
      );
}
