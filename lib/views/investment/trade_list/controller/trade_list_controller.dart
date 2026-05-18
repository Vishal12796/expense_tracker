import 'package:expense_tracker/data/models/trade_list_model.dart';
import 'package:get/get.dart';

class TradeListController extends GetxController {
  final selectedMonth = DateTime.now().obs;

  final trades = <TradeListModel>[
    TradeListModel(
      id: '1',
      amount: 200,
      date: DateTime.now().subtract(const Duration(days: 1)),
      notes: 'Market momentum high',
      isProfit: true,
    ),
    TradeListModel(
      id: '2',
      amount: 100,
      date: DateTime.now().subtract(const Duration(days: 2)),
      notes: 'Quick exit after reversal',
      isProfit: false,
    ),
    TradeListModel(
      id: '3',
      amount: 650,
      date: DateTime.now().subtract(const Duration(days: 4)),
      notes: 'Breakout trade',
      isProfit: true,
    ),
    TradeListModel(
      id: '4',
      amount: 300,
      date: DateTime.now().subtract(const Duration(days: 8)),
      notes: 'Stop loss hit',
      isProfit: false,
    ),
    TradeListModel(
      id: '5',
      amount: 1200,
      date: DateTime.now().subtract(const Duration(days: 12)),
      notes: 'Swing trade target achieved',
      isProfit: true,
    ),
  ].obs;

  List<TradeListModel> get monthlyTrades {
    final month = selectedMonth.value;
    final filteredTrades = trades
        .where(
          (trade) =>
              trade.date.month == month.month && trade.date.year == month.year,
        )
        .toList();

    filteredTrades.sort((a, b) => b.date.compareTo(a.date));
    return filteredTrades;
  }

  double get monthlyTotal {
    return monthlyTrades.fold<double>(
      0,
      (total, trade) => total + trade.signedAmount,
    );
  }

  String get monthlyTotalText {
    final sign = monthlyTotal < 0 ? '-' : '';
    return '$sign${monthlyTotal.abs().toStringAsFixed(0)}';
  }

  void addTrade(TradeListModel trade) {
    trades.add(trade);
    selectedMonth.value = DateTime(trade.date.year, trade.date.month);
  }

  void updateTrade(TradeListModel updatedTrade) {
    final index = trades.indexWhere((trade) => trade.id == updatedTrade.id);

    if (index == -1) {
      return;
    }

    trades[index] = updatedTrade;
    selectedMonth.value = DateTime(
      updatedTrade.date.year,
      updatedTrade.date.month,
    );
  }

  void updateSelectedMonth(DateTime value) {
    selectedMonth.value = DateTime(value.year, value.month);
  }

  void deleteTrade(String id) {
    trades.removeWhere((trade) => trade.id == id);
  }
}
