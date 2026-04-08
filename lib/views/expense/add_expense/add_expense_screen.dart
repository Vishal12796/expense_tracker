import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/widgets/app_button.dart';
import 'package:expense_tracker/core/widgets/app_date_field.dart';
import 'package:expense_tracker/core/widgets/app_dropdown.dart';
import 'package:expense_tracker/core/widgets/app_textfield.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  final ExpenseModel? expense;

  const AddExpenseScreen({super.key, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  final dateController = TextEditingController();
  String? selectedCategory;
  final categoryNotifier = ValueNotifier<String?>(null);

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ApplicationBar(
          title: widget.expense == null ? "Add Expense" : "Edit Expense",
          isShowBack: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 24,
                children: [
                  AppTextField(
                    controller: nameController,
                    hintText: "Expense Name",
                    labelText: "Name",
                    prefixIcon: Icon(CupertinoIcons.profile_circled, size: 24),
                  ),
                  AppTextField(
                    controller: amountController,
                    hintText: "100",
                    labelText: "Amount",
                    prefixIcon: Icon(Icons.currency_rupee, size: 24),
                  ),
                  AppDropdownField(
                    items: ExpenseCategory.values.map((category) {
                      return category.label;
                    }).toList(),
                    hintText: "Select category",
                    controller: categoryNotifier,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select category.';
                      }
                      return null;
                    },
                  ),
                  AppDateField(
                    controller: dateController,
                    labelText: "Select Date",
                    lastDate: DateTime.now(),
                    onDateSelected: (date) {
                      print(date);
                    },
                  ),
                  AppTextField(
                    controller: notesController,
                    hintText: "Notes...",
                    labelText: "Notes",
                    prefixIcon: Icon(Icons.note_outlined, size: 24),
                    lines: 4,
                  ),
                ],
              ),
            ).scrollPadding(),
          ),
          AppButton(title: "Submit", onTap: () {}),
        ],
      ).screenPadding().screenBottomPadding(),
    );
  }
}
