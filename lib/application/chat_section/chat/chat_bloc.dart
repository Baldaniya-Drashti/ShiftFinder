import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/chat/chat_response.dart';
part 'chat_state.dart';
part 'chat_event.dart';
part 'chat_bloc.freezed.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  int page = 1;
  int lastPage = 1;
  final RefreshController refreshController = RefreshController();
  final IMainFacade mainFacade;
  ChatBloc(
    this.mainFacade,
  ) : super(ChatState.initial()) {
    on<ChatEvent>(
      (event, emit) async {
        await event.map(
          getChatList: (e) async {
            if (e.isRefresh) {
              page = 1;
              emit(
                state.copyWith(
                  chatList: [],
                  isLoading: e.isRefresh,
                ),
              );
              refreshController.resetNoData();
            } else {
              if (page > lastPage) {
                refreshController.loadNoData();
                return;
              }
            }
            var res = await mainFacade.chatListApi(
              page: page,
            );
            page++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  isLoading: false,
                  chatList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (e.isRefresh) {
                  List.from(state.chatList).clear();
                }
                return emit(
                  state.copyWith(
                    isLoading: false,
                    chatList: r.listData as List<ChatUser>,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
