part of 'contractor_notification_bloc.dart';

@freezed
class ContractorNotificationState with _$ContractorNotificationState {
  factory ContractorNotificationState({
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
    required List<NotificationDTO> notificationList,
    required bool showErrorMessages,
  }) = _ContractorNotificationState;
  factory ContractorNotificationState.initial() => ContractorNotificationState(
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
        notificationList: [],
        showErrorMessages: false,
      );
}
