import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/core/widgets/app_donut_chart.dart';
import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/extension/context_extension.dart';

class ExpensesCategories extends GetView<DashboardController> {
  const ExpensesCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categories = controller.topCategories;

      return Column(
        spacing: Spacing.sectionSpace,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Category Breakdown",
                style: context.text.titleLarge?.copyWith(
                  color: context.color.onPrimaryFixedVariant,
                ),
              ),
              AppMonthYearField(
                initialDate: controller.selectedMonth,
                onChanged: (value) {
                  controller.updateMonth(value);
                },
                variant: MonthFiledVariant.small,
              ),
            ],
          ),
          if (categories.isEmpty)
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Text(
                "No expenses for this month",
                style: context.text.bodyMedium?.copyWith(color: Colors.grey),
              ),
            )
          else
            Card.filled(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: AppDonutChart(
                  totalAmount: controller.totalExpenses,
                  data: categories.map((cat) {
                    return DonutChartData(
                      label: cat.category.label,
                      value: cat.amount,
                      color: cat.category.color,
                    );
                  }).toList(),
                ),
              ),
            ),
          const SizedBox(height: 30),
        ],
      );
    });
  }
}
