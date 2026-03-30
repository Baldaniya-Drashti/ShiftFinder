part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    required bool isLoading,
    required List<ChatUser> chatList,
  }) = _ChatState;
  factory ChatState.initial() => ChatState(
        isLoading: false,
        chatList: <ChatUser>[],
      );
}
