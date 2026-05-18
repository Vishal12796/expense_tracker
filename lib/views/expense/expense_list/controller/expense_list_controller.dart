import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:get/get.dart';

class ExpenseListController extends GetxController {
  final selectedMonth = DateTime.now().obs;

  final expenses = <ExpenseModel>[
    ExpenseModel(
      id: '1',
      amount: 250,
      date: DateTime.now().subtract(const Duration(days: 1)),
      name: 'Lunch',
      description: 'Lunch with friends',
      category: ExpenseCategory.food,
    ),
    ExpenseModel(
      id: '2',
      amount: 1200,
      date: DateTime.now().subtract(const Duration(days: 2)),
      name: 'Petrol Fill',
      description: 'Bike petrol',
      category: ExpenseCategory.petrol,
    ),
    ExpenseModel(
      id: '3',
      amount: 399,
      date: DateTime.now().subtract(const Duration(days: 3)),
      name: 'Mobile Recharge',
      description: 'Jio prepaid plan',
      category: ExpenseCategory.recharge,
    ),
    ExpenseModel(
      id: '4',
      amount: 15000,
      date: DateTime.now().subtract(const Duration(days: 4)),
      name: 'House Rent',
      description: 'Monthly rent payment',
      category: ExpenseCategory.rent,
    ),
    ExpenseModel(
      id: '5',
      amount: 2200,
      date: DateTime.now().subtract(const Duration(days: 5)),
      name: 'Clothes',
      description: 'Bought shirts and jeans',
      category: ExpenseCategory.shopping,
    ),
  ].obs;

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
