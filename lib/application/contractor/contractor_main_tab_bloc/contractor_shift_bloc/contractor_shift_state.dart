part of 'contractor_shift_bloc.dart';

@freezed
class ContractorShiftState with _$ContractorShiftState {
  factory ContractorShiftState({required int selectedTab}) =
      _ContractorShiftState;
  factory ContractorShiftState.initial() => ContractorShiftState(
        selectedTab: 0,
      );
}
