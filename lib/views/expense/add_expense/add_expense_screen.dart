import 'package:expense_tracker/views/expense/add_expense/controller/add_expense_controller.dart';
import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/widgets/app_date_field.dart';
import 'package:expense_tracker/core/widgets/app_dropdown.dart';
import 'package:expense_tracker/core/widgets/app_textfield.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:expense_tracker/views/expense/add_expense/widgets/add_expense_form_group.dart';
import 'package:expense_tracker/views/expense/add_expense/widgets/add_expense_submit_bar.dart';
import 'package:expense_tracker/views/expense/add_expense/widgets/expense_summary_header.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 18,
                  children: [
                    ExpenseSummaryHeader(controller: controller),
                    AddExpenseFormGroup(
                      title: "Expense Details",
                      children: [
                        AppTextField(
                          controller: controller.nameController,
                          hintText: "Expense Name",
                          labelText: "Name",
                          validator: controller.validateName,
                          prefixIcon: const Icon(
                            Icons.wallet_outlined,
                            size: 22,
                          ),
                        ),
                        AppTextField(
                          controller: controller.amountController,
                          hintText: "100",
                          labelText: "Amount",
                          keyboardType: TextInputType.number,
                          validator: controller.validateAmount,
                          prefixIcon: const Icon(
                            Icons.currency_rupee,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    AddExpenseFormGroup(
                      title: "Classification",
                      children: [
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
                      ],
                    ),
                    AddExpenseFormGroup(
                      title: "Notes",
                      children: [
                        AppTextField(
                          controller: controller.notesController,
                          hintText: "Notes...",
                          labelText: "Notes",
                          validator: controller.validateNotes,
                          prefixIcon: const Icon(Icons.note_outlined, size: 22),
                          lines: 4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).scrollPadding(),
          ),
          AddExpenseSubmitBar(
            title: controller.isEditing ? "Update Expense" : "Save Expense",
            onTap: controller.submit,
          ),
        ],
      ).screenPadding().screenBottomPadding(),
    );
  }
}
