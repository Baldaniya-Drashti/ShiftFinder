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
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermPostConfirmationView")
class EmployerLongTermPostConfirmationView extends StatelessWidget {
  const EmployerLongTermPostConfirmationView({super.key, required this.postShiftDTO, required this.employerAddDetailDto});
  final PostShiftDTO postShiftDTO;
  final EmployerLongTermAddDetailDto employerAddDetailDto;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermConfirmationBloc>()
        ..add(
          EmployerLongTermConfirmationEvent.getTeamList(),
        ),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.all(getSize(16)),
          child: CommonButton(
            onPressed: () {},
            buttonText: "Continue",
          ),
        ),
        appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Healthcare"),
        body: BlocBuilder<EmployerLongTermConfirmationBloc, EmployerLongTermConfirmationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(getSize(16)).copyWith(top: 0),
              child: Column(
                children: [
                  _buildCheckListTile(
                    context,
                    value: state.shareWithTeam,
                    onChanged: (value) {
                      context.read<EmployerLongTermConfirmationBloc>().add(
                            EmployerLongTermConfirmationEvent.selectSharePostWithTeam(value),
                          );
                    },
                    label: "Share this posting with the Team",
                  ),
                  if (state.shareWithTeam) ...[
                    Gap(getSize(18)),
                    _TeamsListView(
                      teamList: state.teamList,
                      selectedTeamList: state.selectedTeamList,
                    ),
                  ],
                  Gap(getSize(18)),
                  _buildCheckListTile(
                    context,
                    value: state.saveAsFuturePost,
                    onChanged: (value) {
                      context.read<EmployerLongTermConfirmationBloc>().add(
                            EmployerLongTermConfirmationEvent.selectFuturePosting(value),
                          );
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
                  ),
                  Gap(getSize(18)),
                  _buildCheckListTile(
                    context,
                    value: state.agreeTermsAndCondition,
                    onChanged: (value) {
                      context.read<EmployerLongTermConfirmationBloc>().add(
                            EmployerLongTermConfirmationEvent.selectTermsAndCondition(value),
                          );
                    },
                    padding: EdgeInsets.all(getSize(16)),
                    label:
                        "By proceeding, I confirm that we, the employer, are responsible for making payments  directly to the contractor for this long-term contract. We understand that ShiftFinder is  not responsible for any disputes, including those arising from non-payment or contract  violations. We confirm that the ShiftFinder service fee is payable by us upon accepting a  contractor for the position.",
                  ),
                ],
              ),
            );
          },
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
    return Material(
      color: AppColors.surfaceColor,
      borderRadius: BorderRadius.circular(getSize(10)),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.9,
              child: Checkbox(
                activeColor: AppColors.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: AppColors.black.withOpacity(.5), width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                value: value,
                onChanged: (value) {
                  if (value == null) return;
                  onChanged(value);
                },
              ),
            ),
            Gap(4),
            Expanded(
              child: BaseText(text: label, fontSize: 12, fontWeight: FontWeight.w500, maxLines: 10),
            ),
            if (trailing != null) trailing,
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
                value: selectedTeamList.contains(teamList[index]),
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
