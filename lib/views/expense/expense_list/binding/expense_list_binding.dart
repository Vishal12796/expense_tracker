import 'package:expense_tracker/views/expense/expense_list/controller/expense_list_controller.dart';
import 'package:get/get.dart';

class ExpenseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpenseListController());
  }
}
