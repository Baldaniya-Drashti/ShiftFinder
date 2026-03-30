import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';
part 'change_password_bloc.freezed.dart';

@injectable
class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final IAuthFacade _authFacade;

  ChangePasswordBloc(this._authFacade) : super(ChangePasswordState.initial()) {
    on<ChangePasswordEvent>((event, emit) async {
      await event.map(
        changePassword: (value) async {
          Either<MainFailure, String>? failureOrSuccess;
          emit(state.copyWith(postDataLoading: true));
          failureOrSuccess = await _authFacade.changePassword(
            confirmNewPassword: value.confirmPassword,
            newPassword: value.password,
            oldPassword: value.oldPassword,
          );
          emit(state.copyWith(postDataLoading: false));

          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) async {
              final result = await AppDialog.showSuccess(
                title: "Password Updated!",
                image: Image.asset(PngImageConstants.passwordChanged),
                value.context,
                infoMessage: "Your password has been updated successfully.",
              );
              if (result ?? false) {
                value.context.router.maybePop();
              }
            },
          );
        },
      );
    });
  }
}
