import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_long_term_view_applicant/employer_long_term_view_applicant_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_long_term_applicant/employer_long_term_applicant_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/common_card_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermApplicantView")
class EmployerLongTermApplicantView extends StatelessWidget {
  const EmployerLongTermApplicantView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermViewApplicantBloc>()
        ..add(
          EmployerLongTermViewApplicantEvent.getApplicants(context: context, id: id, refresh: true),
        ),
      child: Scaffold(
        appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "View Applicants"),
        body: BlocBuilder<EmployerLongTermViewApplicantBloc, EmployerLongTermViewApplicantState>(
          builder: (context, state) {
            return Stack(
              children: [
                PaginatedListView(
                  onRefresh: () {
                    context.read<EmployerLongTermViewApplicantBloc>().add(
                      EmployerLongTermViewApplicantEvent.getApplicants(context: context, id: id, refresh: true),
                    );
                  },
                  onLoading: () {
                    context.read<EmployerLongTermViewApplicantBloc>().add(
                      EmployerLongTermViewApplicantEvent.getApplicants(context: context, id: id, refresh: false),
                    );
                  },
                  refreshController: context.read<EmployerLongTermViewApplicantBloc>().refreshController,
                  isNoDataFound: state.isNoDataFound,
                  child: state.isLoading
                      ? CenterLoadingIndicator()
                      : state.isErrorInAPI
                      ? Center(
                    child: BaseText(text: StringConstant.somethindWentWrong),
                  )
                      : _LongTermApplicantsListView(applicantList: state.applicantsList),
                ),
                if(state.postDataLoading)CenterLoadingIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LongTermApplicantsListView extends StatelessWidget {
  const _LongTermApplicantsListView({required this.applicantList});

  final List<EmployerLongTermApplicantDto> applicantList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(getSize(16)).copyWith(top: 0),
      itemCount: applicantList.length,
      separatorBuilder: (context, index) => Gap(getSize(16)),
      itemBuilder: (context, index) => _ApplicantsListTile(data: applicantList[index]),
    );
  }
}

class _ApplicantsListTile extends StatelessWidget {
  const _ApplicantsListTile({required this.data});

  final EmployerLongTermApplicantDto data;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(20))),
      child: Padding(
        padding: EdgeInsets.all(getSize(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(10))),
                  color: AppColors.scaffoldColor,
                  child: _buildPositionTile(context, data: data),
                ),
                Gap(getSize(12)),
                Row(
                  children: [
                    _buildButton(
                      context,
                      label: "Accept",
                      onPressed: () async {
                        final result = await AppDialog.showCommonDialog(
                          context: context,
                          title: "Accept",
                          content:
                              "Once the contractor is accepted for the position, they will have 72 hours to confirm. If not confirmed, the offer will expire.",
                          extraContent: "Are you sure you want to accept this contractor for the position?",
                          successLabel: "Accept",
                        );

                        if (result ?? false) {
                          CommonCardDialog(
                            title: StringConstant.cardDetails,
                            description: StringConstant.pleaseAddYourCardDetailsToProceed,
                            buttonText: StringConstant.addCard,
                            onPressed: () {
                              // context.router.maybePop();
                              // context.router
                              //     .push(PageRouteInfo(AddCardDetailPage.name, args: AddCardDetailPageArgs(fromRegister: false)))
                              //     .then((value) {
                              //   if (value != null && value == true) {
                              //     acceptDialog(context);
                              //   }
                              // });
                            },
                            image: SvgImageConstant.cardImage,
                          ).addCardDialog(context);
                        }
                      },
                      backgroundColor: AppColors.primaryColor,
                      textColor: AppColors.white,
                    ),
                    Gap(getSize(10)),
                    _buildButton(
                      context,
                      label: "Reject",
                      onPressed: () async {
                        final result = await AppDialog.showCommonDialog(
                          context: context,
                          title: "Reject",
                          content: "Are you sure you want to reject this application?",
                          successLabel: "Reject",
                        );
                        if (result ?? false) {
                          context.read<EmployerLongTermViewApplicantBloc>().add(
                                EmployerLongTermViewApplicantEvent.onRejectApplicant(context: context, id: data.id ?? -1),
                              );
                        }
                      },
                      backgroundColor: AppColors.white,
                      textColor: AppColors.primaryColor,
                      outline: AppColors.primaryColor,
                    ),
                    Gap(getSize(10)),
                    _buildButton(
                      context,
                      label: "View Profile",
                      onPressed: () {
                        context.router.push(
                          PageRouteInfo(
                            ViewApplicantProfile.name,
                            args: ViewApplicantProfileArgs(id: data.user_id ?? -1, postId: data.post_id ?? -1, isLongOrFull: 1),
                          ),
                        );
                      },
                      backgroundColor: AppColors.scaffoldColor,
                      textColor: AppColors.black,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    Color? outline,
  }) {
    return Expanded(
      child: CommonMaterialButton(
        height: 42,
        onPressed: onPressed,
        label: label,
        radius: 10,
        padding: EdgeInsets.all(4),
        backgroundColor: backgroundColor,
        borderColor: outline,
        textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textColor),
      ),
    );
  }

  Widget _buildPositionTile(
    BuildContext context, {
    required EmployerLongTermApplicantDto data,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context, data: data),
            Gap(getSize(6)),
            Divider(),
            Gap(getSize(6)),
            _buildLocationInfo(context, data: data),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(
    BuildContext context, {
    required EmployerLongTermApplicantDto data,
  }) {
    return Material(
      color: AppColors.scaffoldColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(url: data.profile ?? "", size: 48),
          Gap(getSize(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: "${data.first_name ?? ""} ${data.last_name ?? ""}",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text: data.distance ?? "",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          BaseText(
            text: data.last_ago ?? "",
            fontSize: 10,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget _buildLocationInfo(
    BuildContext context, {
    required EmployerLongTermApplicantDto data,
  }) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: data.location ?? "",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
