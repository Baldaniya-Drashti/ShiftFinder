import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/auth/contractor_auth/location_example.dart';
import 'package:shift/application/employer/profile/previous_shift/previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_previous_shift/employer_previous_shift_dto.dart';
import 'package:shift/presentation/auth/contractor_auth/add_contractor_skills.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class PreviousShiftRemarkedView extends StatelessWidget {
  const PreviousShiftRemarkedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousShiftBloc, PreviousShiftState>(
      builder: (context, state) {
        Log.debug("remarkedList:: ${state.remarkedList}");
        final remark = state.remarkedList.firstOrNull;

        return Stack(
          children: [
            if (remark != null) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    BaseText(
                      text: "You can remove a contractor from your remarked list by clicking the delete button again.",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(14),
                    _PreviousShiftRemarkedTile(data: remark),
                  ],
                ),
              ),
            ] else ...[
              Center(
                child: SizedBox(
                  width: getSize(280),
                  child: BaseText(
                    textColor: AppColors.black.withOpacity(0.65),
                    text: 'No result found.',
                    textAlign: TextAlign.center,
                    lineHeight: 1.2,
                  ),
                ),
              )
            ],
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(16))),
      child: Padding(
        padding: EdgeInsets.all(getSize(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(16))),
              tileColor: AppColors.scaffoldColor,
              leading: CircleAvatar(
                radius: getSize(25),
                backgroundColor: AppColors.green,
                child: CircleAvatar(
                  radius: getSize(24),
                  backgroundImage: NetworkImage(data.profile ?? ""),
                ),
              ),
              title: Column(
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
                            text: "${data.first_name ?? ""} ${data.last_name ?? ""}",
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
              trailing: Material(
                color: AppColors.red.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(7))),
                child: InkWell(
                  onTap: () {
                    AppDialog.showDelete(
                      title: "Remove",
                      context,
                      infoMessage: "Are you sure you want to remove this contractor from remarked list?",
                      onCancelClick: () {
                        Navigator.pop(context);
                      },
                      onDeleteClick: () async {
                        await context.router.maybePop().then((_) {
                          if(data.id==null)return;
                          context.read<PreviousShiftBloc>().add(PreviousShiftEvent.deleteRemark(id: data.id??-1, context: context));
                        },);
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(getSize(15)),
                  child: BaseText(maxLines: 15, fontSize: getSize(12), fontWeight: FontWeight.w500, text: data.remark ?? ""),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
