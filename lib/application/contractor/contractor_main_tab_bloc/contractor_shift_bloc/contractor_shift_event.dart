part of 'contractor_shift_bloc.dart';

@freezed
class ContractorShiftEvent with _$ContractorShiftEvent {
  const factory ContractorShiftEvent.changeShiftTab(int tabIndex) =
      ChangeShiftTab;
}
