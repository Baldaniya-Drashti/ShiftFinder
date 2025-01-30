import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/notification_dto/notification_dto.dart';

part 'contractor_notification_event.dart';
part 'contractor_notification_state.dart';
part 'contractor_notification_bloc.freezed.dart';

@injectable
class ContractorNotificationBloc
    extends Bloc<ContractorNotificationEvent, ContractorNotificationState> {
  final IMainFacade mainFacade;

  int currentPage = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();
  ContractorNotificationBloc(
    this.mainFacade,
  ) : super(ContractorNotificationState.initial()) {
    on<ContractorNotificationEvent>((event, emit) async {
      await event.map(
        getNotificationList: (e) async {
          if (e.isRefresh) {
            currentPage = 1;
            emit(state.copyWith(
              notificationList: [],
              isLoading: e.isRefresh,
            ));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.getNotificationAPI(
            page: currentPage,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInApi: true,
                isLoading: false,
                notificationList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.notificationList).clear();
              }

              emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInApi: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => NotificationDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  notificationList: List.from(state.notificationList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => NotificationDTO.fromJson(e))
                        .toList()),
                ),
              );
            },
          );
        },
      );
    });
  }
}
