part of 'splash_bloc.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.authenticated(String lastPage) = _Authenticated;
  const factory SplashState.unAuthenticated(String e) = _UnAuthenticated;
  const factory SplashState.introScreenVisibilty() = IntroScreenVisibilty;
}
