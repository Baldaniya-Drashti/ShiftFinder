import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/presentation/contractor_earning/contractor_wallet_view.dart';

part 'contractor_wallet_event.dart';

part 'contractor_wallet_state.dart';

part 'contractor_wallet_bloc.freezed.dart';

@injectable
class ContractorWalletBloc extends Bloc<ContractorWalletEvent, ContractorWalletState> {
  ContractorWalletBloc() : super(const ContractorWalletState()) {
    on<OnFilterChanged>(_onFilterChanged);
  }

  FutureOr<void> _onFilterChanged(OnFilterChanged event, Emitter<ContractorWalletState> emit) {
    emit(state.copyWith(initialWalletFilter: event.value));
  }
}
