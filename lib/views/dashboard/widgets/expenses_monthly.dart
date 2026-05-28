import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/views/dashboard/widgets/expenses_line_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/extension/padding_extension.dart';

class MonthlyExpenses extends StatelessWidget {
  const MonthlyExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Spacing.sectionSpace,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Spending Trend",
          style: context.text.titleLarge?.copyWith(
            color: context.color.onPrimaryFixedVariant,
          ),
        ).screenPadding(),
        const ExpensesLineChart(),
      ],
    );
  }
}
