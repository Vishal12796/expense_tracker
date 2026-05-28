import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/views/expense/expense_list/controller/expense_list_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ExpenseListController>()) {
      Get.lazyPut(() => ExpenseListController());
    }
    if (!Get.isRegistered<DashboardController>()) {
      Get.lazyPut(() => DashboardController());
    }
  }
}
