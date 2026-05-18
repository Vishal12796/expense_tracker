import 'package:expense_tracker/views/expense/expense_list/controller/expense_list_controller.dart';
import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExpenseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  final dateController = TextEditingController();
  final categoryNotifier = ValueNotifier<String?>(null);

  final selectedDate = Rxn<DateTime>();
  ExpenseModel? editingExpense;

  bool get isEditing => editingExpense != null;

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments;

    if (argument is ExpenseModel) {
      _fillForm(argument);
    }
  }

  void updateSelectedDate(DateTime value) {
    selectedDate.value = value;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter expense name';
    }

    return null;
  }

  String? validateAmount(String? value) {
    final amount = value?.trim() ?? '';

    if (amount.isEmpty) {
      return 'Please enter amount';
    }

    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      return 'Please enter a valid amount';
    }

    if (parsedAmount <= 0) {
      return 'Amount must be greater than 0';
    }

    return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select category';
    }

    return null;
  }

  String? validateDate(String? value) {
    if (selectedDate.value == null || (value?.trim().isEmpty ?? true)) {
      return 'Please select date';
    }

    return null;
  }

  String? validateNotes(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter notes';
    }

    return null;
  }

  void submit() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    final expense = _createExpense();
    final expenseListController = Get.find<ExpenseListController>();

    if (isEditing) {
      expenseListController.updateExpense(expense);
    } else {
      expenseListController.addExpense(expense);
    }

    Get.back();
    Get.snackbar(
      isEditing ? 'Expense updated' : 'Expense saved',
      '${expense.name}: ${expense.amount.toStringAsFixed(0)}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  ExpenseModel _createExpense() {
    return ExpenseModel(
      id:
          editingExpense?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      amount: double.parse(amountController.text.trim()),
      date: selectedDate.value!,
      name: nameController.text.trim(),
      description: notesController.text.trim(),
      category: ExpenseCategoryX.fromString(categoryNotifier.value ?? ''),
    );
  }

  void _fillForm(ExpenseModel expense) {
    editingExpense = expense;
    nameController.text = expense.name;
    amountController.text = expense.amount.toStringAsFixed(0);
    notesController.text = expense.description;
    selectedDate.value = expense.date;
    dateController.text = DateFormat('dd/MM/yyyy').format(expense.date);
    categoryNotifier.value = expense.category.label;
  }

  @override
  void onClose() {
    nameController.dispose();
    amountController.dispose();
    notesController.dispose();
    dateController.dispose();
    categoryNotifier.dispose();
    super.onClose();
  }
}
