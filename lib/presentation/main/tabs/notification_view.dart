import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_notification_bloc/contractor_notification_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/notification_dto/notification_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/helper/notification_naviagtion.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

@RoutePage(name: 'NotificationView')
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<ContractorNotificationBloc>()
          ..add(
              ContractorNotificationEvent.getNotificationList(isRefresh: true)),
        child: BlocBuilder<ContractorNotificationBloc,
            ContractorNotificationState>(
          builder: (context, state) {
            return state.isLoading
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : PaginatedListView(
                    onRefresh: () => context
                        .read<ContractorNotificationBloc>()
                        .add(ContractorNotificationEvent.getNotificationList(
                            isRefresh: true)),
                    onLoading: () => context
                        .read<ContractorNotificationBloc>()
                        .add(ContractorNotificationEvent.getNotificationList(
                            isRefresh: false)),
                    refreshController: context
                        .read<ContractorNotificationBloc>()
                        .refreshController,
                    isNoDataFound: state.noDataFound,
                    child: state.isErrorInApi
                        ? Center(
                            child: BaseText(
                                text: StringConstant.somethindWentWrong))
                        : _NotificationListView(state.notificationList),
                  );
          },
        ));
  }
}

class _NotificationListView extends StatelessWidget {
  final List<NotificationDTO> list;
  const _NotificationListView(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(getSize(16)),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _NotificationTile(obj: list[index]),
      separatorBuilder: (context, index) => Gap(getSize(16)),
      itemCount: list.length,
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationDTO obj;
  const _NotificationTile({required this.obj});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("OnTapNotification----> ${obj.type}");
        setNotificationTab(null);
        setNotificationSubTab(null);

        if (getCurrentRole() == 1) {
          NotificationNaviagtion.contractorNavigateToRespectivePage(context,
              type: obj.type ?? 0, obj: obj);
        } else {
          NotificationNaviagtion.employerNavigateToRespectivePage(context,
              type: obj.type ?? 0, obj: obj);
        }
      },
      child: Material(
        color: AppColors.white,
        child: Padding(
          padding: EdgeInsets.all(getSize(18)),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(PngImageConstants.homeAppBarLogo,
                      height: getSize(35), width: getSize(35)),
                  Gap(getSize(10)),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: BaseText(
                                text: (obj.roles_list_name != null)
                                    ? obj.roles_list_name!
                                    : (obj.full_term_shift_type == 2)
                                        ? (obj.job_type == "1")
                                            ? StringConstant.fullTime
                                            : StringConstant.partTime
                                        : StringConstant.shiftFinder,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                textColor:
                                    AppColors.black.withValues(alpha: 0.7),
                              ),
                            ),
                            BaseText(
                              text: obj.last_ago ?? "",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        ),
                        if (obj.company_name != null) ...[
                          Gap(getSize(4)),
                          BaseText(
                            text: obj.company_name ?? "",
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            textColor: AppColors.green,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              Gap(getSize(10)),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.scaffoldColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(getSize(12)),
                  child: BaseText(
                    text: obj.message ?? "",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
