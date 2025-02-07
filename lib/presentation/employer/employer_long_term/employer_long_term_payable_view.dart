import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_long_term_payable/employer_long_term_payable_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermPayableView")
class EmployerLongTermPayableView extends StatelessWidget {
  const EmployerLongTermPayableView({
    super.key,
    required this.employerLongTermSuccessDto,
    this.postId,
    required this.postShiftDTO,
  });

  final EmployerLongTermSuccessDto employerLongTermSuccessDto;
  final PostShiftDTO postShiftDTO;
  final int? postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermPayableBloc>(),
      child: Builder(builder: (context) {
        return BlocSelector<EmployerLongTermPayableBloc,
            EmployerLongTermPayableState, bool>(
          selector: (state) {
            return state.postDataLoading;
          },
          builder: (context, postDataLoading) {
            return Stack(
              children: [
                Scaffold(
                  bottomNavigationBar: SafeArea(
                    minimum: EdgeInsets.all(getSize(24)),
                    child: CommonButton(
                      onPressed: () async {
                        final result = await AppDialog.showCommonDialog(
                          context: context,
                          title:
                              "${(postId == null || postId == -1) ? "Post" : "Update"} Long-Term Position",
                          content:
                              "Are you sure you want to post ${(postId == null || postId == -1) ? "post" : "update"} long-term position?",
                          successLabel: (postId == null || postId == -1)
                              ? "Post"
                              : "Update",
                        );
                        if (result ?? false) {
                          context.read<EmployerLongTermPayableBloc>().add(
                                EmployerLongTermPayableEvent.onPostShift(
                                  context: context,
                                  id: employerLongTermSuccessDto.id ?? -1,
                                  totalVacancy: employerLongTermSuccessDto
                                          .number_of_vacancie ??
                                      -1,
                                  postId: postId,
                                  employer: employerLongTermSuccessDto,
                                  postShift: postShiftDTO,
                                ),
                              );
                        }
                      },
                      buttonText:
                          "${(postId == null || postId == -1) ? "Post" : "Update"} The Shift",
                    ),
                  ),
                  appBar: CommonAppBar(
                      onBackPressed: () => context.router.maybePop(),
                      title: StringConstant.payables),
                  body: Padding(
                    padding: EdgeInsets.all(getSize(18)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(
                          text: StringConstant.shiftFinderServiceFeeCalculation,
                          fontFamily: "Aclonica",
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                        ),
                        Gap(getSize(8)),
                        Padding(
                          padding: EdgeInsets.all(getSize(12)),
                          child: BaseText(
                            text: StringConstant.longTermPaybleDesc,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center,
                            textColor: Colors.black.withOpacity(0.8),
                            maxLines: 10,
                          ),
                        ),
                        Gap(getSize(22)),
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor.withOpacity(0.2),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getSize(18), horizontal: getSize(22)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: BaseText(
                                      text:
                                          StringConstant.totalMonthsOfContract,
                                      fontSize: 13),
                                ),
                                BaseText(
                                  text:
                                      "${employerLongTermSuccessDto.total_months ?? ""} Months",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(getSize(18)),
                        Material(
                          color: AppColors.surfaceColor,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getSize(18), horizontal: getSize(22)),
                            child: Column(
                              children: [
                                _buildSpaceBetweenTile(context,
                                    label: StringConstant.numberOfVacancies,
                                    value:
                                        "${employerLongTermSuccessDto.number_of_vacancie ?? ""}"),
                                Gap(getSize(14)),
                                _buildSpaceBetweenTile(context,
                                    label: StringConstant.monthlyServiceFee,
                                    value:
                                        "\$${employerLongTermSuccessDto.monthly_service_fee ?? " "}"),
                                Gap(getSize(14)),
                                _buildSpaceBetweenTile(context,
                                    label: StringConstant.totalMonths,
                                    value:
                                        "${employerLongTermSuccessDto.total_months ?? ""}"),
                                Divider(height: getSize(28)),
                                _buildSpaceBetweenTile(
                                  context,
                                  label: StringConstant.totalServiceFee,
                                  value:
                                      "\$${employerLongTermSuccessDto.total_amount_payable ?? ""}",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (postDataLoading) CenterLoadingIndicator()
              ],
            );
          },
        );
      }),
    );
  }

  Widget _buildSpaceBetweenTile(
    BuildContext context, {
    required String label,
    required String value,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: BaseText(
            text: label,
            fontSize: 13,
            textColor: AppColors.black.withOpacity(0.7),
          ),
        ),
        BaseText(
            text: value,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontSize: fontSize ?? 13),
      ],
    );
  }
}
