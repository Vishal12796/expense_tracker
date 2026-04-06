import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/widgets/category_avatar.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/context_extension.dart';

class ExpenseListItem extends StatelessWidget {
  final ExpenseModel modelData;

  const ExpenseListItem({super.key, required this.modelData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.add_expense, extra: modelData);
      },
      child: Card.filled(
        color: Colors.white,
        elevation: 1,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryAvatar(category: modelData.category),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modelData.name,
                      style: context.text.labelMedium?.copyWith(
                        color: context.color.onPrimaryFixed,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      modelData.description,
                      style: context.text.labelSmall?.copyWith(
                        color: context.color.secondary,
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
                    "${modelData.amount}",
                    style: context.text.titleLarge?.copyWith(
                      color: context.color.primary,
                    ),
                  ),
                  Text(
                    formatDate(modelData.date),
                    style: context.text.labelSmall?.copyWith(
                      color: context.color.secondary,
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
