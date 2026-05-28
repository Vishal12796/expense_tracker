import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/core/utils/utils.dart';
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
              _AnalyticsCard(
                title: "Daily Avg",
                value:
                    "${Utils.moneySymbol}${controller.dailyAverage.toStringAsFixed(0)}",
                icon: Icons.calendar_today_outlined,
                color: Colors.blueAccent,
              ),
              const SizedBox(width: 8),
              _AnalyticsCard(
                title: "Highest Spend",
                value: controller.highestExpense != null
                    ? "${Utils.moneySymbol}${controller.highestExpense!.amount.toInt()}"
                    : "${Utils.moneySymbol}0",
                subtitle: controller.highestExpense?.name ?? "N/A",
                icon: Icons.trending_up,
                color: Colors.redAccent,
              ),
            ],
          ),
        ],
      );
    });
  }
}

class _AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;

  const _AnalyticsCard({
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card.filled(
        color: color.withOpacity(0.1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 12),
              Text(
                title,
                style: context.text.labelMedium?.copyWith(
                  color: context.color.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: context.text.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.color.onSurface,
                ),
              ),

              const SizedBox(height: 2),
              Text(
                subtitle ?? '',
                style: context.text.bodySmall?.copyWith(
                  color: context.color.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
