import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_full_position_confirm/employer_full_position_confirm_bloc.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerFullPositionConfirmView")
class EmployerFullPositionConfirmView extends StatelessWidget {
  const EmployerFullPositionConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerFullPositionConfirmBloc>(),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.all(16),
          child: CommonButton(
            onPressed: () {
              context.router.navigate(PageRouteInfo(FullPositionReviewView.name));
            },
            buttonText: "Continue",
          ),
        ),
        appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Healthcare"),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: BaseText(text: "Application Deadline", fontWeight: FontWeight.w500, fontSize: 14),
              ),
              Gap(6),
              Material(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: AppColors.white,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgImageConstant.calendar),
                        Gap(18),
                        Expanded(
                          child: BaseText(
                            text: "Application Deadline",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.black.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Gap(16),
              BlocSelector<EmployerFullPositionConfirmBloc, EmployerFullPositionConfirmState, bool>(
                selector: (state) => state.includeOnCall,
                builder: (context, includeOnCall) {
                  return _buildCheckListTile(
                    context,
                    value: includeOnCall,
                    onChanged: (value) {
                      context.read<EmployerFullPositionConfirmBloc>().add(
                            EmployerFullPositionConfirmEvent.onIncludeOnCallChanged(value: value),
                          );
                    },
                    label: "This position may include on call.",
                  );
                },
              ),
              Gap(16),
              BlocSelector<EmployerFullPositionConfirmBloc, EmployerFullPositionConfirmState, bool>(
                selector: (state) => state.saveFuturePosting,
                builder: (context, saveFuturePosting) {
                  return _buildCheckListTile(
                    context,
                    value: saveFuturePosting,
                    onChanged: (value) {
                      context.read<EmployerFullPositionConfirmBloc>().add(
                            EmployerFullPositionConfirmEvent.onFuturePostingChanged(value: value),
                          );
                    },
                    label: "Save this as a template for future posting",
                  );
                },
              ),
              Gap(16),
              BlocSelector<EmployerFullPositionConfirmBloc, EmployerFullPositionConfirmState, bool>(
                selector: (state) => state.moreVacancy,
                builder: (context, moreVacancy) {
                  return _buildCheckListTile(
                    context,
                    value: moreVacancy,
                    onChanged: (value) {
                      context.read<EmployerFullPositionConfirmBloc>().add(
                            EmployerFullPositionConfirmEvent.onMoreVacancyChanged(value: value),
                          );
                    },
                    label: "We are looking to fill more than one vacancies with the same  requirements.",
                  );
                },
              ),
              Gap(16),
              BlocSelector<EmployerFullPositionConfirmBloc, EmployerFullPositionConfirmState, bool>(
                selector: (state) => state.termsAndCondition,
                builder: (context, termsAndCondition) {
                  return _buildCheckListTile(
                    context,
                    value: termsAndCondition,
                    onChanged: (value) {
                      context.read<EmployerFullPositionConfirmBloc>().add(
                            EmployerFullPositionConfirmEvent.onTermsAndConditionChanged(value: value),
                          );
                    },
                    label:
                        "By proceeding, I confirm that we, the employer, are responsible for making payments directly to  the contractor for this full-time position. We understand that ShiftFinder is not responsible for any  disputes, including those arising from non-payment or contract violations.",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckListTile(
    BuildContext context, {
    required bool value,
    required void Function(bool value) onChanged,
    required String label,
  }) {
    return Material(
      color: AppColors.surfaceColor,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(0, -6),
              child: Transform.scale(
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
            ),
            Gap(8),
            Expanded(
              child: BaseText(text: label, fontSize: 12, fontWeight: FontWeight.w500, maxLines: 10),
            )
          ],
        ),
      ),
    );
  }
}
