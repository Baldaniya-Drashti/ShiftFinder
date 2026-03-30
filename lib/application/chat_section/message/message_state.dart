part of 'message_bloc.dart';

@freezed
class MessageState with _$MessageState {
  const factory MessageState({
    required bool isLoading,
    required int receiverId,
    required int senderId,
    required List<MessageData> messageList,
    required TextEditingController messageController,
    required String message,
    required AdditionalDataDto additional_data,
  }) = _MessageState;

  factory MessageState.initial() => MessageState(
        isLoading: true,
        receiverId: 0,
        senderId: 0,
        messageList: <MessageData>[],
        messageController: TextEditingController(),
        message: '',
        additional_data: AdditionalDataDto(),
      );
}
