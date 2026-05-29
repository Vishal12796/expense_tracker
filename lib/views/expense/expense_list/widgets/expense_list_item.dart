import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/widgets/category_avatar.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/extension/context_extension.dart';

class ExpenseListItem extends StatelessWidget {
  final ExpenseModel modelData;
  final VoidCallback? onTap;

  const ExpenseListItem({super.key, required this.modelData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.color.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CategoryAvatar(
                category: modelData.category,
                radius: 24,
                iconSize: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modelData.name,
                      style: context.text.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      modelData.description,
                      style: context.text.bodySmall?.copyWith(
                        color: context.color.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "-${modelData.amount.toStringAsFixed(0)}",
                    style: context.text.titleMedium?.copyWith(
                      color: context.color.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatDate(modelData.date),
                    style: context.text.labelSmall?.copyWith(
                      color: context.color.outline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
