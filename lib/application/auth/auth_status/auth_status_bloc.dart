import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'auth_status_state.dart';
part 'auth_status_event.dart';
part 'auth_status_bloc.freezed.dart';

@injectable
class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  AuthStatusBloc() : super(const AuthStatusState.initial()) {
    on<AuthStatusEvent>(
      (event, emit) async {
        await event.map(
          authCheckRequested: (e) async {},
        );
      },
    );
  }
}
