// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:intl/intl.dart';
// import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_notification_bloc/contractor_notification_bloc.dart';
// import 'package:shift/domain/core/math_utils.dart';
// import 'package:shift/domain/core/png_image_constants.dart';
// import 'package:shift/domain/core/string_constant.dart';
// import 'package:shift/infrastructure/core/notification_dto/notification_dto.dart';
// import 'package:shift/injection.dart';
// import 'package:shift/presentation/common/utils/get_cookie.dart';
// import 'package:shift/presentation/common/widgets/base_text.dart';
// import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
// import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
// import 'package:shift/presentation/core/style/app_colors.dart';

// @RoutePage(name: 'ContractorNotificationView')
// class ContractorNotificationView extends StatefulWidget {
//   const ContractorNotificationView({super.key});

//   @override
//   State<ContractorNotificationView> createState() =>
//       _ContractorNotificationViewState();
// }

// class _ContractorNotificationViewState
//     extends State<ContractorNotificationView> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => getIt<ContractorNotificationBloc>()
//           ..add(
//               ContractorNotificationEvent.getNotificationList(isRefresh: true)),
//         child: BlocBuilder<ContractorNotificationBloc,
//             ContractorNotificationState>(
//           builder: (context, state) {
//             return state.isLoading
//                 ? CenterLoadingIndicator(isOnlyLoader: true)
//                 : PaginatedListView(
//                     onRefresh: () => context
//                         .read<ContractorNotificationBloc>()
//                         .add(ContractorNotificationEvent.getNotificationList(
//                             isRefresh: true)),
//                     onLoading: () => context
//                         .read<ContractorNotificationBloc>()
//                         .add(ContractorNotificationEvent.getNotificationList(
//                             isRefresh: false)),
//                     refreshController: context
//                         .read<ContractorNotificationBloc>()
//                         .refreshController,
//                     isNoDataFound: state.noDataFound,
//                     child: state.isErrorInApi
//                         ? Center(
//                             child: BaseText(
//                                 text: StringConstant.somethindWentWrong))
//                         : _NotificationListView(state.notificationList),
//                   );
//           },
//         ));
//   }
// }

// class _NotificationListView extends StatelessWidget {
//   final List<NotificationDTO> list;
//   _NotificationListView(this.list);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: EdgeInsets.all(getSize(16)),
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) => _NotificationTile(obj: list[index]),
//       separatorBuilder: (context, index) => Gap(getSize(16)),
//       itemCount: list.length,
//     );
//   }
// }

// class _NotificationTile extends StatelessWidget {
//   NotificationDTO obj;
//   _NotificationTile({required this.obj});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: AppColors.white,
//       child: Padding(
//         padding: EdgeInsets.all(getSize(18)),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Image.asset(PngImageConstants.homeAppBarLogo,
//                     height: getSize(35), width: getSize(35)),
//                 Gap(getSize(10)),
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: BaseText(
//                               text: obj.roles_list_name ?? "",
//                               fontWeight: FontWeight.w600,
//                               fontSize: 10,
//                               textColor: AppColors.black.withOpacity(0.7),
//                             ),
//                           ),
//                           BaseText(
//                             text: (getCurrentRole() == 2)
//                                 ? "Just now"
//                                 : DateFormat('dd MMM yyyy').format(
//                                     DateTime.fromMillisecondsSinceEpoch(
//                                         -1 * 1000)),
//                             fontSize: 10,
//                             fontWeight: FontWeight.w600,
//                           )
//                         ],
//                       ),
//                       Gap(getSize(4)),
//                       BaseText(
//                         text: (obj.type == 3 && getCurrentRole() == 2)
//                             ? "Distance: ${obj.distance ?? ""}"
//                             : "Louis Vuitton Pvt. Ltd.",
//                         fontWeight: FontWeight.w600,
//                         fontSize: 10,
//                         textColor: AppColors.green,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Gap(getSize(10)),
//             Container(
//               alignment: Alignment.centerLeft,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 color: AppColors.scaffoldColor,
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(getSize(12)),
//                 child: BaseText(
//                   text: obj.message ?? "",
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
