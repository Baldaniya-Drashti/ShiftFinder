part of 'contractor_notification_bloc.dart';

@freezed
class ContractorNotificationEvent with _$ContractorNotificationEvent {
  factory ContractorNotificationEvent.getNotificationList({
    required bool isRefresh,
  }) = GetNotificationList;
}
