import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';

part 'terms_and_condition_event.dart';
part 'terms_and_condition_state.dart';
part 'terms_and_condition_bloc.freezed.dart';

@injectable
class TermsAndConditionBloc
    extends Bloc<TermsAndConditionEvent, TermsAndConditionState> {
  final IAuthFacade _authFacade;

  TermsAndConditionBloc(this._authFacade)
      : super(TermsAndConditionState.initial()) {
    on<TermsAndConditionEvent>((event, emit) async {
      await event.map(
        submitTerms: (e) async {
          Either<AuthFailure, Account>? failureOrSuccess;

          emit(
            state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ),
          );

          failureOrSuccess = await _authFacade.addLastPageApi(
            lastPage: "IntroVideo",
          );

          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isSubmitting: false,
              ),
            ),
            (r) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  showErrorMessages: false,
                ),
              );
            },
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
