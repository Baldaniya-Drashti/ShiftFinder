// ignore_for_file: avoid_print

import 'dart:async';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
part 'login_form_bloc.freezed.dart';
part 'login_form_event.dart';
part 'login_form_state.dart';

/// LoginFormBloc manages the user's login flow
@injectable
class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final IAuthFacade _authFacade;

  late Timer timer;
  bool isObscure = false;

  LoginFormBloc(this._authFacade) : super(LoginFormState.initial()) {
    on<LoginFormEvent>(
      (event, emit) async {
        await event.map(
          obscureText: (value) {
            isObscure = !isObscure;
            emit(
              state.copyWith(
                  isObscure: isObscure,
                  authFailureOrSuccessOption: none(),
                  verificationFailureOrSuccessOption: none()),
            );
          },
          emailChanged: (e) {
            print("Email changed click!");
            emit(
              state.copyWith(
                  emailId: EmailAddress(e.emailId),
                  authFailureOrSuccessOption: none(),
                  verificationFailureOrSuccessOption: none()),
            );
          },
          passwordChanged: (e) {
            emit(
              state.copyWith(
                  password: Password(e.password),
                  authFailureOrSuccessOption: none(),
                  verificationFailureOrSuccessOption: none()),
            );
          },

          /// Extra Unused ///
          loginPressed: (e) async {
            print("CURRENT ROLE---> ${getCurrentRole()}");

            Either<AuthFailure, Account>? failureOrSuccess;
            final isMobileNumberValid = state.emailId.isValid();
            final isPasswordValid = state.password.isValid();
            if (isMobileNumberValid && isPasswordValid) {
              print("Email is validdddddd! ");
              emit(
                state.copyWith(
                  isSubmitting: true,
                  authFailureOrSuccessOption: none(),
                  verificationFailureOrSuccessOption: none(),
                ),
              );
              failureOrSuccess = await _authFacade.login(
                email: state.emailId,
                password: state.password,
              );
              // failureOrSuccess = right("success");
            }
            final isUserVerified = await _authFacade.checkUserVerified();
            if (!isUserVerified) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  showErrorMessages: true,
                  verificationFailureOrSuccessOption:
                      optionOf(failureOrSuccess),
                  authFailureOrSuccessOption: none(),
                ),
              );
            } else {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  showErrorMessages: true,
                  authFailureOrSuccessOption: optionOf(failureOrSuccess),
                  verificationFailureOrSuccessOption: none(),
                ),
              );
            }
          },
        );
      },
    );
  }
}
