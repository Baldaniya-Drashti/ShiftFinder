part of 'contractor_main_bloc.dart';

@freezed
class ContractorMainTabEvent with _$ContractorMainTabEvent {
  factory ContractorMainTabEvent.tabChange(int tabIndex) = TabChange;

  factory ContractorMainTabEvent.registerForPush() = RegisterForPush;
  /* factory ContractorMainTabEvent.pushNotificationInitialize(
      BuildContext context) = PushNotificationInitialize;
  factory ContractorMainTabEvent.initDynamicLink(BuildContext context) =
      InitDynamicLink; */
}
