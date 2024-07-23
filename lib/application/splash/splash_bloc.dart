import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final IAuthFacade _authFacade;
  final IAccountRepository _repository;

  SplashBloc(this._authFacade, this._repository)
      : super(const SplashState.initial()) {
    on<SplashEvent>((event, emit) async {
      await event.map(
        getAccount: (e) async {
          final failureOrSuccess = await _repository.getCurrentUserApi();
          emit(
            failureOrSuccess.fold(
              (f) => const SplashState.unAuthenticated(''),
              (account) {
                return SplashState.authenticated(account.lastPage ?? "0");
              },
            ),
          );
        },
        started: (e) async {
          final authenticated = await _authFacade.checkAuthenticated();
          final showIntro = getUserShowIntro();
          if (showIntro == true || showIntro == null) {
            emit(const SplashState.introScreenVisibilty());
          } else {
            final failureOrSuccess = await _repository.getCurrentUserApi();
            emit(
              failureOrSuccess.fold(
                (f) {
                  // return SplashState.unAuthenticated('');
                  return (authenticated)
                      ? const SplashState.authenticated('')
                      : const SplashState.unAuthenticated('');
                },
                (account) {
                  return (account.isVerified == 1)
                      ? SplashState.authenticated(account.lastPage ?? "0")
                      : const SplashState.unAuthenticated('');
                },
              ),
            );
          }
        },
      );
    });
  }
}
