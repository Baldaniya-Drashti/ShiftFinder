part of 'notification_bloc.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(false)bool loading,
    @Default(false)bool error,
    @Default(false)bool noDataFound,
}) = _NotificationState;
}
