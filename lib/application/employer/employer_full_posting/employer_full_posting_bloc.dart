import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'employer_full_posting_event.dart';
part 'employer_full_posting_state.dart';
part 'employer_full_posting_bloc.freezed.dart';
@injectable
class EmployerFullPostingBloc extends Bloc<EmployerFullPostingEvent, EmployerFullPostingState> {
  EmployerFullPostingBloc() : super(const EmployerFullPostingState.initial()) {
    on<EmployerFullPostingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
