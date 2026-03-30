import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_performance_insight/contractor_performance_insight_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/contractor_main/profile/performance_insight_dto/performance_insight_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/no_data_ui.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage(name: "ContractorPerformanceInsightView")
class ContractorPerformanceInsightView extends StatelessWidget {
  const ContractorPerformanceInsightView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorPerformanceInsightBloc>()
        ..add(ContractorPerformanceInsightEvent.onDateSelected(context,
            selectedDate: null)),
      child: BlocBuilder<ContractorPerformanceInsightBloc,
          ContractorPerformanceInsightState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.performanceInsights,
            ),
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(getSize(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocSelector<ContractorPerformanceInsightBloc,
                          ContractorPerformanceInsightState, DateTime?>(
                        selector: (state) => state.selectedMonth,
                        builder: (context, selectedDateTime) {
                          return MonthPickerTile(
                            label: StringConstant.period,
                            selectedMonth: selectedDateTime,
                            onDateSelected: (value) {
                              DateTime updatedDate = value.copyWith(day: 2);
                              context
                                  .read<ContractorPerformanceInsightBloc>()
                                  .add(ContractorPerformanceInsightEvent
                                      .onDateSelected(context,
                                          selectedDate: updatedDate));
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: (state.selectedMonth == null)
                            ? Center(
                                child: NoDataText(
                                  title: "",
                                  description: StringConstant
                                      .pleaseSelectMonthToViewPerformanceInsights,
                                ),
                              )
                            : (state.insightDetail == null)
                                ? Center(
                                    child: NoDataText(
                                      title: "",
                                      description: StringConstant.noResultFound,
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: getSize(10)),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              titleText(
                                                  StringConstant.monthIndex,
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              BaseText(
                                                  text: (state.insightDetail
                                                              ?.date !=
                                                          null)
                                                      ? DateFormat('MMM yyyy').format(
                                                          CustomDateTimeFormat
                                                              .timeStampToDateTime(
                                                                  (state.insightDetail
                                                                          ?.date ??
                                                                      -1)))
                                                      : (state.selectedMonth !=
                                                              null)
                                                          ? DateFormat(
                                                                  'MMM yyyy')
                                                              .format(state
                                                                  .selectedMonth!)
                                                          : "",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  textColor: AppColors.green),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              _MonthlyIndexItem(
                                                  label: StringConstant
                                                      .totalEarnings,
                                                  value:
                                                      "\$${state.insightDetail?.total_earnings?.toStringAsFixed(2) ?? 0.0}",
                                                  icon: SvgImageConstant
                                                      .dollorRound),
                                              Gap(getSize(8)),
                                              _MonthlyIndexItem(
                                                  label:
                                                      StringConstant.hourWorked,
                                                  value: state.insightDetail
                                                          ?.total_hours ??
                                                      "00h 00min",
                                                  icon: SvgImageConstant.clock),
                                              Gap(getSize(8)),
                                              _MonthlyIndexItem(
                                                  label: StringConstant
                                                      .completedShifts,
                                                  value:
                                                      "${state.insightDetail?.completed_shifts ?? 0}",
                                                  icon: SvgImageConstant
                                                      .completedShifts),
                                            ],
                                          ),
                                          EarningChart(context, state),
                                          HoursChart(context, state),
                                          CompletedShiftChart(context, state),
                                        ],
                                      ),
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
                if (state.isLoading) CenterLoadingIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget EarningChart(
      BuildContext context, ContractorPerformanceInsightState state) {
    return chartFormat(
      title: StringConstant.earningOverTime,
      chart: SfCartesianChart(
        title: ChartTitle(
          text: StringConstant.earnings,
          alignment: ChartAlignment.near,
          textStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: getFontSize(8),
          ),
        ),
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          axisLine: AxisLine(width: 0, color: Colors.transparent),
          majorTickLines: MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          // minorGridLines: MinorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0, color: Colors.transparent),
          majorTickLines: MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          minorGridLines: MinorGridLines(width: 0),
          numberFormat: NumberFormat("\$0"),
        ),
        series: [
          AreaSeries<InsightListDTO, String>(
            color: AppColors.primaryColor,
            // width: 2,
            borderWidth: 2,
            borderColor: AppColors.primaryColor,
            markerSettings: MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              height: getSize(10),
              width: getSize(10),
              borderWidth: 2,
              color: AppColors.white,
              borderColor: AppColors.primaryColor,
            ),
            dataLabelSettings: DataLabelSettings(
              isVisible: (state.selectedEarningPoint != null) ? true : false,
              builder: (data, point, series, pointIndex, _) {
                if (pointIndex == state.selectedEarningPoint?.pointIndex) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(8),
                      vertical: getSize(2),
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      '\$${point.y}',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  );
                }
                return Container();
              },
              labelAlignment: ChartDataLabelAlignment.top,
            ),
            onPointTap: (point) {
              context
                  .read<ContractorPerformanceInsightBloc>()
                  .add(ContractorPerformanceInsightEvent.onPointSelect(
                    context,
                    selectedPoint: point,
                  ));
            },
            dataSource: state.insightDetail?.earning_over_time?.list ?? [],
            xValueMapper: (InsightListDTO data, _) => data.name,
            yValueMapper: (InsightListDTO data, _) => data.value,

            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryColor.withValues(alpha: 0.25),
                AppColors.primaryColor.withValues(alpha: 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget HoursChart(
      BuildContext context, ContractorPerformanceInsightState state) {
    return chartFormat(
      title: StringConstant.hoursWorked,
      chart: SfCartesianChart(
        title: ChartTitle(
          text: StringConstant.hours,
          alignment: ChartAlignment.near,
          textStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: getFontSize(8),
          ),
        ),
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          axisLine: AxisLine(width: 0, color: Colors.transparent),
          majorTickLines: MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          // minorGridLines: MinorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0, color: Colors.transparent),
          majorTickLines: MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          minorGridLines: MinorGridLines(width: 0),
          numberFormat: NumberFormat("0 'h'"),
        ),
        series: [
          ColumnSeries<HourWorkedDetailDTO, String>(
            isTrackVisible: false,
            dataSource: state.insightDetail?.hours_worked?.list ?? [],
            xValueMapper: (HourWorkedDetailDTO data, _) => data.name,
            yValueMapper: (HourWorkedDetailDTO data, _) =>
                convertTimeToDecimal(data.value ?? ""),
            color: AppColors.primaryColor,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.darkGreen,
                AppColors.primaryColor,
                AppColors.primaryColor.withValues(alpha: 0.6),
              ],
            ),
            width: 0.4,
            borderRadius: BorderRadius.circular(10),
            trackBorderWidth: 0,
            trackPadding: getSize(5),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.outer,
              builder: (data, point, series, pointIndex, _) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(10),
                    vertical: getSize(2),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '${point.y} h',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget CompletedShiftChart(
      BuildContext context, ContractorPerformanceInsightState state) {
    return chartFormat(
      title: StringConstant.completedShift,
      chart: SfCartesianChart(
        title: ChartTitle(
          text: StringConstant.shifts,
          alignment: ChartAlignment.near,
          textStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: getFontSize(8),
          ),
        ),
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          axisLine: AxisLine(width: 0, color: Colors.transparent),
          majorTickLines: MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          // minorGridLines: MinorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0, color: Colors.transparent),
          majorTickLines: MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          minorGridLines: MinorGridLines(width: 0),
        ),
        series: [
          ColumnSeries<InsightListDTO, String>(
            isTrackVisible: false,
            dataSource: state.insightDetail?.completed_shift_map?.list ?? [],
            xValueMapper: (InsightListDTO data, _) => data.name,
            yValueMapper: (InsightListDTO data, _) => data.value,
            color: AppColors.primaryColor,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.darkGreen,
                AppColors.primaryColor,
                AppColors.primaryColor.withValues(alpha: 0.6),
              ],
            ),
            width: 0.4,
            borderRadius: BorderRadius.circular(10),
            trackBorderWidth: 0,
            trackPadding: getSize(5),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.outer,
              builder: (data, point, series, pointIndex, _) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(10),
                    vertical: getSize(2),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '${point.y}',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget titleText(String title, {TextStyle? textStyle}) {
    return Padding(
      padding: EdgeInsets.only(top: getSize(20), bottom: getSize(10))
          .copyWith(left: getSize(18)),
      child: BaseText(
        text: title,
        fontSize: textStyle?.fontSize ?? 12,
        textColor: textStyle?.color ?? AppColors.black,
        fontWeight: textStyle?.fontWeight ?? FontWeight.w500,
      ),
    );
  }

  Widget chartFormat({
    required String title,
    required Widget chart,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleText(title, textStyle: TextStyle(fontWeight: FontWeight.w600)),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: getSize(15), horizontal: getSize(5)),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(getSize(15))),
          child: chart,
        ),
      ],
    );
  }
}

double convertTimeToDecimal(String time) {
  int hours = 0;
  int minutes = 0;

  // Regular expressions to extract hours and minutes
  RegExp hourRegex = RegExp(r"(\d+)h");
  RegExp minRegex = RegExp(r"(\d+)min");

  // Extract hours if present
  Match? hourMatch = hourRegex.firstMatch(time);
  if (hourMatch != null) {
    hours = int.parse(hourMatch.group(1)!);
  }

  // Extract minutes if present
  Match? minMatch = minRegex.firstMatch(time);
  if (minMatch != null) {
    minutes = int.parse(minMatch.group(1)!);
  }

  // Convert time to decimal format
  double decimalMinutes = (minutes / 100);
  double decimalTime = hours + double.parse(decimalMinutes.toStringAsFixed(2));

  return double.parse(decimalTime.toStringAsFixed(2)); // Final rounding
}

class ChartData {
  ChartData({required this.x, required this.y});

  final String x;
  final num y;
}

class _MonthlyIndexItem extends StatelessWidget {
  const _MonthlyIndexItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: getSize(5), vertical: getSize(13)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  icon,
                  colorFilter:
                      ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                  height: getSize(14),
                  width: getSize(14),
                ),
                Gap(getSize(4)),
                Flexible(
                    child: BaseText(
                        text: label,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                        fontSize: 10)),
              ],
            ),
            Gap(getSize(6)),
            FittedBox(
                child: BaseText(
                    text: value, fontSize: 11, fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
