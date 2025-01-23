import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'employer_long_term_authorize_payment_event.dart';
part 'employer_long_term_authorize_payment_state.dart';
part 'employer_long_term_authorize_payment_bloc.freezed.dart';

@injectable
class EmployerLongTermAuthorizePaymentBloc extends Bloc<EmployerLongTermAuthorizePaymentEvent, EmployerLongTermAuthorizePaymentState> {
  EmployerLongTermAuthorizePaymentBloc() : super(const EmployerLongTermAuthorizePaymentState.initial()) {
    on<EmployerLongTermAuthorizePaymentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
