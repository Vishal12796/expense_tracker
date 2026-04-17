import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/views/dashboard/widgets/expenses_bar_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';

class MonthlyExpenses extends StatelessWidget {
  const MonthlyExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        spacing: Spacing.sectionSpace,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly",
            style: context.text.titleLarge?.copyWith(
              color: context.color.onPrimaryFixedVariant,
            ),
          ),
          BarChartSample2(),
        ],
      ),
    );
  }
}
