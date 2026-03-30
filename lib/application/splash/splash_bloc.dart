import 'package:flutter/material.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/core/helper/push_notification_helper.dart';
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
        started: (e) async {
          final authenticated = await _authFacade.checkAuthenticated();
          final showIntro = getUserShowIntro();

          if (showIntro == true || showIntro == null) {
            emit(const SplashState.introScreenVisibilty());
          } else {
            final failureOrSuccess = await _repository.getCurrentUserApi();
            emit(failureOrSuccess.fold(
              (f) {
                final currentUser = getCurrentUser();
                return (authenticated)
                    ? SplashState.authenticated(currentUser.lastPage ?? '',
                        currentUser.isProfileComplete ?? -1)
                    : const SplashState.unAuthenticated('');
              },
              (account) {
                return (account.isVerified == 1)
                    ? SplashState.authenticated(account.lastPage ?? "0",
                        account.isProfileComplete ?? -1)
                    : const SplashState.unAuthenticated('');
              },
            ));
          }
        },
        registerForPush: (RegisterForPush value) async {
          await _authFacade.registerForPush(fcmToken: value.fcmToken);
        },
        pushNotificationInitialize: (PushNotificationInitialize value) async {
          await PushNotificationService().setupInteractedMessage(value.context);
          PushNotificationService()
              .firebaseMessaging
              .onTokenRefresh
              .listen((event) {
            add(SplashEvent.registerForPush(event));
          });
          await PushNotificationService()
              .firebaseMessaging
              .getToken()
              .then((value) async {
            add(SplashEvent.registerForPush(value ?? ""));
          });
        },
        initDynamicLink: (InitDynamicLink value) async {
          add(SplashEvent.pushNotificationInitialize(value.context));
        },
      );
    });
  }
}
