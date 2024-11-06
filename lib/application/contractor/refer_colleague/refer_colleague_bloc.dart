import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'refer_colleague_event.dart';
part 'refer_colleague_state.dart';
part 'refer_colleague_bloc.freezed.dart';

@injectable
class ReferColleagueBloc extends Bloc<ReferColleagueEvent, ReferColleagueState> {
  ReferColleagueBloc() : super(const ReferColleagueState()) {
    on<ReferColleagueEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
