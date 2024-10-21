import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/application/main_tab/home/view_single_applicants/view_single_applicants_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_applicant/employer_applicant_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import 'widgets/accept_reject_dialog.dart';
import 'widgets/common_card_dialog.dart';

@RoutePage(name: 'ViewSingleApplicants')
class ViewSingleApplicants extends StatelessWidget {
  const ViewSingleApplicants({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ViewSingleApplicantsBloc>()..add(ViewSingleApplicantsEvent.getApplicantsList(postId, true)),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: 'View Applicants',
        ),
        body: BlocBuilder<ViewSingleApplicantsBloc, ViewSingleApplicantsState>(
          builder: (context, state) {
            return Stack(
              children: [
                PaginatedListView(
                  onRefresh: () {
                    context.read<ViewSingleApplicantsBloc>().add(ViewSingleApplicantsEvent.getApplicantsList(postId, true));
                  },
                  onLoading: () {
                    context.read<ViewSingleApplicantsBloc>().add(ViewSingleApplicantsEvent.getApplicantsList(postId, false));
                  },
                  refreshController: context.read<ViewSingleApplicantsBloc>().refreshController,
                  isNoDataFound: state.isNoDataFound,
                  child: state.isLoading
                      ? CenterLoadingIndicator()
                      : state.isErrorInAPI
                      ? Center(
                    child: BaseText(text: StringConstant.somethindWentWrong),
                  )
                      : ListView.builder(
                    itemCount: state.employerApplicantList.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(18),
                      vertical: getSize(20),
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          top: index == 0 ? 0 : getSize(10),
                          bottom: index != 9 ? getSize(10) : 0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(getSize(20)),
                        ),
                        padding: EdgeInsets.all(getSize(10)),
                        child: Column(
                          children: [
                            getApplicantswDetailContainer(data: state.employerApplicantList[index]),
                            SizedBox(height: getSize(10)),
                            if (state.employerApplicantList[index].revoke_status == 2) ...[
                              revokingStatus(context, state, state.employerApplicantList[index])
                            ] else if(state.employerApplicantList[index].revoke_status == 3)...[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: getSize(10)),
                                child: BaseText(
                                  text: StringConstant.offerRevokedByTheEmployer,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ] else ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (state.employerApplicantList[index].request == 1) ...[
                                    Expanded(
                                      child: CommonButton(
                                        onPressed: () {
                                          AcceptRejectDialog(
                                            title: 'Revoke',
                                            description:
                                            'Once you revoke, the contractor will have a 2-hour window to confirm the shift. If they do not confirm within 2 hours, the offer will be automatically revoked.',
                                            onPressedAccept: () {
                                              context.router.maybePop();
                                              final userId = state.employerApplicantList[index].user_id;

                                              context.read<ViewSingleApplicantsBloc>().add(
                                                ViewSingleApplicantsEvent.onRevoke(postId: postId, userId: userId ?? 0, context: context),
                                              );
                                            },
                                            acceptButtonText: 'Revoke',
                                            onPressedReject: () {
                                              context.router.maybePop();
                                            },
                                          ).acceptRejectDialog(context);
                                        },
                                        backgroundColor: AppColors.redAccent.withOpacity(0.1),
                                        buttonTextColor: AppColors.black,
                                        buttonFontSize: 12,
                                        borderRadius: 10,
                                        buttonText: 'Revoke',
                                        height: 34,
                                      ),
                                    ),
                                  ] else ...[
                                    Expanded(
                                      child: CommonButton(
                                        onPressed: () {
                                          if (false /*!state.isCardAdded*/) {
                                            CommonCardDialog(
                                              title: 'Card Details',
                                              description: 'Please add your card details to proceed.',
                                              buttonText: 'Add Card',
                                              onPressed: () {
                                                context.router.maybePop();
                                                context.router
                                                    .push(PageRouteInfo(AddCardDetailPage.name, args: AddCardDetailPageArgs(fromRegister: false)));
                                              },
                                              image: SvgImageConstant.cardImage,
                                            ).addCardDialog(context);
                                          } else {
                                            AcceptRejectDialog(
                                              title: 'Accept',
                                              description: 'Are you sure you want to accept this application?',
                                              onPressedAccept: () {
                                                context.router.maybePop();
                                                final id = state.employerApplicantList[index].id;
                                                context.read<ViewSingleApplicantsBloc>().add(
                                                  ViewSingleApplicantsEvent.acceptApplicants(
                                                    context,
                                                    id ?? 0,
                                                  ),
                                                );
                                              },
                                              onPressedReject: () {
                                                context.router.maybePop();
                                              },
                                            ).acceptRejectDialog(context);
                                          }
                                        },
                                        buttonText: 'Accept',
                                        buttonFontSize: 12,
                                        borderRadius: 10,
                                        height: 34,
                                      ),
                                    ),
                                    SizedBox(width: getSize(16)),
                                    Expanded(
                                      child: CommonButton(
                                        onPressed: () {
                                          AcceptRejectDialog(
                                            title: 'Reject',
                                            description: 'Are you sure you want to reject this application?',
                                            onPressedAccept: () {
                                              context.router.maybePop();

                                              final id = state.employerApplicantList[index].id;
                                              context.read<ViewSingleApplicantsBloc>().add(
                                                ViewSingleApplicantsEvent.rejectApplicants(
                                                  context,
                                                  id ?? 0,
                                                ),
                                              );
                                            },
                                            acceptButtonText: 'Reject',
                                            onPressedReject: () {
                                              context.router.maybePop();
                                            },
                                          ).acceptRejectDialog(context);
                                        },
                                        backgroundColor: AppColors.white,
                                        borderColor: AppColors.green,
                                        buttonTextColor: AppColors.green,
                                        buttonFontSize: 12,
                                        borderRadius: 10,
                                        buttonText: 'Reject',
                                        height: 34,
                                      ),
                                    ),
                                  ],
                                  SizedBox(width: getSize(16)),
                                  Expanded(
                                    child: CommonButton(
                                      onPressed: () {
                                        final userId = state.employerApplicantList[index].user_id ?? -1;

                                        Log.success("postId ${postId}");
                                        context.router.push(
                                          PageRouteInfo(ViewApplicantProfile.name, args: ViewApplicantProfileArgs(id: userId, postId: postId)),
                                        );
                                      },
                                      backgroundColor: AppColors.scaffoldColor,
                                      buttonTextColor: AppColors.black,
                                      buttonFontSize: 12,
                                      borderRadius: 10,
                                      buttonText: 'View Profile',
                                      height: 34,
                                    ),
                                  ),

                                ],
                              )

                            ]



                          ],
                        ),
                      );
                    },
                  ),
                ),
                if(state.postDataLoading)CenterLoadingIndicator()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget revokingStatus(BuildContext context, ViewSingleApplicantsState state, EmployerApplicantsDto shift) {
    final hours = shift.duration?.inHours.toString().padLeft(2, '0') ?? 00;
    final minutes = shift.duration?.inMinutes.remainder(60).toString().padLeft(2, '0') ?? 00;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.scaffoldColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(12)),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 10,
        onTap: () {
          /*context.read<ContractorShiftBloc>().add(
                ContractorShiftEvent.startRevokingTimer(
                    Duration(hours: 2), shift.id ?? -1,
                    revokeTime: (shift.id == 92) ? 1728627746 : 1728627655),
              );*/
        },
        title: Padding(
          padding: EdgeInsets.only(left: getSize(20)),
          child: BaseText(
            text: StringConstant.revoking,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textColor: AppColors.black.withOpacity(0.7),
          ),
        ),
        trailing: Container(
          width: getSize(108),
          padding: EdgeInsets.symmetric(vertical: getSize(5)),
          decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                SvgImageConstant.clock,
                height: getSize(15),
                width: getSize(15),
              ),
              BaseText(
                text: "$hours h $minutes min",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getApplicantswDetailContainer({required EmployerApplicantsDto data}) {
    return Container(
      padding: EdgeInsets.all(getSize(12)),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: getSize(24),
                backgroundColor: AppColors.green,
                child: CircleAvatar(
                  radius: getSize(23),
                  backgroundImage: NetworkImage(
                    data.profile ?? "",
                  ),
                ),
              ),
              SizedBox(width: getSize(15)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BaseText(
                          text: "${data.first_name ?? ""} ${data.last_name ?? ""}",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(width: getSize(10)),
                        Visibility(
                          visible: false,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(7),
                              vertical: getSize(5),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.redAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(getSize(10)),
                            ),
                            child: BaseText(
                              text: 'Occupied',
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.redAccent.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Spacer(),
                        BaseText(
                          text: data.last_ago ?? "",
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(height: getSize(3)),
                    BaseText(
                      text: 'Distance - ${data.distance ?? ""}',
                      fontSize: 8,
                      textColor: AppColors.black.withOpacity(0.8),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: getSize(10)),
          Divider(
            height: 0,
            color: AppColors.black.withOpacity(0.2),
            thickness: 0.5,
          ),
          SizedBox(height: getSize(10)),
          Row(
            children: [
              SvgPicture.asset(
                SvgImageConstant.location,
                colorFilter: ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcATop,
                ),
              ),
              SizedBox(width: getSize(5)),
              BaseText(
                text: data.location ?? "",
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
