import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/app_metric_card.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseAnalytics extends GetView<DashboardController> {
  const ExpenseAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.sectionSpace,
        children: [
          Text(
            "Insights",
            style: context.text.titleLarge?.copyWith(
              color: context.color.onPrimaryFixedVariant,
            ),
          ),
          Row(
            children: [
              AppMetricCard(
                title: "Daily Avg",
                value:
                    "${Utils.moneySymbol}${controller.dailyAverage.toStringAsFixed(0)}",
                icon: Icons.calendar_today_outlined,
                color: Colors.blueAccent,
                padding: const EdgeInsets.all(16),
                iconSize: 24,
              ),
              const SizedBox(width: 8),
              AppMetricCard(
                title: "Highest Spend",
                value: controller.highestExpense != null
                    ? "${Utils.moneySymbol}${controller.highestExpense!.amount.toInt()}"
                    : "${Utils.moneySymbol}0",
                subtitle: controller.highestExpense?.name ?? "N/A",
                icon: Icons.trending_up,
                color: Colors.redAccent,
                padding: const EdgeInsets.all(16),
                iconSize: 24,
              ),
            ],
          ),
        ],
      );
    });
  }
}
