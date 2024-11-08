import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'faq_event.dart';
part 'faq_state.dart';
part 'faq_bloc.freezed.dart';
@injectable
class FaqBloc extends Bloc<FaqEvent, FaqState> {
  FaqBloc() : super(const FaqState.initial()) {
    on<FaqEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
