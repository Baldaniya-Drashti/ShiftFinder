// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/shifts/hired_contractor_bloc/hired_contractor_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'CancelledContractorList')
class CancelledContractorList extends StatelessWidget {
  int cancelFilter;
  String title;
  int postId;
  CancelledContractorList(
      {required this.title, required this.postId, required this.cancelFilter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HiredContractorBloc>()
        ..add(HiredContractorEvent.getHiredCancelledContractorList(
            refresh: true, postId: postId, shortType: cancelFilter)),
      child: BlocBuilder<HiredContractorBloc, HiredContractorState>(
        builder: (context, state) {
          return Scaffold(
              appBar: CommonAppBar(
                onBackPressed: () {
                  context.router.maybePop();
                },
                title: title,
              ),
              body: state.isLoading
                  ? CenterLoadingIndicator(isOnlyLoader: true)
                  : state.errorApi
                      ? Center(
                          child:
                              BaseText(text: StringConstant.somethindWentWrong))
                      : PaginatedListView(
                          onRefresh: () => context
                              .read<HiredContractorBloc>()
                              .add(HiredContractorEvent
                                  .getHiredCancelledContractorList(
                                      refresh: true,
                                      postId: postId,
                                      shortType: cancelFilter)),
                          onLoading: () => context
                              .read<HiredContractorBloc>()
                              .add(HiredContractorEvent
                                  .getHiredCancelledContractorList(
                                      refresh: false,
                                      postId: postId,
                                      shortType: cancelFilter)),
                          refreshController: context
                              .read<HiredContractorBloc>()
                              .hiredContractorListController,
                          child: ListView.builder(
                              padding:
                                  EdgeInsets.symmetric(vertical: getSize(10)),
                              itemCount:
                                  state.hiredCancelledContractorList.length,
                              itemBuilder: (context, index) {
                                return contractorDetail(context,
                                    state.hiredCancelledContractorList[index]);
                              }),
                        ));
        },
      ),
    );
  }

  Widget contractorDetail(
      BuildContext context, HiredContractorListDTO contractor) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: getSize(8), horizontal: getSize(20)),
      padding: EdgeInsets.all(getSize(5)),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(getSize(10)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: AppColors.grey,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              context.router.push(
                PageRouteInfo(ViewApplicantProfile.name,
                    args: ViewApplicantProfileArgs(
                      id: contractor.user_id ?? -1,
                      postId: postId,
                    )),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: getSize(15),
                horizontal: getSize(15),
              ),
              decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(getSize(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: getSize(22),
                    backgroundColor: AppColors.green,
                    child: CircleAvatar(
                      backgroundColor: AppColors.scaffoldColor,
                      radius: getSize(21),
                      backgroundImage: (contractor.profile != null &&
                              contractor.profile!.isNotEmpty)
                          ? NetworkImage(contractor.profile ?? "")
                          : null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                    child: BaseText(
                      text:
                          '${contractor.first_name ?? ""} ${contractor.last_name ?? ""}',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded, size: getSize(16)),
                ],
              ),
            ),
          ),
          if (cancelFilter == 2) ...[
            SizedBox(height: getSize(10)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getSize(18), vertical: getSize(10)),
              child: BaseText(
                text: StringConstant.reason,
                fontSize: 12,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getSize(15),
                horizontal: getSize(15),
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(getSize(10)),
              ),
              child: BaseText(
                text: contractor.reason ?? "",
                fontSize: 12,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
