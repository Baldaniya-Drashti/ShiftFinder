import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_long_term_confirmation/employer_long_term_confirmation_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermPostConfirmationView")
class EmployerLongTermPostConfirmationView extends StatelessWidget {
  const EmployerLongTermPostConfirmationView({
    super.key,
    required this.postShiftDTO,
    required this.employerAddDetailDto,
    this.postId,
    this.fromReview = false,
    this.isCreate = true,
    this.fromTemplate = false,
  });

  final PostShiftDTO postShiftDTO;
  final EmployerLongTermSuccessDto employerAddDetailDto;
  final int? postId;
  final bool fromReview;
  final bool fromTemplate;
  final bool isCreate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermConfirmationBloc>()
        ..add(
          EmployerLongTermConfirmationEvent.onCreate(
              postShiftDTO, employerAddDetailDto, postId),
        ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            bottomNavigationBar: SafeArea(
              minimum:
                  EdgeInsets.all(getSize(16)).copyWith(bottom: getSize(22)),
              child: CommonButton(
                onPressed: () {
                  context.read<EmployerLongTermConfirmationBloc>().add(
                        EmployerLongTermConfirmationEvent.onContinue(
                          context,
                          fromReview: fromReview,
                          isCreate: isCreate,
                          fromTemplate: fromTemplate,
                        ),
                      );
                },
                buttonText: StringConstant.txtContinue,
              ),
            ),
            appBar: CommonAppBar(
                onBackPressed: () => context.router.maybePop(),
                title: (fromTemplate)
                    ? StringConstant.editTemplate
                    : CommonList.industryList
                            .firstWhere(
                                (item) => item.id == getCurrentIndustry())
                            .title ??
                        ""),
            body: BlocBuilder<EmployerLongTermConfirmationBloc,
                EmployerLongTermConfirmationState>(
              builder: (context, state) {
                return (state.postDataLoading)
                    ? CenterLoadingIndicator(isOnlyLoader: true)
                    : SingleChildScrollView(
                        padding: EdgeInsets.all(getSize(16)).copyWith(top: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocSelector<EmployerLongTermConfirmationBloc,
                                EmployerLongTermConfirmationState, bool>(
                              selector: (state) {
                                return state.employerAddDetailDto
                                        .share_team_status ==
                                    1;
                              },
                              builder: (context, shareTeamStatus) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildCheckListTile(
                                      context,
                                      value: shareTeamStatus,
                                      onChanged: (value) {
                                        if (state.teamList.isEmpty) {
                                          showError(
                                                  message: StringConstant
                                                      .toShareThisPostDesc)
                                              .show(context);
                                          return;
                                        }
                                        context
                                            .read<
                                                EmployerLongTermConfirmationBloc>()
                                            .add(
                                              EmployerLongTermConfirmationEvent
                                                  .selectSharePostWithTeam(
                                                      shareTeamStatus ? 0 : 1),
                                            );
                                      },
                                      label: StringConstant
                                          .shareThisPostingWithTheTeam,
                                    ),
                                    if (shareTeamStatus) ...[
                                      Gap(getSize(18)),
                                      _TeamsListView(
                                        teamList: state.teamList,
                                        selectedTeamList:
                                            state.selectedTeamList,
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                            if (!fromTemplate) ...[
                              Gap(getSize(18)),
                              BlocSelector<EmployerLongTermConfirmationBloc,
                                  EmployerLongTermConfirmationState, bool>(
                                selector: (state) {
                                  return state.employerAddDetailDto
                                          .save_template_status ==
                                      1;
                                },
                                builder: (context, saveTemplateStatus) {
                                  return _buildCheckListTile(
                                    context,
                                    value: saveTemplateStatus,
                                    onChanged: (value) {
                                      context
                                          .read<
                                              EmployerLongTermConfirmationBloc>()
                                          .add(EmployerLongTermConfirmationEvent
                                              .selectFuturePosting(
                                                  saveTemplateStatus ? 0 : 1));
                                    },
                                    label: StringConstant
                                        .saveThisAsATemplateForFuturePosting,
                                  );
                                },
                              ),
                            ],
                            Gap(getSize(18)),
                            isTermsCheck(context, state),
                            if (state.showErrorMessage && !state.isTermsCheck)
                              commonErrorText(
                                  StringConstant.pleaseCheckTheBoxToProceeding)
                          ],
                        ),
                      );
              },
            ),
          );
        },
      ),
    );
  }

  Widget isTermsCheck(
    BuildContext context,
    EmployerLongTermConfirmationState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          bool value = state.isTermsCheck;
          value = !value;
          context.read<EmployerLongTermConfirmationBloc>().add(
              EmployerLongTermConfirmationEvent.selectTermsAndCondition(value));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: state.isTermsCheck,
                activeColor: AppColors.primaryColor,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withValues(alpha: 0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  if (value != null) {
                    context.read<EmployerLongTermConfirmationBloc>().add(
                        EmployerLongTermConfirmationEvent
                            .selectTermsAndCondition(value));
                  }
                },
              ),
            ),
            SizedBox(width: getSize(15)),
            Expanded(
              child: BaseText(
                text: StringConstant.longTermsDesc,
                fontSize: 12,
                maxLines: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckListTile(
    BuildContext context, {
    required bool value,
    required void Function(bool value) onChanged,
    required String label,
    EdgeInsets? padding,
    Widget? trailing,
  }) {
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: getSize(20),
            vertical: getSize(10),
          ),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          onChanged(!value);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: value,
                activeColor: AppColors.primaryColor,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withValues(alpha: 0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  onChanged(value!);
                },
              ),
            ),
            SizedBox(width: getSize(15)),
            Expanded(
              child: BaseText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                maxLines: 15,
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}

class _TeamsListView extends StatelessWidget {
  const _TeamsListView(
      {required this.teamList, required this.selectedTeamList});

  final List<TeamDTO> teamList;
  final List<TeamDTO> selectedTeamList;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grey04,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: teamList.length,
          padding: EdgeInsets.all(getSize(8)),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              title: BaseText(
                text: teamList[index].name ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              leading: SvgPicture.asset(
                SvgImageConstant.threePersonWithPlus,
                height: getSize(24),
                width: getSize(24),
              ),
              trailing: Checkbox(
                value: selectedTeamList.any(
                    (selectedTeam) => selectedTeam.id == teamList[index].id),
                activeColor: AppColors.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withValues(alpha: 0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  if (value != null) {
                    context.read<EmployerLongTermConfirmationBloc>().add(
                          EmployerLongTermConfirmationEvent.selectTeam(
                              teamList[index]),
                        );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
