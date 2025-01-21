import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employer_long_term_view_applicant_event.dart';

part 'employer_long_term_view_applicant_state.dart';

part 'employer_long_term_view_applicant_bloc.freezed.dart';

class EmployerLongTermViewApplicantBloc extends Bloc<EmployerLongTermViewApplicantEvent, EmployerLongTermViewApplicantState> {
  EmployerLongTermViewApplicantBloc() : super(EmployerLongTermViewApplicantState.initial()) {
    on<EmployerLongTermViewApplicantEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
