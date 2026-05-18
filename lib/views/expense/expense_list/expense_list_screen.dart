import 'package:expense_tracker/views/expense/expense_list/controller/expense_list_controller.dart';
import 'package:expense_tracker/core/dialog/common_dialog.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/core/theme/spacing.dart';
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

  Widget header() {
    return Row(
      spacing: Spacing.sectionSpace,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppMonthYearField(
          onChanged: (value) {
            controller.updateSelectedMonth(value);
          },
          variant: MonthFiledVariant.big,
        ),
        Obx(
          () => Text(
            "${Utils.moneySymbol}${controller.monthlyTotalText}",
            style: context.text.headlineLarge?.copyWith(
              color: context.color.primary,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ApplicationBar(title: "Monthly Expenses"),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_expense_fab',
        onPressed: () => {Get.toNamed(AppRoutes.addExpense)},
        child: Icon(Icons.add),
      ),
      body: Column(
        spacing: 12,
        children: [
          const SizedBox(height: 8),
          header(),
          Flexible(
            flex: 1,
            child: Obx(() {
              final expenses = controller.monthlyExpenses;

              if (expenses.isEmpty) {
                return Center(
                  child: Text(
                    "No expenses found",
                    style: context.text.titleMedium?.copyWith(
                      color: context.color.secondary,
                    ),
                  ),
                );
              }

              return ListView.separated(
                itemCount: expenses.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 4);
                },
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return Dismissible(
                    key: Key(expense.id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await CommonDialog.showConfirmDialog(
                        context: context,
                        title: "Delete Expense",
                        message:
                            "Are you sure you want to delete this expense?",
                        confirmText: "Delete",
                      );
                    },
                    background: Card.filled(
                      elevation: 2,
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red,
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
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
      ).screenPadding(),
    );
  }
}
