part of 'contractor_main_bloc.dart';

@freezed
class ContractorMainTabEvent with _$ContractorMainTabEvent {
  factory ContractorMainTabEvent.tabChange(int tabIndex) = TabChange;
}
