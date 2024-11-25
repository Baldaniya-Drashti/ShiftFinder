import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'employer_postion_event.dart';
part 'employer_postion_state.dart';
part 'employer_postion_bloc.freezed.dart';
@injectable
class EmployerPostionBloc extends Bloc<EmployerPostionEvent, EmployerPostionState> {
  EmployerPostionBloc() : super(const EmployerPostionState.initial()) {
    on<EmployerPostionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
