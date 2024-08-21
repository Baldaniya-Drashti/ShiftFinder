// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
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
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
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
      create: (context) => getIt<ViewSingleApplicantsBloc>()
        ..add(ViewSingleApplicantsEvent.getApplicantsList(postId, true)),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: 'View Applicants',
        ),
        body: BlocBuilder<ViewSingleApplicantsBloc, ViewSingleApplicantsState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(18),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () {
                            if (state.completeShift != 0) {
                              context.router.push(
                                PageRouteInfo(FilledHiredContractorList.name,
                                    args: FilledHiredContractorListArgs(
                                        postId: postId)),
                              );
                            }
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgImageConstant.profileCircle,
                                height: 35,
                                width: 35,
                              ),
                              Gap(8),
                              Expanded(
                                child: BaseText(
                                  text:
                                      "All Hired Contractors (${state.completeShift}/${state.totalShift})",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              SvgPicture.asset(
                                SvgImageConstant.rightArrow,
                                height: 14,
                                width: 14,
                                colorFilter: ColorFilter.mode(
                                    AppColors.black.withOpacity(0.7),
                                    BlendMode.srcIn),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: getSize(16)),
                    Expanded(
                      child: PaginatedListView(
                        onRefresh: () {
                          context.read<ViewSingleApplicantsBloc>().add(
                              ViewSingleApplicantsEvent.getApplicantsList(
                                  postId, true));
                        },
                        onLoading: () {
                          context.read<ViewSingleApplicantsBloc>().add(
                              ViewSingleApplicantsEvent.getApplicantsList(
                                  postId, false));
                        },
                        refreshController: context
                            .read<ViewSingleApplicantsBloc>()
                            .refreshController,
                        isNoDataFound: state.isNoDataFound,
                        child: state.isLoading
                            ? CenterLoadingIndicator()
                            : state.isErrorInAPI
                                ? Center(
                                    child: BaseText(
                                        text:
                                            StringConstant.somethindWentWrong),
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getSize(18),
                                    ),
                                    child: ListView.builder(
                                      itemCount:
                                          state.employerApplicantList.length,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final data =
                                            state.employerApplicantList[index];

                                        return Container(
                                          margin: EdgeInsets.only(
                                            top: index == 0 ? 0 : getSize(10),
                                            bottom:
                                                index != 9 ? getSize(10) : 0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                getSize(20)),
                                          ),
                                          padding: EdgeInsets.all(getSize(10)),
                                          child: Column(
                                            children: [
                                              getApplicantswDetailContainer(
                                                  context,
                                                  data: state
                                                          .employerApplicantList[
                                                      index]),
                                              SizedBox(height: getSize(10)),
                                              if (data.deleteAt == 1) ...[
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: getSize(10)),
                                                  child: BaseText(
                                                    text: StringConstant
                                                        .shiftDeclined,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    textColor:
                                                        AppColors.redAccent,
                                                  ),
                                                ),
                                              ] else if (data.revoke_status ==
                                                  2) ...[
                                                revokingStatus(
                                                    context,
                                                    state,
                                                    state.employerApplicantList[
                                                        index])
                                              ] else if (data.revoke_status ==
                                                  3) ...[
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: getSize(10)),
                                                  child: BaseText(
                                                    text: StringConstant
                                                        .offerRevokedByYou,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    textColor:
                                                        AppColors.redAccent,
                                                  ),
                                                ),
                                              ] else ...[
                                                if (data.request == 1) ...[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: getSize(10)),
                                                    child: BaseText(
                                                      text: StringConstant
                                                          .awaitingAcknowledgement,
                                                      fontSize: 12,
                                                      textColor: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    if (data.request == 1) ...[
                                                      Expanded(
                                                        child: CommonButton(
                                                          onPressed: () {
                                                            AcceptRejectDialog(
                                                              title: 'Revoke',
                                                              description:
                                                                  'Once you revoke, the contractor will have a 2-hour window to confirm the shift. If they do not confirm within 2 hours, the offer will be automatically revoked.',
                                                              onPressedAccept:
                                                                  () {
                                                                context.router
                                                                    .maybePop();
                                                                final userId = state
                                                                    .employerApplicantList[
                                                                        index]
                                                                    .user_id;

                                                                context
                                                                    .read<
                                                                        ViewSingleApplicantsBloc>()
                                                                    .add(
                                                                      ViewSingleApplicantsEvent.onRevoke(
                                                                          postId:
                                                                              postId,
                                                                          userId: userId ??
                                                                              0,
                                                                          context:
                                                                              context),
                                                                    );
                                                              },
                                                              acceptButtonText:
                                                                  'Revoke',
                                                              onPressedReject:
                                                                  () {
                                                                context.router
                                                                    .maybePop();
                                                              },
                                                            ).acceptRejectDialog(
                                                                context);
                                                          },
                                                          backgroundColor:
                                                              AppColors
                                                                  .redAccent
                                                                  .withOpacity(
                                                                      0.1),
                                                          buttonTextColor:
                                                              AppColors.black,
                                                          buttonFontSize: 12,
                                                          borderRadius: 10,
                                                          buttonText: 'Revoke',
                                                          height: 34,
                                                        ),
                                                      ),
                                                    ] else ...[
                                                      Expanded(
                                                        child: CommonButton(
                                                          onPressed:
                                                              (data.occupied ==
                                                                          true ||
                                                                      data.accept_btn_toggle ==
                                                                          false)
                                                                  ? () {}
                                                                  : () {
                                                                      if (!state
                                                                          .isCardAdded) {
                                                                        CommonCardDialog(
                                                                          title:
                                                                              StringConstant.cardDetails,
                                                                          description:
                                                                              StringConstant.pleaseAddYourCardDetailsToProceed,
                                                                          buttonText:
                                                                              StringConstant.addCard,
                                                                          onPressed:
                                                                              () {
                                                                            context.router.maybePop();
                                                                            context.router.push(PageRouteInfo(AddCardDetailPage.name, args: AddCardDetailPageArgs(fromRegister: false))).then((value) {
                                                                              if (value != null && value == true) {
                                                                                acceptDialog(context, state, data, index);
                                                                              }
                                                                            });
                                                                          },
                                                                          image:
                                                                              SvgImageConstant.cardImage,
                                                                        ).addCardDialog(
                                                                            context);
                                                                      } else {
                                                                        acceptDialog(
                                                                            context,
                                                                            state,
                                                                            data,
                                                                            index);
                                                                        /* AcceptRejectDialog(
                                                                          title:
                                                                              'Accept',
                                                                          description:
                                                                              'Are you sure you want to accept this application?',
                                                                          onPressedAccept:
                                                                              () {
                                                                            if (data.occupied ==
                                                                                true)
                                                                              return;
                                                                            context.router.maybePop();
                                                                            final id =
                                                                                state.employerApplicantList[index].id;
                                                                            context.read<ViewSingleApplicantsBloc>().add(
                                                                                  ViewSingleApplicantsEvent.acceptApplicants(
                                                                                    context,
                                                                                    id ?? 0,
                                                                                  ),
                                                                                );
                                                                          },
                                                                          onPressedReject:
                                                                              () {
                                                                            context.router.maybePop();
                                                                          },
                                                                        ).acceptRejectDialog(
                                                                            context); */
                                                                      }
                                                                    },
                                                          buttonText: 'Accept',
                                                          buttonFontSize: 12,
                                                          borderRadius: 10,
                                                          height: 34,
                                                          backgroundColor: (data
                                                                          .occupied ==
                                                                      true ||
                                                                  data.accept_btn_toggle ==
                                                                      false)
                                                              ? AppColors.green
                                                                  .withOpacity(
                                                                      0.2)
                                                              : null,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: getSize(16)),
                                                      Expanded(
                                                        child: CommonButton(
                                                          onPressed:
                                                              (data.accept_btn_toggle ==
                                                                      false)
                                                                  ? () {}
                                                                  : () {
                                                                      AcceptRejectDialog(
                                                                        title:
                                                                            'Reject',
                                                                        description:
                                                                            'Are you sure you want to reject this application?',
                                                                        onPressedAccept:
                                                                            () {
                                                                          context
                                                                              .router
                                                                              .maybePop();

                                                                          final id = state
                                                                              .employerApplicantList[index]
                                                                              .id;
                                                                          context
                                                                              .read<ViewSingleApplicantsBloc>()
                                                                              .add(
                                                                                ViewSingleApplicantsEvent.rejectApplicants(
                                                                                  context,
                                                                                  id ?? 0,
                                                                                ),
                                                                              );
                                                                        },
                                                                        acceptButtonText:
                                                                            'Reject',
                                                                        onPressedReject:
                                                                            () {
                                                                          context
                                                                              .router
                                                                              .maybePop();
                                                                        },
                                                                      ).acceptRejectDialog(
                                                                          context);
                                                                    },
                                                          backgroundColor: (data
                                                                      .accept_btn_toggle ==
                                                                  false)
                                                              ? AppColors.green
                                                                  .withOpacity(
                                                                      0.2)
                                                              : AppColors.white,
                                                          borderColor:
                                                              (data.accept_btn_toggle ==
                                                                      false)
                                                                  ? null
                                                                  : AppColors
                                                                      .green,
                                                          buttonTextColor:
                                                              (data.accept_btn_toggle ==
                                                                      false)
                                                                  ? null
                                                                  : AppColors
                                                                      .green,
                                                          buttonFontSize: 12,
                                                          borderRadius: 10,
                                                          buttonText: 'Reject',
                                                          height: 34,
                                                        ),
                                                      ),
                                                    ],
                                                    SizedBox(
                                                        width: getSize(16)),
                                                    Expanded(
                                                      child: CommonButton(
                                                        onPressed: () {
                                                          final userId = state
                                                                  .employerApplicantList[
                                                                      index]
                                                                  .user_id ??
                                                              -1;

                                                          context.router.push(
                                                            PageRouteInfo(
                                                                ViewApplicantProfile
                                                                    .name,
                                                                args: ViewApplicantProfileArgs(
                                                                    id: userId,
                                                                    postId:
                                                                        postId)),
                                                          );
                                                        },
                                                        backgroundColor:
                                                            AppColors
                                                                .scaffoldColor,
                                                        buttonTextColor:
                                                            AppColors.black,
                                                        buttonFontSize: 12,
                                                        borderRadius: 10,
                                                        buttonText:
                                                            'View Profile',
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
                      ),
                    ),
                  ],
                ),
                if (state.postDataLoading) CenterLoadingIndicator()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget revokingStatus(BuildContext context, ViewSingleApplicantsState state,
      EmployerApplicantsDto shift) {
    final hours = shift.duration?.inHours.toString().padLeft(2, '0') ?? 00;
    final minutes =
        shift.duration?.inMinutes.remainder(60).toString().padLeft(2, '0') ??
            00;

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
            textColor: AppColors.redAccent,
          ),
        ),
        trailing: Container(
          width: getSize(108),
          padding: EdgeInsets.symmetric(vertical: getSize(5)),
          decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6)),
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

  acceptDialog(BuildContext context, ViewSingleApplicantsState state,
      EmployerApplicantsDto data, int index) {
    return AcceptRejectDialog(
      title: StringConstant.accept,
      description: 'Are you sure you want to accept this application?',
      onPressedAccept: () {
        if (data.occupied == true) return;
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

  getApplicantswDetailContainer(BuildContext context,
      {required EmployerApplicantsDto data}) {
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
                          text:
                              "${data.first_name ?? ""} ${data.last_name ?? ""}",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(
                          text: 'Distance - ${data.distance ?? ""}',
                          fontSize: 8,
                          textColor: AppColors.black.withOpacity(0.8),
                        ),
                        Spacer(),
                        Visibility(
                          visible: data.occupied ?? false,
                          child: GestureDetector(
                            onTap: () {
                              AppDialog.showInfo(
                                context,
                                StringConstant.occupiedDesc,
                                maxLines: 10,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: getSize(7),
                                vertical: getSize(5),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.redAccent.withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.circular(getSize(10)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BaseText(
                                    text: StringConstant.occupied,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    textColor:
                                        AppColors.redAccent.withOpacity(0.8),
                                  ),
                                  Gap(getSize(2)),
                                  SvgPicture.asset(
                                    SvgImageConstant.infoCircle,
                                    color: AppColors.redAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
          GestureDetector(
            onTap: () {
              final latitude = data.latitude;
              final longitude = data.longitude;
              if (latitude != null && longitude != null) {
                LocationHelper.openDirections(context,
                    endLat: latitude, endLng: longitude);
                /* context.router.push(
                  PageRouteInfo(
                    ShowGoogleMap.name,
                    args: ShowGoogleMapArgs(
                      latitude: latitude,
                      longitude: longitude,
                    ),
                  ),
                ); */
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  SvgImageConstant.location,
                  colorFilter: ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcATop,
                  ),
                ),
                SizedBox(width: getSize(5)),
                Expanded(
                  child: BaseText(
                    text: data.location ?? "",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
