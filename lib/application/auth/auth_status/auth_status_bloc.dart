import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
part 'auth_status_state.dart';
part 'auth_status_event.dart';
part 'auth_status_bloc.freezed.dart';

@injectable
class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final IAuthFacade _authFacade;

  AuthStatusBloc(this._authFacade) : super(const AuthStatusState.initial()) {
    on<AuthStatusEvent>(
      (event, emit) async {
        await event.map(
          authCheckRequested: (e) async {},
          signedOut: (SignedOut value) async {
            Either<AuthFailure, String> res;
            if (value.isDeleteAccount) {
              res = await _authFacade.deleteAccount();
            } else {
              res = await _authFacade.logout();
            }
            res.fold((l) => null, (r) {
              emit(AuthStatusState.initial());
              emit(AuthStatusState.unauthenticated(r,
                  isDeleteAccount: value.isDeleteAccount));
            });
          },
        );
      },
    );
  }
}
