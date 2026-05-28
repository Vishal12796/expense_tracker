import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/extension/padding_extension.dart';

class ExpensesLineChart extends GetView<DashboardController> {
  const ExpensesLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final monthlyTotals = controller.monthlyTotalsForYear;
      
      // Check if all months are zero to show a placeholder
      if (monthlyTotals.every((element) => element == 0)) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Text(
              "No data for year ${controller.selectedYear.value}",
              style: context.text.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ),
        );
      }

      final spots = monthlyTotals.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value);
      }).toList();

      double maxAmount = monthlyTotals.reduce((a, b) => a > b ? a : b);
      if (maxAmount == 0) maxAmount = 1000;

      // Logic to find a clean interval for Y-axis (e.g., 500, 1000, 2000, 5000)
      double interval;
      if (maxAmount <= 2000) {
        interval = 500;
      } else if (maxAmount <= 5000) {
        interval = 1000;
      } else if (maxAmount <= 10000) {
        interval = 2000;
      } else if (maxAmount <= 25000) {
        interval = 5000;
      } else {
        interval = 10000;
      }

      double maxY = ((maxAmount / interval).ceil() * interval).toDouble();
      if (maxY == 0) maxY = interval * 4;

      return AspectRatio(
        aspectRatio: 1.7,
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 5, top: 40, bottom: 10),
          child: LineChart(
            LineChartData(
              maxY: maxY,
              minY: 0,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: interval,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.1),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );
                },
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    interval: 1, 
                    getTitlesWidget: (value, meta) {
                      final monthIndex = value.toInt();
                      if (monthIndex < 0 || monthIndex >= 12) return const SizedBox.shrink();

                      final date = DateTime(controller.selectedYear.value, monthIndex + 1);
                      return SideTitleWidget(
                        meta: meta,
                        space: 10,
                        child: Text(
                          DateFormat('MMM').format(date),
                          style: context.text.labelSmall?.copyWith(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: interval,
                    getTitlesWidget: (value, meta) {
                      if (value == 0) return const SizedBox.shrink();
                      
                      // Formatting large numbers with 'k'
                      String label;
                      if (value >= 1000) {
                        label = '${(value / 1000).toStringAsFixed(0)}k';
                      } else {
                        label = value.toInt().toString();
                      }

                      return SideTitleWidget(
                        meta: meta,
                        child: Text(
                          '${Utils.moneySymbol}$label',
                          style: context.text.labelSmall?.copyWith(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                    reservedSize: 45,
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  curveSmoothness: 0.35,
                  color: Colors.blueAccent,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent.withOpacity(0.2),
                        Colors.blueAccent.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                handleBuiltInTouches: true,
                getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      FlLine(
                        color: Colors.grey.withOpacity(0.5),
                        strokeWidth: 1,
                        dashArray: [4, 4],
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeColor: Colors.blueAccent,
                          );
                        },
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (spot) => Colors.white,
                  tooltipPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  tooltipBorder: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((LineBarSpot touchedSpot) {
                      final monthIndex = touchedSpot.x.toInt();
                      final date = DateTime(controller.selectedYear.value, monthIndex + 1);
                      return LineTooltipItem(
                        '${DateFormat('MMMM yyyy').format(date)}\n',
                        context.text.labelMedium!.copyWith(
                          color: Colors.grey,
                          fontSize: 8,
                        ),
                        children: [
                          TextSpan(
                            text: '${Utils.moneySymbol}${touchedSpot.y.toStringAsFixed(2)}',
                            style: context.text.titleMedium?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
