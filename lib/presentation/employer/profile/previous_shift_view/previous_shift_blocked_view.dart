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
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class PreviousShiftBlockedView extends StatelessWidget {
  const PreviousShiftBlockedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousShiftBloc, PreviousShiftState>(
      builder: (context, state) {
        return Stack(
          children: [
            PaginatedListView(
              onRefresh: () => PreviousShiftEvent.fetchBlockedList(refresh: true),
              onLoading: () => PreviousShiftEvent.fetchBlockedList(refresh: false),
              refreshController: context.read<PreviousShiftBloc>().blocked,
              isNoDataFound: state.blockedListNoDataFound,
              child: state.blockedListLoading
                  ? CenterLoadingIndicator()
                  : state.blockedListIsErrorApi
                      ? Center(
                          child: BaseText(text: StringConstant.somethindWentWrong),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(getSize(20)),
                          itemBuilder: (context, index) => _PreviousShiftBlockedTile(
                            data: state.blockedList[index],
                          ),
                          separatorBuilder: (context, index) => Gap(getSize(16)),
                          itemCount: state.blockedList.length,
                        ),
            ),
            if (state.postDataLoading) CenterLoadingIndicator()
          ],
        );
      },
    );
  }
}

class _PreviousShiftBlockedTile extends StatelessWidget {
  const _PreviousShiftBlockedTile({required this.data});

  final EmployerPreviousShiftDto data;

  @override
  Widget build(BuildContext context) {
    return BaseTileDecoration(
      padding: EdgeInsets.all(getSize(12)),
      child: Material(
        borderRadius: BorderRadius.circular(getSize(16)),
        color: AppColors.scaffoldColor,
        child: UserInfoTile(
          titleIcon: SvgPicture.asset(
            SvgImageConstant.rightArrow,
            height: 13,
            width: 13,
            colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.5), BlendMode.srcIn),
          ),
          padding: EdgeInsets.symmetric(horizontal: getSize(16)),
          url: data.profile ?? "",
          title: "${data.first_name ?? ""} ${data.last_name ?? ""}",
          subTitle: "${data.role_lists_name}",
          trailing: CommonMaterialButton.icon(
            radius: 10.0,
            backgroundColor: AppColors.redAccent.withOpacity(0.2),
            width: 90,
            height: 33,
            onPressed: () => _showBlockedDialog(context),
            label: "Blocked",
            textStyle: TextStyle(fontSize: 10, color: AppColors.red),
            icon: SvgPicture.asset(SvgImageConstant.blockedFilled, height: 15, width: 15),
          ),
        ),
      ),
    );
  }

  void _showBlockedDialog(BuildContext context) {
    AppDialog.showDelete(
      title: "Unblock",
      context,
      infoMessage: "Unblocking [contractor name] will allow them to view and apply for your future postings. Are you sure you want to proceed?",
      onCancelClick: () => Navigator.pop(context),
      onDeleteClick: () {},
      deleteBtnText: "Unblock",
    );
  }
}
