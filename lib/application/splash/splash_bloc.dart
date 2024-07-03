import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final IAuthFacade _authFacade;
  SplashBloc(this._authFacade) : super(const SplashState.initial()) {
    on<SplashEvent>((event, emit) async {
      // event.map(started: (value) {
      //   emit(state);
      // });

      await event.map(
        started: (e) async {
          final authenticated = await _authFacade.checkAuthenticated();
          emit(
            authenticated
                ? const SplashState.authenticated()
                : const SplashState.unAuthenticated(''),
          );
        },
      );
    });
  }
}
