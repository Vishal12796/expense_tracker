import 'package:expense_tracker/data/models/expenses_category_data.dart';
import 'package:expense_tracker/data/models/trade_list_model.dart';
import 'package:expense_tracker/views/expense/expense_list/controller/expense_list_controller.dart';
import 'package:expense_tracker/views/investment/trade_list/controller/trade_list_controller.dart';
import 'package:get/get.dart';
import '../../../core/enum/expense_category.dart';
import '../../../data/models/expense_model.dart';

class DashboardController extends GetxController {
  final ExpenseListController _expenseController =
      Get.find<ExpenseListController>();
  final TradeListController _tradeController = Get.find<TradeListController>();

  final selectedYear = DateTime.now().year.obs;

  List<ExpenseModel> get allExpenses => _expenseController.expenses;

  List<TradeListModel> get allTrades => _tradeController.trades;

  double get totalExpenses => _expenseController.monthlyTotal;

  List<TradeListModel> get tradesForSelectedYear {
    final filteredTrades = allTrades
        .where((trade) => trade.date.year == selectedYear.value)
        .toList();

    filteredTrades.sort((a, b) => b.date.compareTo(a.date));
    return filteredTrades;
  }

  int get tradeCount => tradesForSelectedYear.length;

  List<TradeListModel> get winningTrades =>
      tradesForSelectedYear.where((trade) => trade.isProfit).toList();

  List<TradeListModel> get losingTrades =>
      tradesForSelectedYear.where((trade) => !trade.isProfit).toList();

  double get netTradeTotal {
    return tradesForSelectedYear.fold<double>(
      0,
      (total, trade) => total + trade.signedAmount,
    );
  }

  double get grossTradeProfit {
    return winningTrades.fold<double>(
      0,
      (total, trade) => total + trade.amount,
    );
  }

  double get grossTradeLoss {
    return losingTrades.fold<double>(0, (total, trade) => total + trade.amount);
  }

  double get tradeWinRate {
    if (tradeCount == 0) return 0;
    return winningTrades.length / tradeCount * 100;
  }

  double get averageTradeReturn {
    if (tradeCount == 0) return 0;
    return netTradeTotal / tradeCount;
  }

  double get profitFactor {
    if (grossTradeLoss == 0) {
      return grossTradeProfit > 0 ? grossTradeProfit : 0;
    }
    return grossTradeProfit / grossTradeLoss;
  }

  TradeListModel? get bestTrade {
    final trades = tradesForSelectedYear;
    if (trades.isEmpty) return null;
    return trades.reduce(
      (current, next) =>
          current.signedAmount > next.signedAmount ? current : next,
    );
  }

  TradeListModel? get worstTrade {
    final trades = tradesForSelectedYear;
    if (trades.isEmpty) return null;
    return trades.reduce(
      (current, next) =>
          current.signedAmount < next.signedAmount ? current : next,
    );
  }

  List<TradeListModel> get recentTradesForSelectedYear {
    return tradesForSelectedYear.take(5).toList();
  }

  double get dailyAverage {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return totalExpenses / daysInMonth;
  }

  /// Calculates total expenses for each month of the selected year
  List<double> get monthlyTotalsForYear {
    List<double> totals = List.filled(12, 0.0);
    for (var expense in allExpenses) {
      if (expense.date.year == selectedYear.value) {
        totals[expense.date.month - 1] += expense.amount;
      }
    }
    return totals;
  }

  /// Gets category breakdown for the currently selected month
  List<ExpensesCategoryData> get topCategories {
    final expenses = _expenseController.monthlyExpenses;
    if (expenses.isEmpty) return [];

    final Map<ExpenseCategory, double> categoryMap = {};
    for (var expense in expenses) {
      categoryMap[expense.category] =
          (categoryMap[expense.category] ?? 0) + expense.amount;
    }

    final sortedCategories = categoryMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedCategories.map((entry) {
      return ExpensesCategoryData(category: entry.key, amount: entry.value);
    }).toList();
  }

  ExpenseModel? get highestExpense {
    final expenses = _expenseController.monthlyExpenses;
    if (expenses.isEmpty) return null;
    return expenses.reduce(
      (curr, next) => curr.amount > next.amount ? curr : next,
    );
  }

  void updateMonth(DateTime date) {
    _expenseController.updateSelectedMonth(date);
  }

  void updateYear(DateTime date) {
    selectedYear.value = date.year;
  }

  DateTime get selectedMonth => _expenseController.selectedMonth.value;
}
