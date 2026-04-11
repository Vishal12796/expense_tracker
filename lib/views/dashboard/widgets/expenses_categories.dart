import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/core/widgets/category_avatar.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';

class ExpensesCategories extends StatelessWidget {
  const ExpensesCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        spacing: Spacing.sectionSpace,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Categories",
                style: context.text.titleLarge?.copyWith(
                  color: context.color.onPrimaryFixedVariant,
                ),
              ),
              AppMonthYearField(
                onChanged: (value) {
                  print(value);
                },
                variant: MonthFiledVariant.small,
              ),
            ],
          ),
          SizedBox(
            height: 110,
            child: ListView.separated(
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                ExpenseCategory category = ExpenseCategory.shopping;

                return SizedBox(
                  width: 100,
                  child: Card.filled(
                    elevation: 2,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          CategoryAvatar(category: category),
                          Text(
                            "${Utils.moneySymbol}340",
                            style: context.text.titleLarge?.copyWith(
                              color: context.color.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
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
