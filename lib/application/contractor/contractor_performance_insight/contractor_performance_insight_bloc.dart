import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contractor_performance_insight_event.dart';

part 'contractor_performance_insight_state.dart';

part 'contractor_performance_insight_bloc.freezed.dart';

class ContractorPerformanceInsightBloc extends Bloc<ContractorPerformanceInsightEvent, ContractorPerformanceInsightState> {
  ContractorPerformanceInsightBloc() : super(const ContractorPerformanceInsightState()) {
    on<ContractorPerformanceInsightEvent>((event, emit) {});
  }
}
