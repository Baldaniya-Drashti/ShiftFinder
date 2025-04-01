import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/employer_long_term_authorize_payment/employer_long_term_authorize_payment_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_long_term_applicant/employer_long_term_applicant_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermAuthorizePaymentView")
class EmployerLongTermAuthorizePaymentView extends StatelessWidget {
  final EmployerLongTermApplicantDto employerApplicantsDto;

  const EmployerLongTermAuthorizePaymentView(
      {super.key, required this.employerApplicantsDto});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermAuthorizePaymentBloc>(),
      child: BlocSelector<EmployerLongTermAuthorizePaymentBloc,
          EmployerLongTermAuthorizePaymentState, bool>(
        selector: (state) => state.postDataLoading,
        builder: (context, postDataLoading) {
          return Stack(
            children: [
              Scaffold(
                bottomNavigationBar: SafeArea(
                  minimum: EdgeInsets.all(20),
                  child: CommonButton(
                    onPressed: () {
                      context.read<EmployerLongTermAuthorizePaymentBloc>().add(
                            EmployerLongTermAuthorizePaymentEvent
                                .onAuthorizePayment(
                                    context, employerApplicantsDto.id ?? -1),
                          );
                    },
                    buttonText: StringConstant.authorizePayment,
                  ),
                ),
                appBar: CommonAppBar(
                    onBackPressed: () => context.router.maybePop(),
                    title: StringConstant.accept),
                body: SingleChildScrollView(
                  padding: EdgeInsets.all(getSize(22)).copyWith(top: 0),
                  child: Column(
                    children: [
                      SvgPicture.asset(SvgImageConstant.securePayment,
                          height: 60),
                      Gap(getSize(24)),
                      BaseText(
                        text: StringConstant.authorizePayment,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Aclonica",
                        textAlign: TextAlign.center,
                      ),
                      Gap(getSize(12)),
                      BaseText(
                        text: StringConstant.paymentProcessConfirmationDesc,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        textAlign: TextAlign.center,
                      ),
                      Gap(getSize(10)),
                      BaseText(
                        text:
                            "You also authorize ShiftFinder to withdraw the monthly service fee at the end of each month for the contract duration. The first monthly fee will be withdrawn 30 days after ${DateFormat("dd MMM yyy").format(employerApplicantsDto.start_date ?? DateTime.now())}.",
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        textAlign: TextAlign.center,
                      ),
                      Gap(getSize(10)),
                      BaseText(
                        text: StringConstant.shiftFinderServiceFeePaymentDesc,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        textAlign: TextAlign.center,
                      ),
                      Gap(getSize(30)),
                      Material(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(getSize(16)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildSpaceBetweenTile(
                                context,
                                label: StringConstant.totalMonthsOfContract,
                                value: employerApplicantsDto.total_months ?? "",
                              ),
                              Gap(getSize(8)),
                              _buildSpaceBetweenTile(
                                context,
                                label:
                                    StringConstant.shiftFinderMonthlyServiceFee,
                                value:
                                    employerApplicantsDto.monthly_service_fee ??
                                        "",
                              ),
                              Gap(getSize(8)),
                              _buildSpaceBetweenTile(
                                context,
                                label: StringConstant.totalServiceFeePayable,
                                value: employerApplicantsDto
                                        .total_amount_payable ??
                                    "",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (postDataLoading) CenterLoadingIndicator(),
            ],
          );
        },
      ),
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
            fontSize: 12,
            textColor: AppColors.black.withValues(alpha: 0.7),
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
