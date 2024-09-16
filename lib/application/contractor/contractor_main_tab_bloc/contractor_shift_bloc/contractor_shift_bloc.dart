import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'contractor_shift_event.dart';
part 'contractor_shift_state.dart';
part 'contractor_shift_bloc.freezed.dart';

@injectable
class ContractorShiftBloc
    extends Bloc<ContractorShiftEvent, ContractorShiftState> {
  ContractorShiftBloc() : super(ContractorShiftState.initial()) {
    on<ContractorShiftEvent>(
      (event, emit) async {
        await event.map(
          changeShiftTab: (e) async {
            emit(state.copyWith(selectedTab: e.tabIndex));
          },
        );
      },
    );
  }
}
