import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_main_bloc.dart';
import 'package:shift/application/main_tab/main_tab_bloc.dart';
import 'package:shift/infrastructure/core/notification_dto/notification_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/core/app_router.dart';
import 'package:shift/presentation/core/app_router.gr.dart';

class NotificationNaviagtion {
  static contractorNavigateToRespectivePage(BuildContext context,
      {required int type}) {
    switch (type) {
      case 2:
        break;
      case 3:
        break;
      case 4:
        setNotificationTab(3);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 5:
        setNotificationTab(3);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;

      /// Apply or Send proposal
      case 6:
        setNotificationTab(3);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 7:
        setNotificationTab(3);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 8:
        setNotificationTab(2);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 9:
        setNotificationTab(3);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 10:
        setNotificationTab(3);
        setNotificationSubTab(1);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 11:
        setNotificationTab(2);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 12:
        setNotificationTab(3);
        setNotificationSubTab(1);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 13:
        setNotificationTab(3);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 14:
        setNotificationTab(3);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 15:
        setNotificationTab(3);
        setNotificationSubTab(1);
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(1));
        break;
      case 16:
        getIt<AppRouter>().push(PageRouteInfo(ContractorLongTermView.name));
        break;
      case 17:
        setNotificationTab(2);
        getIt<AppRouter>().push(PageRouteInfo(ContractorLongTermView.name));
        break;
      case 18:
        setNotificationTab(2);
        getIt<AppRouter>().push(PageRouteInfo(ContractorLongTermView.name));
        break;
      case 19:
        setNotificationTab(1);
        getIt<AppRouter>().push(PageRouteInfo(ContractorLongTermView.name));
        break;
      case 20:
        setNotificationTab(2);
        getIt<AppRouter>().push(PageRouteInfo(ContractorLongTermView.name));
        break;
      case 21:
        getIt<AppRouter>()
            .push(PageRouteInfo(ContractorFullTimePositionView.name));
        break;
      case 22:
        getIt<AppRouter>()
            .push(PageRouteInfo(ContractorFullTimePositionView.name));
        break;
      case 23:
        setNotificationTab(1);
        getIt<AppRouter>()
            .push(PageRouteInfo(ContractorFullTimePositionView.name));
        break;
      default:
        context
            .read<ContractorMainTabBloc>()
            .add(ContractorMainTabEvent.tabChange(2));
        break;
    }
  }

  static employerNavigateToRespectivePage(BuildContext context,
      {required int type, required NotificationDTO obj}) async {
    switch (type) {
      case 2:
        await getIt<AppRouter>().push(
          PageRouteInfo(ViewHomeShiftDetails.name,
              args: ViewHomeShiftDetailsArgs(postId: obj.post_id ?? -1)),
        );
        break;
      case 3:
        break;
      case 4:
        await getIt<AppRouter>().push(PageRouteInfo(ViewSingleApplicants.name,
            args: ViewSingleApplicantsArgs(postId: obj.post_id ?? -1)));
        break;
      case 5:
        getIt<AppRouter>().push(PageRouteInfo(TotalPraposalView.name,
            args: TotalPraposalViewArgs(postId: obj.post_id ?? -1)));
        break;
      case 6:
        await getIt<AppRouter>().push(PageRouteInfo(ViewSingleApplicants.name,
            args: ViewSingleApplicantsArgs(postId: obj.post_id ?? -1)));
        break;
      case 7:
        getIt<AppRouter>().push(PageRouteInfo(TotalPraposalView.name,
            args: TotalPraposalViewArgs(postId: obj.post_id ?? -1)));
        break;
      case 8:
        context.read<MainTabBloc>().add(MainTabEvent.tabChange(1));
        break;
      case 9:
        await getIt<AppRouter>().push(PageRouteInfo(ViewSingleApplicants.name,
            args: ViewSingleApplicantsArgs(postId: obj.post_id ?? -1)));
        break;
      case 10:
        getIt<AppRouter>().push(PageRouteInfo(TotalPraposalView.name,
            args: TotalPraposalViewArgs(postId: obj.post_id ?? -1)));
        break;
      case 11:
        context.read<MainTabBloc>().add(MainTabEvent.tabChange(1));
        break;
      case 12:
        getIt<AppRouter>().push(PageRouteInfo(TotalPraposalView.name,
            args: TotalPraposalViewArgs(postId: obj.post_id ?? -1)));
        break;
      case 13:
        await getIt<AppRouter>().push(PageRouteInfo(ViewSingleApplicants.name,
            args: ViewSingleApplicantsArgs(postId: obj.post_id ?? -1)));
        break;
      case 14:
        getIt<AppRouter>().push(PageRouteInfo(TotalPraposalView.name,
            args: TotalPraposalViewArgs(postId: obj.post_id ?? -1)));
        break;
      case 15:
        getIt<AppRouter>().push(PageRouteInfo(TotalPraposalView.name,
            args: TotalPraposalViewArgs(postId: obj.post_id ?? -1)));
        break;
      case 16:
        getIt<AppRouter>().push(PageRouteInfo(EmployerLongTermView.name));
        break;
      case 17:
        getIt<AppRouter>().push(
          PageRouteInfo(
            EmployerLongTermApplicantView.name,
            args: EmployerLongTermApplicantViewArgs(
                id: obj.full_term_shift_id ?? -1),
          ),
        );
        break;
      case 18:
        getIt<AppRouter>().push(
          PageRouteInfo(
            EmployerLongTermApplicantView.name,
            args: EmployerLongTermApplicantViewArgs(
                id: obj.full_term_shift_id ?? -1),
          ),
        );
        break;
      case 19:
        setNotificationTab(1);
        getIt<AppRouter>().push(PageRouteInfo(EmployerLongTermView.name));
        break;
      case 20:
        getIt<AppRouter>().push(PageRouteInfo(EmployerLongTermView.name));
        break;
      /* getIt<AppRouter>().push(
          PageRouteInfo(
            EmployerLongTermApplicantView.name,
            args: EmployerLongTermApplicantViewArgs(
                id: obj.full_term_shift_id ?? -1),
          ),
        );
        break; */
      case 21:
        getIt<AppRouter>().push(PageRouteInfo(EmployerFullPostingView.name));
        break;
      case 22:
        context.router.push(
          PageRouteInfo(EmployerFullPositionApplicantsView.name,
              args: EmployerFullPositionApplicantsViewArgs(
                  id: obj.full_term_shift_id ?? -1)),
        );
        break;
      case 23:
        getIt<AppRouter>().push(PageRouteInfo(EmployerFullPostingView.name));
        break;
      default:
        context.read<MainTabBloc>().add(MainTabEvent.tabChange(2));
        break;
    }
  }
}
