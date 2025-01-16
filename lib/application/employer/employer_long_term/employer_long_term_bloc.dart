import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'employer_long_term_event.dart';

part 'employer_long_term_state.dart';

part 'employer_long_term_bloc.freezed.dart';

@injectable
class EmployerLongTermBloc extends Bloc<EmployerLongTermEvent, EmployerLongTermState> {
  EmployerLongTermBloc() : super(EmployerLongTermState.initial()) {
    on<EmployerLongTermEvent>((event, emit) {

    });
  }
}
