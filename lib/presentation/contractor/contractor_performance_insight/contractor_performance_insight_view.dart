import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_performance_insight/contractor_performance_insight_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
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
            dates: [])),
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
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(getSize(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*DateRangePickerTile(
                              onDateSelected: (value) {},
                              label: StringConstant.period,
                            ),*/
                        BlocSelector<ContractorPerformanceInsightBloc,
                            ContractorPerformanceInsightState, List<DateTime>>(
                          selector: (state) => state.selectedDateTime,
                          builder: (context, selectedDateTime) {
                            return DateRangePickerTile(
                              label: "Period",
                              selectedDate: selectedDateTime,
                              onDateSelected: (value) {
                                context
                                    .read<ContractorPerformanceInsightBloc>()
                                    .add(ContractorPerformanceInsightEvent
                                        .onDateSelected(context, dates: value));
                              },
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleText(StringConstant.monthIndex),
                            BaseText(
                                text: "July 2024",
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.green),
                          ],
                        ),
                        Row(
                          children: [
                            _MonthlyIndexItem(
                                label: StringConstant.totalEarnings,
                                value: "\$2541.25",
                                icon: SvgImageConstant.dollorRound),
                            Gap(getSize(8)),
                            _MonthlyIndexItem(
                                label: StringConstant.hourWorked,
                                value: "120h 36min",
                                icon: SvgImageConstant.clock),
                            Gap(getSize(8)),
                            _MonthlyIndexItem(
                                label: StringConstant.completedShifts,
                                value: "16",
                                icon: SvgImageConstant.completedShifts),
                          ],
                        ),
                        titleText(StringConstant.earningOverTime),
                        EarningsGraph(),
                        titleText(StringConstant.hoursWorked),
                        HoursChart(),
                        titleText(StringConstant.completedShift),
                        CompletedShiftChart(),
                        /* chartFormat(
                              title: StringConstant.earningOverTime,
                              chart: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                series: [
                                  LineSeries<ChartData, String>(
                                    dataSource: [
                                      ChartData(x: "Week 1", y: 300),
                                      ChartData(x: "Week 2", y: 350),
                                      ChartData(x: "Week 3", y: 300),
                                      ChartData(x: "Week 4", y: 500),
                                    ],
                                    xValueMapper: (datum, _) => datum.x,
                                    yValueMapper: (datum, _) => datum.y,
                                  ),
                                ],
                              ),
                            ), */
                      ],
                    ),
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

  Widget titleText(String title, {TextStyle? textStyle}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(15))
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
        titleText(title),
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

class EarningsGraph extends StatelessWidget {
  const EarningsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: getSize(20),
        ).copyWith(left: getSize(20)),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(getSize(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
              text: StringConstant.hours,
              fontSize: 10,
              textColor: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
            Gap(getSize(15)),
            SizedBox(
              height: getSize(300),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                      rightTitles: AxisTitles(),
                      topTitles: AxisTitles(),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 100,
                          reservedSize: 40,
                          getTitlesWidget: (value, _) => BaseText(
                            text: '\$${value.toInt()}',
                            fontSize: 8,
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          maxIncluded: false,
                          interval: 1,
                          getTitlesWidget: (value, _) {
                            return Padding(
                              padding: EdgeInsets.only(top: getSize(5)),
                              child: BaseText(
                                text: "Week ${value.toInt()}",
                                fontSize: 8,
                              ),
                            );
                            /* switch (value.toInt()) {
                        case 1:
                          return Text('Week 1');
                        case 2:
                          return Text('Week 2');
                        case 3:
                          return Text('Week 3');
                        case 4:
                          return Text('Week 4');
                        default:
                          return Container();
                      } */
                          },
                        ),
                      )),
                  borderData: FlBorderData(
                    show: false,
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  minX: 1,
                  maxX: 5,
                  minY: 0,
                  maxY: 700,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(1, 400), // Week 1
                        FlSpot(2, 489.23), // Week 2
                        FlSpot(3, 450), // Week 3
                        FlSpot(4, 650), // Week 4
                      ],
                      color: AppColors.primaryColor,
                      barWidth: getSize(2),
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.green.withOpacity(0.2),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryColor.withOpacity(0.2),
                            AppColors.primaryColor.withOpacity(0.1),
                            AppColors.transparent,
                          ],
                        ),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: getSize(4),
                            color: AppColors.white,
                            strokeWidth: getSize(3),
                            strokeColor: AppColors.primaryColor,
                          );
                        },
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (spots) {
                        return spots.map((spot) {
                          return LineTooltipItem(
                            '\$${spot.y.toStringAsFixed(2)}',
                            const TextStyle(color: Colors.black),
                          );
                        }).toList();
                      },
                    ),
                    handleBuiltInTouches: false,
                  ),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: 489.23,
                        color: AppColors.green,
                        strokeWidth: 0,
                        label: HorizontalLineLabel(
                          show: true,
                          alignment: Alignment.center,
                          labelResolver: (_) => "\$ 489.23",
                          style: TextStyle(
                            color: AppColors.green,
                            fontSize: getFontSize(10),
                            fontWeight: FontWeight.bold,
                          ),
                          padding: EdgeInsets.only(bottom: getSize(15)),
                        ),
                      ),
                      HorizontalLine(
                        y: 300,
                        color: AppColors.green,
                        strokeWidth: 0,
                        label: HorizontalLineLabel(
                          show: true,
                          alignment: Alignment.center,
                          labelResolver: (_) => "\$ 300",
                          style: TextStyle(
                            color: AppColors.green,
                            fontSize: getFontSize(10),
                            fontWeight: FontWeight.bold,
                          ),
                          padding: EdgeInsets.only(bottom: getSize(15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class HoursChart extends StatelessWidget {
  const HoursChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: getSize(20),
      ).copyWith(left: getSize(20)),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(getSize(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseText(
            text: StringConstant.hours,
            fontSize: 10,
            textColor: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
          Gap(getSize(15)),
          SizedBox(
            height: getSize(300),
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) => BaseText(
                          text: '${value.toInt()} h',
                          fontSize: 8,
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, _) {
                          return Padding(
                            padding: EdgeInsets.only(top: getSize(5)),
                            child: BaseText(
                              text: "Week ${value.toInt()}",
                              fontSize: 8,
                            ),
                          );
                          /* switch (value.toInt()) {
                            case 1:
                              return Text('Week 1');
                            case 2:
                              return Text('Week 2');
                            case 3:
                              return Text('Week 3');
                            case 4:
                              return Text('Week 4');
                            default:
                              return Container();
                          } */
                        },
                      ),
                    )),
                // minX: 1,
                // maxX: 5,
                minY: 0,
                maxY: 40,
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 18,
                        color: AppColors.primaryColor,
                        width: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 26,
                        color: AppColors.primaryColor,
                        width: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 14,
                        color: AppColors.primaryColor,
                        width: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 32,
                        color: AppColors.primaryColor,
                        width: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ],
                barTouchData: BarTouchData(
                  // touchCallback: (FlTouchEvent event,  touchResponse) {
                  //   if (touchResponse.spot != null) {
                  //     setState(() {
                  //       selectedIndex = touchResponse.spot!.touchedBarGroupIndex + 1;
                  //       print('Selected bar index: $selectedIndex'); // Debug log
                  //     });
                  //   }
                  // },
                  handleBuiltInTouches: false,
                ),

                /*   extraLinesData: ExtraLinesData(
                  verticalLines: [
                    VerticalLine(
                      x: 1,
                      color: AppColors.green,
                      strokeWidth: 1,
                      dashArray: [5, 5],
                      label: VerticalLineLabel(
                        show: true,
                        alignment: Alignment.topCenter,
                        labelResolver: (_) => "18 h",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: getFontSize(10),
                          fontWeight: FontWeight.bold,
                        ),
                        padding: EdgeInsets.only(bottom: getSize(10)),
                      ),
                    ),
                    VerticalLine(
                      x: 3,
                      color: AppColors.green,
                      strokeWidth: 1,
                      dashArray: [5, 5],
                      label: VerticalLineLabel(
                        show: true,
                        alignment: Alignment.topCenter,
                        labelResolver: (_) => "12 h",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: getFontSize(10),
                          fontWeight: FontWeight.bold,
                        ),
                        padding: EdgeInsets.only(bottom: getSize(10)),
                      ),
                    ),
                  ],
                ),
               */
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompletedShiftChart extends StatelessWidget {
  const CompletedShiftChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: getSize(20),
      ).copyWith(left: getSize(20)),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(getSize(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseText(
            text: StringConstant.shifts,
            fontSize: 10,
            textColor: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
          Gap(getSize(15)),
          SizedBox(
            height: getSize(300),
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) => BaseText(
                          text: '${value.toInt()}',
                          fontSize: 8,
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, _) {
                          return Padding(
                            padding: EdgeInsets.only(top: getSize(5)),
                            child: BaseText(
                              text: "Week ${value.toInt()}",
                              fontSize: 8,
                            ),
                          );
                        },
                      ),
                    )),
                minY: 0,
                maxY: 7,
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 4,
                        color: AppColors.primaryColor,
                        width: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 3,
                        color: AppColors.primaryColor,
                        width: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 3,
                        color: AppColors.primaryColor,
                        width: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 6,
                        color: AppColors.primaryColor,
                        width: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ],
                barTouchData: BarTouchData(
                  handleBuiltInTouches: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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

class CommonLineGraph extends StatelessWidget {
  const CommonLineGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
