import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employer_about_event.dart';
part 'employer_about_state.dart';
part 'employer_about_bloc.freezed.dart';

class EmployerAboutBloc extends Bloc<EmployerAboutEvent, EmployerAboutState> {
  EmployerAboutBloc() : super(EmployerAboutState.initial()) {
    on<EmployerAboutEvent>((event, emit) {
      event.map(toggleExpansionEvent: (e) {
        final updatedStates = List<bool>.from(state.expandedStates);

        // Ensure the list size is sufficient for the requested index
        if (event.index >= updatedStates.length) {
          updatedStates.addAll(List.generate(
              event.index - updatedStates.length + 1, (_) => false));
        }

        // Toggle the expansion state for the given index
        updatedStates[event.index] = !updatedStates[event.index];
        emit(state.copyWith(expandedStates: updatedStates));
      });
    });
  }
}
