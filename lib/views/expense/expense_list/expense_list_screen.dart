import 'package:expense_tracker/core/dialog/common_dialog.dart';
import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/views/expense/expense_list/widgets/expense_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extension/context_extension.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen>
    with AutomaticKeepAliveClientMixin {
  DateTime selectedDate = DateTime.now();
  final monthNotifier = ValueNotifier(DateTime.now());

  @override
  bool get wantKeepAlive => true;

  final List<ExpenseModel> dummyExpenses = [
    ExpenseModel(
      id: "1",
      amount: 250.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
      name: "Lunch",
      description: "Lunch with friends",
      category: ExpenseCategory.food,
    ),
    ExpenseModel(
      id: "2",
      amount: 1200.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
      name: "Petrol Fill",
      description: "Bike petrol",
      category: ExpenseCategory.petrol,
    ),
    ExpenseModel(
      id: "3",
      amount: 399.0,
      date: DateTime.now().subtract(const Duration(days: 3)),
      name: "Mobile Recharge",
      description: "Jio prepaid plan",
      category: ExpenseCategory.recharge,
    ),
    ExpenseModel(
      id: "4",
      amount: 15000.0,
      date: DateTime.now().subtract(const Duration(days: 4)),
      name: "House Rent",
      description: "Monthly rent payment",
      category: ExpenseCategory.rent,
    ),
    ExpenseModel(
      id: "5",
      amount: 2200.0,
      date: DateTime.now().subtract(const Duration(days: 5)),
      name: "Clothes",
      description: "Bought shirts & jeans",
      category: ExpenseCategory.shopping,
    ),
    ExpenseModel(
      id: "6",
      amount: 500.0,
      date: DateTime.now().subtract(const Duration(days: 6)),
      name: "Movie Night",
      description: "Avengers movie ticket",
      category: ExpenseCategory.movie,
    ),
    ExpenseModel(
      id: "7",
      amount: 850.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
      name: "Medicines",
      description: "Cold & fever tablets",
      category: ExpenseCategory.medicine,
    ),
    ExpenseModel(
      id: "8",
      amount: 3000.0,
      date: DateTime.now().subtract(const Duration(days: 7)),
      name: "Electricity Bill",
      description: "Monthly electricity payment",
      category: ExpenseCategory.bills,
    ),
    ExpenseModel(
      id: "9",
      amount: 700.0,
      date: DateTime.now(),
      name: "Random Expense",
      description: "Miscellaneous खर्च",
      category: ExpenseCategory.others,
    ),
  ];

  Widget header() {
    return Row(
      spacing: Spacing.sectionSpace,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppMonthYearField(
          onChanged: (value) {
            print(value);
          },
          variant: MonthFiledVariant.big,
        ),
        Text(
          "${Utils.moneySymbol}1800",
          style: context.text.headlineLarge?.copyWith(
            color: context.color.primary,
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
            child: ListView.separated(
              itemCount: dummyExpenses.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4);
              },
              itemBuilder: (context, index) {
                ExpenseModel model = dummyExpenses[index];
                return Dismissible(
                  key: Key(model.id),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    return await CommonDialog.showConfirmDialog(
                      context: context,
                      title: "Delete Expense",
                      message: "Are you sure you want to delete this expense?",
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
                    setState(() {
                      dummyExpenses.removeAt(index);
                    });
                  },
                  child: ExpenseListItem(modelData: model),
                );
              },
            ),
          ),
        ],
      ).screenPadding(),
    );
  }
}
