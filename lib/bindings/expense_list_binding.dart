import 'package:expense_tracker/controller/dashboard_controller.dart';
import 'package:expense_tracker/controller/expense_list_controller.dart';
import 'package:get/get.dart';

class ExpenseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpenseListController());
  }
}
