import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
part 'contractor_main_state.dart';
part 'contractor_main_event.dart';
part 'contractor_main_bloc.freezed.dart';

@injectable
class ContractorMainTabBloc
    extends Bloc<ContractorMainTabEvent, ContractorMainTabState> {
  final List<String> pageList = [];
  final IAuthFacade authFacade;
  // final IAccountRepository accountRepository;

  ContractorMainTabBloc(
    this.authFacade,
    // this.accountRepository,
  ) : super(ContractorMainTabState.initial()) {
    on<ContractorMainTabEvent>(
      (event, emit) async {
        await event.map(
          tabChange: (value) async {
            emit(state.copyWith(selectedTab: value.tabIndex));

            switch (value.tabIndex) {
              case 0:
                if (!pageList.contains(state.homePage)) {
                  pageList.add(state.homePage);
                }
                emit(state.copyWith(
                    pageIndex: pageList.indexOf(state.homePage)));
                break;
              case 1:
                if (!pageList.contains(state.shiftPage)) {
                  pageList.add(state.shiftPage);
                }
                emit(state.copyWith(
                    pageIndex: pageList.indexOf(state.shiftPage)));
                break;
              case 2:
                if (!pageList.contains(state.notificationPage)) {
                  pageList.add(state.notificationPage);
                }
                emit(state.copyWith(
                    pageIndex: pageList.indexOf(state.notificationPage)));
                break;
              case 3:
                if (!pageList.contains(state.profilePage)) {
                  pageList.add(state.profilePage);
                }
                emit(state.copyWith(
                    pageIndex: pageList.indexOf(state.profilePage)));
                break;
              default:
            }
          },
        );
      },
    );
  }
}
