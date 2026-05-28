import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/views/dashboard/widgets/expense_analytics.dart';
import 'package:expense_tracker/views/dashboard/widgets/expenses_categories.dart';
import 'package:expense_tracker/views/dashboard/widgets/expenses_monthly.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/padding_extension.dart';

class ExpensesTab extends StatelessWidget {
  const ExpensesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.sectionSpace,
        children: [
          const MonthlyExpenses(),
          const ExpenseAnalytics().screenPadding(),
          ExpensesCategories().screenPadding(),
        ],
      ),
    );
  }
}
