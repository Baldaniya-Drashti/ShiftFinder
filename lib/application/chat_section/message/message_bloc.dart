import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/chat/message_response.dart';
import 'package:shift/infrastructure/core/chat/socket_chat_service.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
part 'message_state.dart';
part 'message_event.dart';
part 'message_bloc.freezed.dart';

@injectable
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  int page = 1;
  int lastPage = 1;
  final RefreshController refreshController = RefreshController();
  final IMainFacade mainFacade;
  final SocketChatService chatService;
  MessageBloc(
    this.mainFacade,
    this.chatService,
  ) : super(MessageState.initial()) {
    on<MessageEvent>((event, emit) async {
      await event.map(
        createRoom: (_CreateRoom value) {
          chatService.createRoom(value.sender, value.receiver);
        },
        connectSocket: (_ConnectSocket value) async {
          chatService.connectToSocket();
          await emit.forEach(
            chatService.socketConnectStream,
            onData: (data) {
              add(
                MessageEvent.createRoom(
                  state.senderId.toString(),
                  state.receiverId.toString(),
                ),
              );
              add(MessageEvent.getMessageList(true));
              add(MessageEvent.receiveMessage());
              return state.copyWith(isLoading: false);
            },
          );
        },
        getReceiverId: (value) {
          emit(
            state.copyWith(
              receiverId: value.id,
              senderId: getCurrentUser().userId ?? 0,
            ),
          );
          add(
            const MessageEvent.connectSocket(),
          );
        },
        getMessageList: (e) async {
          if (e.isRefresh) {
            page = 1;
            emit(
              state.copyWith(
                messageList: [],
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
          var res = await mainFacade.getMessage(
            page: page,
            id: state.receiverId,
          );

          page++;
          res.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                messageList: [],
              ),
            ),
            (r) {
              CommonResponse res = r['listData'];
              lastPage = res.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.messageList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  messageList: List<MessageData>.from(state.messageList)
                    ..addAll(
                      res.listData as List<MessageData>,
                    ),
                ),
              );
            },
          );
        },
        receiveMessage: (_ReceiveMessage value) async {
          await emit.forEach(chatService.newMessageStream, onData: (data) {
            var updatedList = List<MessageData>.from(state.messageList);
            updatedList.insert(0, data);
            return state.copyWith(messageList: updatedList);
          });
          /* final data = await chatService.receiveMessage();
          var updatedList = List<MessageData>.from(state.messageList);
          print("Chat Received message---> $data");
          if (data != null) {
            updatedList.insert(0, data);
            return state.copyWith(messageList: updatedList);
          } */
        },
        sendMessage: (_SendMessage value) {
          log('Date : ${DateTime.now().millisecondsSinceEpoch}');
          var message = MessageData(
            senderId: state.senderId,
            receiverId: state.receiverId,
            message: state.messageController.text.trim(),
            type: 1,
            createdAt: DateTime.now().millisecondsSinceEpoch - 5,
          );
          chatService.sendMessage(message).then((data) {
            var updatedList = List<MessageData>.from(state.messageList);
            updatedList.insert(0, message);
            emit(state.copyWith(
              messageList: updatedList,
              message: '',
              messageController: state.messageController..clear(),
            ));
          });
        },
        messageChanged: (_MessageChanged value) {
          emit(state.copyWith(message: value.message));
        },
      );
    });
  }
}
