import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/views/dashboard/widgets/trade_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/extension/padding_extension.dart';
import '../../../core/utils/utils.dart';

class MonthlyTrades extends GetView<DashboardController> {
  const MonthlyTrades({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.sectionSpace,
        children: [
          const TradeAnalytics(),
          Text(
            "Recent Trades",
            style: context.text.titleLarge?.copyWith(
              color: context.color.onPrimaryFixedVariant,
            ),
          ),
          Obx(() {
            final trades = controller.recentTradesForSelectedYear;

            if (trades.isEmpty) {
              return SizedBox(
                height: 120,
                child: Center(
                  child: Text(
                    "No trades for ${controller.selectedYear.value}",
                    style: context.text.titleMedium?.copyWith(
                      color: context.color.secondary,
                    ),
                  ),
                ),
              );
            }

            return Column(
              children: trades.map((trade) {
                final color = trade.isProfit ? Colors.green : Colors.red;

                return Card.filled(
                  elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      spacing: 12,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: color.withValues(alpha: 0.16),
                          child: Icon(
                            trade.isProfit
                                ? Icons.trending_up
                                : Icons.trending_down,
                            size: 20,
                            color: color,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trade.notes,
                                style: context.text.labelLarge?.copyWith(
                                  color: context.color.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                formatDate(trade.date),
                                style: context.text.labelSmall?.copyWith(
                                  color: context.color.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${trade.isProfit ? "+" : "-"}${Utils.moneySymbol}${trade.amount.toStringAsFixed(0)}",
                          style: context.text.titleMedium?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
          const SizedBox(height: 24),
        ],
      ),
    ).screenPadding();
  }
}
