import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'applicant_event.dart';
part 'applicant_state.dart';
part 'applicant_bloc.freezed.dart';

class ApplicantBloc extends Bloc<ApplicantEvent, ApplicantState> {
  ApplicantBloc() : super(const ApplicantState.initial()) {
    on<ApplicantEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
