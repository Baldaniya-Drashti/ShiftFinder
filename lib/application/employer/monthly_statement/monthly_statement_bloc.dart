import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'monthly_statement_event.dart';

part 'monthly_statement_state.dart';

part 'monthly_statement_bloc.freezed.dart';

@injectable
class MonthlyStatementBloc extends Bloc<MonthlyStatementEvent, MonthlyStatementState> {
  MonthlyStatementBloc() : super(const MonthlyStatementState()) {
    on<MonthlyStatementEvent>((event, emit) async {
      await event.map(
        onDateSelected: (value) {
          emit(state.copyWith(selectedDateTime: value.dates));
        },
      );
    });
  }
}
