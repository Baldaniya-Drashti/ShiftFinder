import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'full_time_position_detail_event.dart';
part 'full_time_position_detail_state.dart';
part 'full_time_position_detail_bloc.freezed.dart';

@injectable
class FullTimePositionDetailBloc
    extends Bloc<FullTimePositionDetailEvent, FullTimePositionDetailState> {
  FullTimePositionDetailBloc()
      : super(const FullTimePositionDetailState.initial()) {
    on<FullTimePositionDetailEvent>((event, emit) {});
  }
}
