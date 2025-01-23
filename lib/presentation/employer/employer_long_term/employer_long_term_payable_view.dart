import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_long_term_payable/employer_long_term_payable_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermPayableView")
class EmployerLongTermPayableView extends StatelessWidget {
  const EmployerLongTermPayableView({super.key, required this.employerLongTermSuccessDto});

  final EmployerLongTermSuccessDto employerLongTermSuccessDto;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermPayableBloc>(),
      child: Builder(builder: (context) {
        return BlocSelector<EmployerLongTermPayableBloc, EmployerLongTermPayableState, bool>(
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
                          title: "Post Long-Term Position",
                          content: "Are you sure you want to post this long-term position?",
                          successLabel: "Post",
                        );
                        if (result ?? false) {
                          context.read<EmployerLongTermPayableBloc>().add(
                                EmployerLongTermPayableEvent.onPostShift(
                                  context: context,
                                  id: employerLongTermSuccessDto.id ?? -1,
                                  totalVacancy: employerLongTermSuccessDto.number_of_vacancie ?? -1,
                                ),
                              );
                        }
                      },
                      buttonText: "Post The Shift",
                    ),
                  ),
                  appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Payables"),
                  body: Padding(
                    padding: EdgeInsets.all(getSize(18)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(
                          text: "ShiftFinder Service Fee Calculation",
                          fontFamily: "Aclonica",
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                        ),
                        Gap(getSize(8)),
                        Padding(
                          padding: EdgeInsets.all(getSize(12)),
                          child: BaseText(
                            text:
                                "The ShiftFinder service fee is based on the total duration of the contract. If the contract duration is 15 days or more into the next month, it will be rounded up to the full month. For example, 4 months and 16 days will be charged as 5 months, while 4 months and 14 days will be charged as 4 months.",
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
                          color: Color(0xFFC1F0C8),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: getSize(18), horizontal: getSize(22)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: BaseText(text: "Total Months of Contract", fontSize: 13),
                                ),
                                BaseText(
                                    text: "${employerLongTermSuccessDto.total_months ?? ""} Months",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ],
                            ),
                          ),
                        ),
                        Gap(getSize(18)),
                        Material(
                          color: AppColors.surfaceColor,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: getSize(18), horizontal: getSize(22)),
                            child: Column(
                              children: [
                                _buildSpaceBetweenTile(context,
                                    label: "Number of Vacancy", value: "${employerLongTermSuccessDto.number_of_vacancie ?? ""}"),
                                Gap(getSize(14)),
                                _buildSpaceBetweenTile(context,
                                    label: "Monthly Service Fee", value: "\$${employerLongTermSuccessDto.monthly_service_fee ?? " "}"),
                                Gap(getSize(14)),
                                _buildSpaceBetweenTile(context,
                                    label: "Total Months", value: "${employerLongTermSuccessDto.total_months ?? ""}"),
                                Divider(
                                  height: 28,
                                ),
                                _buildSpaceBetweenTile(context,
                                    label: "Total Service Fee",
                                    value: "\$${employerLongTermSuccessDto.total_amount_payable ?? ""}",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
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
        BaseText(text: value, fontWeight: fontWeight ?? FontWeight.w400, fontSize: fontSize ?? 13),
      ],
    );
  }
}
