part of 'message_bloc.dart';

@freezed
class MessageEvent with _$MessageEvent {
  const factory MessageEvent.getMessageList(bool isRefresh) = _GetMessage;
  const factory MessageEvent.getReceiverId(int id) = _GetReceiverId;
  const factory MessageEvent.connectSocket() = _ConnectSocket;
  const factory MessageEvent.disConnectSocket() = _DisConnectSocket;
  const factory MessageEvent.createRoom(String sender, String receiver) =
      _CreateRoom;

  const factory MessageEvent.receiveMessage() = _ReceiveMessage;
  const factory MessageEvent.sendMessage() = _SendMessage;
  const factory MessageEvent.messageChanged(String message) = _MessageChanged;

  const factory MessageEvent.getDocumentLink(
    String path,
    int type,
    String mediaName,
  ) = _GetDocumentLink;
}
