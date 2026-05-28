import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/views/investment/add_trade/controller/add_trade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TradeSummaryHeader extends StatelessWidget {
  final AddTradeController controller;

  const TradeSummaryHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isProfit = controller.tradeResult.value == TradeResult.profit;
      final color = isProfit
          ? const Color(0xFF0F766E)
          : const Color(0xFFB42318);
      final backgroundColor = isProfit
          ? const Color(0xFFE6F4F1)
          : const Color(0xFFFFE9E7);

      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller.amountController,
        builder: (context, amountValue, _) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withValues(alpha: 0.14)),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.82),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    isProfit
                        ? Icons.trending_up_rounded
                        : Icons.trending_down_rounded,
                    color: color,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.isEditing ? "Editing Trade" : "New Trade",
                        style: context.text.labelSmall?.copyWith(
                          color: context.color.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _amountText(amountValue.text),
                        style: context.text.headlineLarge?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isProfit ? "Profit trade" : "Loss trade",
                        style: context.text.labelMedium?.copyWith(
                          color: context.color.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  String _amountText(String value) {
    final amount = double.tryParse(value.trim());
    if (amount == null || amount <= 0) {
      return "${Utils.moneySymbol}0";
    }
    return "${Utils.moneySymbol}${amount.toStringAsFixed(0)}";
  }
}
