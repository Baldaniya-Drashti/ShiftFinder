import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'full_time_position_event.dart';
part 'full_time_position_state.dart';
part 'full_time_position_bloc.freezed.dart';

@injectable
class FullTimePositionBloc extends Bloc<FullTimePositionEvent, FullTimePositionState> {
  FullTimePositionBloc() : super( FullTimePositionState()) {
    on<FullTimePositionEvent>((event, emit) {
    });
  }
}
