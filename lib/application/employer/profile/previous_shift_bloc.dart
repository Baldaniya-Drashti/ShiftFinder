import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'previous_shift_event.dart';

part 'previous_shift_state.dart';

part 'previous_shift_bloc.freezed.dart';

@injectable
class PreviousShiftBloc extends Bloc<PreviousShiftEvent, PreviousShiftState> {
  final List<String> pageList = [];

  PreviousShiftBloc() : super(PreviousShiftState.initial()) {
    on<PreviousShiftEvent>(
      (event, emit) async {
        event.map(
          tabChange: (value) {
            emit(state.copyWith(selectedTab: value.tabIndex));
          },
        );
      },
    );
  }
}
