import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/profile/previous_shift/previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_previous_shift/employer_previous_shift_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class PreviousShiftRemarkedView extends StatelessWidget {
  const PreviousShiftRemarkedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousShiftBloc, PreviousShiftState>(
      builder: (context, state) {
        Log.debug("remarkedList:: ${state.remarkedList.length}");
        return Stack(
          children: [
            PaginatedListView(
              onRefresh: () {
                context
                    .read<PreviousShiftBloc>()
                    .add(PreviousShiftEvent.fetchRemarkedList(refresh: true));
              },
              onLoading: () {
                context
                    .read<PreviousShiftBloc>()
                    .add(PreviousShiftEvent.fetchRemarkedList(refresh: false));
              },
              refreshController: context.read<PreviousShiftBloc>().remarked,
              isNoDataFound: state.remarkedListNoDataFound,
              child: state.remarkedListLoading
                  ? CenterLoadingIndicator()
                  : state.remarkedListIsErrorApi
                      ? Center(
                          child:
                              BaseText(text: StringConstant.somethindWentWrong),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(getSize(20)),
                          itemBuilder: (context, index) =>
                              _PreviousShiftRemarkedTile(
                                  data: state.remarkedList[index]),
                          separatorBuilder: (context, index) =>
                              Gap(getSize(16)),
                          itemCount: state.remarkedList.length,
                        ),
            ),
            if (state.postDataLoading) CenterLoadingIndicator()
          ],
        );
      },
    );
  }
}

class _PreviousShiftRemarkedTile extends StatelessWidget {
  const _PreviousShiftRemarkedTile({required this.data});

  final EmployerPreviousShiftDto data;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(16))),
      child: Padding(
        padding: EdgeInsets.all(getSize(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                context.router.push(
                  PageRouteInfo(ViewApplicantProfile.name,
                      args: ViewApplicantProfileArgs(
                          id: data.user_id ?? -1, postId: data.post_id ?? -1)),
                );
              },
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldColor,
                  borderRadius: BorderRadius.circular(getSize(16)),
                ),
                child: Row(
                  children: [
                    UserAvatar(url: data.profile ?? ""),
                    Gap(12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BaseText(
                                    text:
                                        "${data.first_name ?? ""} ${data.last_name ?? ""}",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  SizedBox(
                                    width: getSize(10),
                                  ),
                                  SvgPicture.asset(
                                    SvgImageConstant.rightArrow,
                                    height: 10,
                                    width: 10,
                                    color: AppColors.black.withOpacity(0.5),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Gap(1),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                SvgImageConstant.emailFilled,
                                height: 16,
                                width: 16,
                              ),
                              SizedBox(
                                width: getSize(4),
                              ),
                              Expanded(
                                child: BaseText(
                                  text: data.email ?? "",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  textColor: AppColors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Material(
                      color: AppColors.red.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getSize(7))),
                      child: InkWell(
                        onTap: () {
                          AppDialog.showDelete(
                            title: "Remove",
                            context,
                            infoMessage:
                                "Are you sure you want to remove this contractor from remarked list?",
                            onCancelClick: () {
                              Navigator.pop(context);
                            },
                            onDeleteClick: () async {
                              await context.router.maybePop().then(
                                (_) {
                                  if (data.id == null) return;
                                  context.read<PreviousShiftBloc>().add(
                                      PreviousShiftEvent.deleteRemark(
                                          id: data.id ?? -1, context: context));
                                },
                              );
                            },
                            deleteBtnText: "Remove",
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(getSize(9)),
                          child: SvgPicture.asset(
                            SvgImageConstant.delete,
                            color: AppColors.red,
                            height: 13,
                            width: 13,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getSize(12),
            ),
            BaseText(
              text: "Comment",
              fontSize: 12,
            ),
            SizedBox(
              height: getSize(12),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Material(
                color: AppColors.scaffoldColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(getSize(15)),
                  child: BaseText(
                      maxLines: 15,
                      fontSize: getSize(12),
                      fontWeight: FontWeight.w500,
                      text: data.remark ?? ""),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
