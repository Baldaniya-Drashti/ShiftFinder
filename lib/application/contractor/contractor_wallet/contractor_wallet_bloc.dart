import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/presentation/contractor_earning/contractor_wallet_view.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';

part 'contractor_wallet_event.dart';

part 'contractor_wallet_state.dart';

part 'contractor_wallet_bloc.freezed.dart';

// @injectable
// class ContractorWalletBloc
//     extends Bloc<ContractorWalletEvent, ContractorWalletState> {
//   ContractorWalletBloc() : super(const ContractorWalletState()) {
//     on<OnFilterChanged>(_onFilterChanged);
//   }
// }

@injectable
class ContractorWalletBloc
    extends Bloc<ContractorWalletEvent, ContractorWalletState> {
  final IMainFacade mainFacade;

  ContractorWalletBloc(this.mainFacade)
      : super(ContractorWalletState.initial()) {
    on<ContractorWalletEvent>((event, emit) async {
      await event.map(
        onFilterChanged: (e) {
          emit(state.copyWith(initialWalletFilter: e.value));
        },
        onDateSelected: (value) {
          emit(state.copyWith(selectedDateTime: value.dates));
          if (value.dates.isNotEmpty) {
            DateTime startDate = value.dates.first;
            DateTime endDate = value.dates.last;
            /* add(ContractorWalletEvent.getMonthlyStatementListEvent(true,
                startDate: startDate, endDate: endDate)); */
          }
        },
      );
    });
  }
}
