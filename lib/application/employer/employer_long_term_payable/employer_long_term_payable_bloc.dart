import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/auth/contractor_auth/address_proof/address_proof_bloc.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

part 'employer_long_term_payable_event.dart';

part 'employer_long_term_payable_state.dart';

part 'employer_long_term_payable_bloc.freezed.dart';

@injectable
class EmployerLongTermPayableBloc extends Bloc<EmployerLongTermPayableEvent, EmployerLongTermPayableState> {
  final IMainFacade _iMainFacade;

  EmployerLongTermPayableBloc(this._iMainFacade) : super(EmployerLongTermPayableState.initial()) {
    on<EmployerLongTermPayableEvent>((event, emit) async {
      await event.map(
        onPostShift: (value) async {
          emit(state.copyWith(postDataLoading: true));
          final response = await _iMainFacade.updateLongTermStatus(id: value.id);
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
              AppDialog.showSuccess(
                value.context,
                title: "All Set!",
                infoMessage:
                    "Your healthcare long term position has been successfully posted, with a total of ${value.totalVacancy} vacancy.",
                onOkClick: () {
                  value.context.router.popUntil((route) => route.isFirst);
                },
              );
            },
          );
        },
      );
    });
  }
}
