import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/monthly_statement/monthly_statement_bloc.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/custom_multi_date_picker/calendar_date_picker2.dart';
import 'package:shift/presentation/core/widgets/custom_multi_date_picker/calendar_date_picker2_config.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "MonthlyStatementView")
class MonthlyStatementView extends StatelessWidget {
  const MonthlyStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MonthlyStatementBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () => context.router.maybePop(),
            title: 'Monthly Statements',
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(text: "Period", fontSize: 10),
                Gap(8),
                Material(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: InkWell(
                    onTap: () {
                      pickMultiDateDialog(
                        context,
                        onDateSelected: (value) {
                          context.read<MonthlyStatementBloc>().add(MonthlyStatementEvent.onDateSelected(dates: value));
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgImageConstant.calendar, height: 20, width: 20),
                          Gap(8),
                          Expanded(
                            child: BlocSelector<MonthlyStatementBloc, MonthlyStatementState, List<DateTime>>(
                              selector: (state) => state.selectedDateTime,
                              builder: (context, selectedDateTime) {
                                final label = selectedDateTime.isEmpty ? "Choose Date Range" : _getFormattedString(selectedDateTime);
                                return BaseText(
                                  text: label,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                );
                              },
                            ),
                          ),
                          SvgPicture.asset(SvgImageConstant.rightArrow, height: 15, width: 15),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(16),
                BlocBuilder<MonthlyStatementBloc, MonthlyStatementState>(
                  builder: (context, state) {
                    return BaseTileDecoration(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox.square(
                                dimension: 60,
                                child: Image.asset(PngImageConstants.leafWithBG),
                              ),
                              Gap(8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: BaseText(text: "Louis Vuitton Pvt. Ltd.", fontWeight: FontWeight.w600, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    BaseText(text: "(Healthcare - 2DFG175)", fontSize: 12, fontWeight: FontWeight.w400),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          SvgImageConstant.location,
                                          colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                                          height: 24,
                                          width: 24,
                                        ),
                                        Expanded(
                                          child: BaseText(
                                            text: "4517 Washington Manchester, Kentucky 39495",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Gap(8),
                          Divider(),
                          Gap(12),
                          Material(
                            color: AppColors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BaseText(text: "Statement Details", fontSize: 10, fontWeight: FontWeight.w500),
                                  Flexible(
                                    child: BaseText(
                                      text: _getFormattedString(state.selectedDateTime),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

String _getFormattedString(List<DateTime> dates) {
  if (dates.isEmpty) return "";
  final firstDate = dates.first;
  final lastDate = dates.last;

  final formattedDate = "${DateFormat("dd MMM").format(firstDate)} to ${DateFormat("dd MMM").format(lastDate)}, ${lastDate.year}";
  return formattedDate;
}
