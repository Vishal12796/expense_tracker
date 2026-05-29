import 'package:expense_tracker/views/investment/trade_list/controller/trade_list_controller.dart';
import 'package:expense_tracker/core/dialog/common_dialog.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:expense_tracker/views/investment/trade_list/widgets/trade_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/extension/context_extension.dart';

class TradesListScreen extends StatefulWidget {
  const TradesListScreen({super.key});

  @override
  State<TradesListScreen> createState() => _TradesListScreenState();
}

class _TradesListScreenState extends State<TradesListScreen>
    with AutomaticKeepAliveClientMixin {
  final TradeListController controller = Get.find();

  @override
  bool get wantKeepAlive => true;

  Widget summaryCard() {
    return Obx(() {
      final bool isProfit = controller.monthlyTotal >= 0;
      final color = isProfit ? Colors.green : Colors.red;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isProfit ? "Monthly Profit" : "Monthly Loss",
                  style: context.text.titleMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                AppMonthYearField(
                  onChanged: (value) => controller.updateSelectedMonth(value),
                  variant: MonthFiledVariant.small,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${Utils.moneySymbol}${controller.monthlyTotalText}",
              style: context.text.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: const ApplicationBar(title: "Monthly Trades"),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_trade_fab',
        onPressed: () => Get.toNamed(AppRoutes.addTrade),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          summaryCard().screenPadding(),
          const SizedBox(height: 24),
          Expanded(
            child: Obx(() {
              final trades = controller.monthlyTrades;

              if (trades.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.show_chart_outlined,
                        size: 64,
                        color: context.color.outlineVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No trades found",
                        style: context.text.titleMedium?.copyWith(
                          color: context.color.secondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: trades.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final trade = trades[index];

                  return Dismissible(
                    key: Key(trade.id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await CommonDialog.showConfirmDialog(
                        context: context,
                        title: "Delete Trade",
                        message: "Are you sure you want to delete this trade?",
                        confirmText: "Delete",
                      );
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: context.color.error,
                      ),
                      child: const Icon(Icons.delete_outline, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      controller.deleteTrade(trade.id);
                    },
                    child: TradeListItem(
                      trade: trade,
                      onTap: () {
                        Get.toNamed(AppRoutes.addTrade, arguments: trade);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
