import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/domain/account/account.dart';

part 'applicant_profile_event.dart';

part 'applicant_profile_state.dart';

part 'applicant_profile_bloc.freezed.dart';

class ApplicantProfileBloc extends Bloc<ApplicantProfileEvent, ApplicantProfileState> {
  ApplicantProfileBloc() : super(ApplicantProfileState.initial()) {
    on<ApplicantProfileEvent>((event, emit) {
      event.map(
        fetchApplicantProfile: (value) {

        },
      );
    });
  }
}
