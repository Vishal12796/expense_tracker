import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/extension/context_extension.dart';

class HeaderNumbers extends GetView<DashboardController> {
  const HeaderNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final profitLoss = controller.netTradeTotal;
      final profitLossColor = profitLoss >= 0
          ? const Color(0xFF0F766E)
          : const Color(0xFFB42318);

      return Row(
        spacing: 8,
        children: [
          _HeaderMetricCard(
            title: "Expenses",
            value: "${Utils.moneySymbol}${controller.totalExpenses.toInt()}",
            icon: Icons.receipt_long_outlined,
            color: const Color(0xFFB93815),
            backgroundColor: const Color(0xFFFFEDE6),
          ),
          _HeaderMetricCard(
            title: "Profit/Loss",
            value: _money(profitLoss),
            icon: profitLoss >= 0
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            color: profitLossColor,
            backgroundColor: profitLoss >= 0
                ? const Color(0xFFE6F4F1)
                : const Color(0xFFFFE9E7),
          ),
        ],
      );
    });
  }

  static String _money(double value) {
    final sign = value < 0 ? "-" : "";
    return "$sign${Utils.moneySymbol}${value.abs().toInt()}";
  }
}

class _HeaderMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const _HeaderMetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card.filled(
        color: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withValues(alpha: 0.14)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.text.labelSmall?.copyWith(
                        color: context.color.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: context.text.titleLarge?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
