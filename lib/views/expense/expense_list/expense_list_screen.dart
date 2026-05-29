import 'package:expense_tracker/views/expense/expense_list/controller/expense_list_controller.dart';
import 'package:expense_tracker/core/dialog/common_dialog.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:expense_tracker/views/expense/expense_list/widgets/expense_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/extension/context_extension.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen>
    with AutomaticKeepAliveClientMixin {
  final ExpenseListController controller = Get.find();

  @override
  bool get wantKeepAlive => true;

  Widget summaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.color.primary, context.color.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: context.color.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Spent",
                style: context.text.titleMedium?.copyWith(
                  color: context.color.onPrimary.withValues(alpha: 0.8),
                ),
              ),
              AppMonthYearField(
                onChanged: (value) => controller.updateSelectedMonth(value),
                variant: MonthFiledVariant.small,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(
            () => Text(
              "${Utils.moneySymbol}${controller.monthlyTotalText}",
              style: context.text.headlineLarge?.copyWith(
                color: context.color.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: const ApplicationBar(title: "Monthly Expenses"),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_expense_fab',
        onPressed: () => Get.toNamed(AppRoutes.addExpense),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          summaryCard().screenPadding(),
          const SizedBox(height: 24),
          Expanded(
            child: Obx(() {
              final expenses = controller.monthlyExpenses;

              if (expenses.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 64,
                        color: context.color.outlineVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No expenses found",
                        style: context.text.titleMedium?.copyWith(
                          color: context.color.secondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: expenses.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return Dismissible(
                    key: Key(expense.id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await CommonDialog.showConfirmDialog(
                        context: context,
                        title: "Delete Expense",
                        message: "Are you sure you want to delete this expense?",
                        confirmText: "Delete",
                      );
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: context.color.error,
                      ),
                      child: const Icon(Icons.delete_outline, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      controller.deleteExpense(expense.id);
                    },
                    child: ExpenseListItem(
                      modelData: expense,
                      onTap: () {
                        Get.toNamed(AppRoutes.addExpense, arguments: expense);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
