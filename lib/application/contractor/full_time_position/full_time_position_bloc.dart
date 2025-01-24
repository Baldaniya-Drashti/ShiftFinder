import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';

part 'full_time_position_event.dart';
part 'full_time_position_state.dart';
part 'full_time_position_bloc.freezed.dart';

@injectable
class FullTimePositionBloc extends Bloc<FullTimePositionEvent, FullTimePositionState> {
  FullTimePositionBloc() : super( FullTimePositionState.initial()) {
    on<FullTimePositionEvent>((event, emit) {
    });
  }
}
