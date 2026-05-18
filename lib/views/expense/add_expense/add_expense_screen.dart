import 'package:expense_tracker/views/expense/add_expense/controller/add_expense_controller.dart';
import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/widgets/app_button.dart';
import 'package:expense_tracker/core/widgets/app_date_field.dart';
import 'package:expense_tracker/core/widgets/app_dropdown.dart';
import 'package:expense_tracker/core/widgets/app_textfield.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final AddExpenseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ApplicationBar(
          title: controller.isEditing ? "Edit Expense" : "Add Expense",
          isShowBack: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  spacing: 24,
                  children: [
                    AppTextField(
                      controller: controller.nameController,
                      hintText: "Expense Name",
                      labelText: "Name",
                      validator: controller.validateName,
                      prefixIcon: Icon(Icons.wallet_outlined, size: 24),
                    ),
                    AppTextField(
                      controller: controller.amountController,
                      hintText: "100",
                      labelText: "Amount",
                      keyboardType: TextInputType.number,
                      validator: controller.validateAmount,
                      prefixIcon: Icon(Icons.currency_rupee, size: 24),
                    ),
                    AppDropdownField(
                      items: ExpenseCategory.values.map((category) {
                        return category.label;
                      }).toList(),
                      hintText: "Select category",
                      controller: controller.categoryNotifier,
                      validator: controller.validateCategory,
                    ),
                    AppDateField(
                      controller: controller.dateController,
                      labelText: "Select Date",
                      lastDate: DateTime.now(),
                      validator: controller.validateDate,
                      onDateSelected: controller.updateSelectedDate,
                    ),
                    AppTextField(
                      controller: controller.notesController,
                      hintText: "Notes...",
                      labelText: "Notes",
                      validator: controller.validateNotes,
                      prefixIcon: Icon(Icons.note_outlined, size: 24),
                      lines: 4,
                    ),
                  ],
                ),
              ),
            ).scrollPadding(),
          ),
          AppButton(
            title: controller.isEditing ? "Update" : "Submit",
            onTap: controller.submit,
          ),
        ],
      ).screenPadding().screenBottomPadding(),
    );
  }
}
