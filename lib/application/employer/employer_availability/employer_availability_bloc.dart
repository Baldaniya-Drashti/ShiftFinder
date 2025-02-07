import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'employer_availability_event.dart';
part 'employer_availability_state.dart';
part 'employer_availability_bloc.freezed.dart';

class EmployerAvailabilityBloc
    extends Bloc<EmployerAvailabilityEvent, EmployerAvailabilityState> {
  EmployerAvailabilityBloc()
      : super(const EmployerAvailabilityState.initial()) {
    on<EmployerAvailabilityEvent>((event, emit) {});
  }
}
