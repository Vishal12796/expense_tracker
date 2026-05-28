import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:get/get.dart';

class ExpenseListController extends GetxController {
  final selectedMonth = DateTime.now().obs;

  final expenses = <ExpenseModel>[
    // Helper to generate multiple expenses for a month
    ..._generateMonthlyData(2026, 1, [200, 500, 150, 2000, 15000]),
    ..._generateMonthlyData(2026, 2, [300, 100, 800, 400, 15000]),
    ..._generateMonthlyData(2026, 3, [450, 200, 150, 600, 15000]),
    ..._generateMonthlyData(2026, 4, [100, 900, 300, 200, 15000]),
    ..._generateMonthlyData(2026, 5, [600, 300, 450, 800, 15000]),
    ..._generateMonthlyData(2026, 6, [250, 700, 100, 400, 15000]),
    ..._generateMonthlyData(2026, 7, [400, 150, 900, 200, 15000]),
    ..._generateMonthlyData(2026, 8, [150, 600, 250, 500, 15000]),
    ..._generateMonthlyData(2026, 9, [800, 200, 400, 300, 15000]),
    ..._generateMonthlyData(2026, 10, [300, 450, 150, 700, 15000]),
    ..._generateMonthlyData(2026, 11, [500, 100, 600, 250, 15000]),
    ..._generateMonthlyData(2026, 12, [250, 1200, 399, 15000, 2200, 800]),
  ].obs;

  static List<ExpenseModel> _generateMonthlyData(int year, int month, List<double> amounts) {
    final categories = ExpenseCategory.values;
    return List.generate(amounts.length, (index) {
      return ExpenseModel(
        id: '${year}_${month}_$index',
        amount: amounts[index],
        date: DateTime(year, month, (index * 5) + 1), // Spread across the month
        name: 'Expense $index',
        description: 'Mock description for month $month',
        category: categories[index % categories.length],
      );
    });
  }

  List<ExpenseModel> get monthlyExpenses {
    final month = selectedMonth.value;
    final filteredExpenses = expenses
        .where(
          (expense) =>
              expense.date.month == month.month &&
              expense.date.year == month.year,
        )
        .toList();

    filteredExpenses.sort((a, b) => b.date.compareTo(a.date));
    return filteredExpenses;
  }

  double get monthlyTotal {
    return monthlyExpenses.fold<double>(
      0,
      (total, expense) => total + expense.amount,
    );
  }

  String get monthlyTotalText => monthlyTotal.toStringAsFixed(0);

  void addExpense(ExpenseModel expense) {
    expenses.add(expense);
    selectedMonth.value = DateTime(expense.date.year, expense.date.month);
  }

  void updateExpense(ExpenseModel updatedExpense) {
    final index = expenses.indexWhere(
      (expense) => expense.id == updatedExpense.id,
    );

    if (index == -1) {
      return;
    }

    expenses[index] = updatedExpense;
    selectedMonth.value = DateTime(
      updatedExpense.date.year,
      updatedExpense.date.month,
    );
  }

  void updateSelectedMonth(DateTime value) {
    selectedMonth.value = DateTime(value.year, value.month);
  }

  void deleteExpense(String id) {
    expenses.removeWhere((expense) => expense.id == id);
  }
}
