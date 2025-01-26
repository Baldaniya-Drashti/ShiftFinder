import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_long_term_confirmation/employer_long_term_confirmation_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermPostConfirmationView")
class EmployerLongTermPostConfirmationView extends StatelessWidget {
  const EmployerLongTermPostConfirmationView(
      {super.key, required this.postShiftDTO, required this.employerAddDetailDto});

  final PostShiftDTO postShiftDTO;
  final EmployerLongTermSuccessDto employerAddDetailDto;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermConfirmationBloc>()
        ..add(
          EmployerLongTermConfirmationEvent.onCreate(postShiftDTO, employerAddDetailDto),
        ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            bottomNavigationBar: SafeArea(
              minimum: EdgeInsets.all(getSize(16)).copyWith(bottom: getSize(22)),
              child: CommonButton(
                onPressed: () {
                  context.read<EmployerLongTermConfirmationBloc>().add(
                        EmployerLongTermConfirmationEvent.onContinue(context),
                      );
                },
                buttonText: "Continue",
              ),
            ),
            appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Healthcare"),
            body: BlocBuilder<EmployerLongTermConfirmationBloc, EmployerLongTermConfirmationState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.all(getSize(16)).copyWith(top: 0),
                      child: Column(
                        children: [
                          BlocSelector<EmployerLongTermConfirmationBloc, EmployerLongTermConfirmationState, bool>(
                            selector: (state) {
                              return state.employerAddDetailDto.share_team_status == 1;
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
                                        showError(message: StringConstant.toShareThisPostDesc).show(context);
                                        return;
                                      }
                                      context.read<EmployerLongTermConfirmationBloc>().add(
                                            EmployerLongTermConfirmationEvent.selectSharePostWithTeam(
                                                shareTeamStatus ? 0 : 1),
                                          );
                                    },
                                    label: "Share this posting with the Team",
                                  ),
                                  if (shareTeamStatus) ...[
                                    Gap(getSize(18)),
                                    _TeamsListView(
                                      teamList: state.teamList,
                                      selectedTeamList: state.selectedTeamList,
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),
                          Gap(getSize(18)),
                          BlocSelector<EmployerLongTermConfirmationBloc, EmployerLongTermConfirmationState, bool>(
                            selector: (state) {
                              return state.employerAddDetailDto.save_template_status == 1;
                            },
                            builder: (context, saveTemplateStatus) {
                              return _buildCheckListTile(
                                context,
                                value: saveTemplateStatus,
                                onChanged: (value) {
                                  context.read<EmployerLongTermConfirmationBloc>().add(
                                      EmployerLongTermConfirmationEvent.selectFuturePosting(
                                          saveTemplateStatus ? 0 : 1));
                                },
                                label: "Save this as a template for future posting",
                                trailing: GestureDetector(
                                  onTap: () {
                                    AppDialog.showInfo(
                                      context,
                                      StringConstant.teamInfoDesc,
                                      maxLines: 10,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    SvgImageConstant.infoCircle,
                                  ),
                                ),
                              );
                            },
                          ),
                          Gap(getSize(18)),
                          BlocSelector<EmployerLongTermConfirmationBloc, EmployerLongTermConfirmationState, bool>(
                            selector: (state) {
                              return state.employerAddDetailDto.employer_payment_confirmation == 1;
                            },
                            builder: (context, employerConfirmation) {
                              return _buildCheckListTile(
                                context,
                                value: employerConfirmation,
                                onChanged: (value) {
                                  context.read<EmployerLongTermConfirmationBloc>().add(
                                        EmployerLongTermConfirmationEvent.selectTermsAndCondition(
                                            employerConfirmation ? 0 : 1),
                                      );
                                },
                                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                label:
                                    "By proceeding, I confirm that we, the employer, are responsible for making payments  directly to the contractor for this long-term contract. We understand that ShiftFinder is  not responsible for any disputes, including those arising from non-payment or contract  violations. We confirm that the ShiftFinder service fee is payable by us upon accepting a  contractor for the position.",
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    if (state.postDataLoading)
                      CenterLoadingIndicator(
                        isOnlyLoader: true,
                      ),
                  ],
                );
              },
            ),
          );
        },
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
      decoration: BoxDecoration(color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
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
                  color: AppColors.black.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  onChanged(value!);
                },
              ),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Expanded(
              child: BaseText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                maxLines: 15,
              ),
            ),
            if (trailing != null) trailing
          ],
        ),
      ),
    );
  }
}

class _TeamsListView extends StatelessWidget {
  const _TeamsListView({required this.teamList, required this.selectedTeamList});

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
                value: selectedTeamList.any((selectedTeam) => selectedTeam.id == teamList[index].id),
                activeColor: AppColors.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  if (value != null) {
                    context.read<EmployerLongTermConfirmationBloc>().add(
                          EmployerLongTermConfirmationEvent.selectTeam(teamList[index]),
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
