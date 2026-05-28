import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/app_metric_card.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TradeAnalytics extends GetView<DashboardController> {
  const TradeAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final netTotal = controller.netTradeTotal;
      final bestTrade = controller.bestTrade;
      final worstTrade = controller.worstTrade;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.sectionSpace,
        children: [
          Text(
            "Trade Analytics",
            style: context.text.titleLarge?.copyWith(
              color: context.color.onPrimaryFixedVariant,
            ),
          ),
          Row(
            children: [
              AppMetricCard(
                title: "Net P/L",
                value: _money(netTotal),
                subtitle: "${controller.tradeCount} trades",
                icon: Icons.account_balance_wallet_outlined,
                color: netTotal >= 0 ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              AppMetricCard(
                title: "Win Rate",
                value: "${controller.tradeWinRate.toStringAsFixed(0)}%",
                subtitle:
                    "${controller.winningTrades.length}W / ${controller.losingTrades.length}L",
                icon: Icons.percent,
                color: Colors.blueAccent,
              ),
            ],
          ),
          Row(
            children: [
              AppMetricCard(
                title: "Avg Trade",
                value: _money(controller.averageTradeReturn),
                subtitle: "Per closed trade",
                icon: Icons.analytics_outlined,
                color: controller.averageTradeReturn >= 0
                    ? Colors.teal
                    : Colors.deepOrange,
              ),
              const SizedBox(width: 8),
              AppMetricCard(
                title: "Profit Factor",
                value: _profitFactorText(controller),
                subtitle: "Gross profit / loss",
                icon: Icons.speed_outlined,
                color: Colors.indigo,
              ),
            ],
          ),
          Row(
            children: [
              AppMetricCard(
                title: "Best Trade",
                value: bestTrade == null ? _money(0) : _money(bestTrade.amount),
                subtitle: bestTrade?.notes ?? "No trades",
                icon: Icons.trending_up,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              AppMetricCard(
                title: "Worst Trade",
                value: worstTrade == null
                    ? _money(0)
                    : _money(worstTrade.signedAmount),
                subtitle: worstTrade?.notes ?? "No trades",
                icon: Icons.trending_down,
                color: Colors.red,
              ),
            ],
          ),
        ],
      );
    });
  }

  static String _money(double value) {
    final sign = value < 0 ? "-" : "";
    return "$sign${Utils.moneySymbol}${value.abs().toStringAsFixed(0)}";
  }

  static String _profitFactorText(DashboardController controller) {
    if (controller.grossTradeLoss == 0) {
      return controller.grossTradeProfit == 0 ? "0.00" : "N/A";
    }
    return controller.profitFactor.toStringAsFixed(2);
  }
}
