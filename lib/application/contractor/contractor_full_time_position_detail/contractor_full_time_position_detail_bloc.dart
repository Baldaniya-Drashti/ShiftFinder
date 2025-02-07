import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'contractor_full_time_position_detail_event.dart';
part 'contractor_full_time_position_detail_state.dart';
part 'contractor_full_time_position_detail_bloc.freezed.dart';

class ContractorFullTimePositionDetailBloc extends Bloc<
    ContractorFullTimePositionDetailEvent,
    ContractorFullTimePositionDetailState> {
  ContractorFullTimePositionDetailBloc()
      : super(const ContractorFullTimePositionDetailState.initial()) {
    on<ContractorFullTimePositionDetailEvent>((event, emit) {});
  }
}
