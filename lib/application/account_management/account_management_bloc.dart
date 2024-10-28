import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'account_management_event.dart';

part 'account_management_state.dart';

part 'account_management_bloc.freezed.dart';

@injectable
class AccountManagementBloc
    extends Bloc<AccountManagementEvent, AccountManagementState> {
  AccountManagementBloc() : super(const AccountManagementState.initial()) {
    on<AccountManagementEvent>((event, emit) {
      event.map(
        deleteAccount: (value) {},
      );
    });
  }
}
