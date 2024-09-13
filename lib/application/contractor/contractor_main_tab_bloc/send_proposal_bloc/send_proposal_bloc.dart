import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'send_proposal_event.dart';
part 'send_proposal_state.dart';
part 'send_proposal_bloc.freezed.dart';

@injectable
class SendProposalBloc extends Bloc<SendProposalEvent, SendProposalState> {
  SendProposalBloc() : super(SendProposalState.initial()) {
    on<SendProposalEvent>(
      (event, emit) async {
        await event.map(
          tabChangeEvent: (value) async {
            emit(state.copyWith(selectedTab: value.tabIndex));
          },
        );
      },
    );
  }
}
