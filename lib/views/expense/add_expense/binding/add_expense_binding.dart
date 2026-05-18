import 'package:expense_tracker/views/expense/add_expense/controller/add_expense_controller.dart';
import 'package:expense_tracker/views/expense/expense_list/controller/expense_list_controller.dart';
import 'package:get/get.dart';

class AddExpenseBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ExpenseListController>()) {
      Get.lazyPut(() => ExpenseListController());
    }
    Get.lazyPut(() => AddExpenseController());
  }
}
