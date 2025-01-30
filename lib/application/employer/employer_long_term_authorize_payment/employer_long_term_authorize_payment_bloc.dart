import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'employer_long_term_authorize_payment_event.dart';

part 'employer_long_term_authorize_payment_state.dart';

part 'employer_long_term_authorize_payment_bloc.freezed.dart';

@injectable
class EmployerLongTermAuthorizePaymentBloc
    extends Bloc<EmployerLongTermAuthorizePaymentEvent, EmployerLongTermAuthorizePaymentState> {
  final IMainFacade _iMainFacade;

  EmployerLongTermAuthorizePaymentBloc(this._iMainFacade) : super(const EmployerLongTermAuthorizePaymentState()) {
    on<EmployerLongTermAuthorizePaymentEvent>((event, emit) async {
      await event.map(
        onAuthorizePayment: (value) async {
          emit(state.copyWith(postDataLoading: true));
          final response = await _iMainFacade.employerApplicantsAccept(id: event.id);
          emit(state.copyWith(postDataLoading: false));
          response.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) => 'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) {
              showSuccess(message: r.dioMessage ?? "").show(value.context).then(
                (_) {
                  value.context.router.maybePop(true);
                },
              );
            },
          );
        },
      );
    });
  }
}
