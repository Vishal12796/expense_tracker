import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:expense_tracker/views/expense/add_expense/controller/add_expense_controller.dart';
import 'package:flutter/material.dart';

class ExpenseSummaryHeader extends StatelessWidget {
  final AddExpenseController controller;

  const ExpenseSummaryHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller.amountController,
      builder: (context, amountValue, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: controller.categoryNotifier,
          builder: (context, categoryLabel, _) {
            final category = ExpenseCategoryX.fromString(categoryLabel ?? '');
            final amount = _amountText(amountValue.text);

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEDE6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFB93815).withValues(alpha: 0.14),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.82),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(category.icon, color: const Color(0xFFB93815)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.isEditing
                              ? "Editing Expense"
                              : "New Expense",
                          style: context.text.labelSmall?.copyWith(
                            color: context.color.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          amount,
                          style: context.text.headlineLarge?.copyWith(
                            color: const Color(0xFFB93815),
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          categoryLabel ?? "Uncategorized",
                          style: context.text.labelMedium?.copyWith(
                            color: context.color.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _amountText(String value) {
    final amount = double.tryParse(value.trim());
    if (amount == null || amount <= 0) {
      return "₹0";
    }
    return "₹${amount.toStringAsFixed(0)}";
  }
}
