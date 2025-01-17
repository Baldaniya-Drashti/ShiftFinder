import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contractor_full_time_position_event.dart';
part 'contractor_full_time_position_state.dart';
part 'contractor_full_time_position_bloc.freezed.dart';

class ContractorFullTimePositionBloc extends Bloc<ContractorFullTimePositionEvent, ContractorFullTimePositionState> {
  ContractorFullTimePositionBloc() : super(const ContractorFullTimePositionState()) {
    on<ContractorFullTimePositionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
