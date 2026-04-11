import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/utils/utils.dart';

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
            "Monthly Expenses",
            style: context.text.titleLarge?.copyWith(
              color: context.color.onPrimaryFixedVariant,
            ),
          ),

          SizedBox(
            height: 85,
            child: ListView.separated(
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                return Card.filled(
                  elevation: 2,
                  color: context.color.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          "${index % 2 == 0 ? "-" : "+"}${Utils.moneySymbol}400",
                          style: context.text.titleLarge?.copyWith(
                            color: context.color.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          "Apr 2026",
                          style: context.text.labelSmall?.copyWith(
                            color: context.color.onSecondaryContainer,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
