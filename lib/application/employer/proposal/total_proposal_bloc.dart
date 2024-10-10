import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/total_proposal_dto/total_proposal_dto.dart';

part 'total_proposal_event.dart';

part 'total_proposal_state.dart';

part 'total_proposal_bloc.freezed.dart';

class TotalProposalBloc extends Bloc<TotalProposalEvent, TotalProposalState> {
  final IMainFacade _mainFacade;
  final RefreshController refreshController = RefreshController();
  int page = 1;
  int lastPage = 1;

  TotalProposalBloc(this._mainFacade) : super(TotalProposalState.initial()) {
    on<TotalProposalEvent>(
      (event, emit) async {
        event.map(
          getTotalProposalList: (value) async {
            final response = await _mainFacade.getEmployerTotalProposal(postId: value.id, page: page);

            // _mainFacade.getEmployerTotalProposal(postId: value, page: page)
          },
        );
      },
    );
  }
}
