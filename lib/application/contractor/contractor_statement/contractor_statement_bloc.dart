import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/presentation/contractor_earning/contractor_statement_view.dart';

part 'contractor_statement_event.dart';

part 'contractor_statement_state.dart';

part 'contractor_statement_bloc.freezed.dart';

@injectable
class ContractorStatementBloc extends Bloc<ContractorStatementEvent, ContractorStatementState> {
  ContractorStatementBloc() : super(const ContractorStatementState()) {
    on<ContractorStatementEvent>(
      (event, emit) {
        event.map(
          onFilterChanged: (value) {
            emit(state.copyWith(currentStatementFilter: value.value));
          },
          onSelectDateRange: (value) {
            emit(state.copyWith(selectedDates: value.value));
          },
        );
      },
    );
  }
}
