import 'package:expense_tracker/core/enum/expense_category.dart';

class ExpensesCategoryData {
  final ExpenseCategory category;
  final double amount;

  ExpensesCategoryData({required this.category, required this.amount});
}
