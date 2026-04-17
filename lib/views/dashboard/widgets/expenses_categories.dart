import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/core/widgets/category_avatar.dart';
import 'package:expense_tracker/data/models/expenses_category_data.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';

class ExpensesCategories extends StatelessWidget {
  ExpensesCategories({super.key});

  final List<ExpensesCategoryData> expenses = [
    ExpensesCategoryData(category: ExpenseCategory.food, amount: 2500),
    ExpensesCategoryData(category: ExpenseCategory.petrol, amount: 1800),
    ExpensesCategoryData(category: ExpenseCategory.recharge, amount: 499),
    ExpensesCategoryData(category: ExpenseCategory.rent, amount: 12000),
    ExpensesCategoryData(category: ExpenseCategory.shopping, amount: 3200),
    ExpensesCategoryData(category: ExpenseCategory.movie, amount: 600),
    ExpensesCategoryData(category: ExpenseCategory.medicine, amount: 850),
    ExpensesCategoryData(category: ExpenseCategory.bills, amount: 2200),
    ExpensesCategoryData(category: ExpenseCategory.others, amount: 900),
  ];

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
              itemCount: expenses.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                ExpensesCategoryData data = expenses[index];
                ExpenseCategory category = data.category;

                return SizedBox(
                  width: 120,
                  child: Card.filled(
                    elevation: 2,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          CategoryAvatar(category: category),
                          Text(
                            "${Utils.moneySymbol}${data.amount.toInt()}",
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
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
