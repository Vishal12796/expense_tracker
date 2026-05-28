import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/views/expense/expense_list/controller/expense_list_controller.dart';
import 'package:expense_tracker/views/home/controller/home_controller.dart';
import 'package:expense_tracker/views/profile/controller/profile_controller.dart';
import 'package:expense_tracker/views/investment/trade_list/controller/trade_list_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    _lazyPutIfAbsent(() => HomeController());
    _lazyPutIfAbsent(() => TradeListController());
    _lazyPutIfAbsent(() => ExpenseListController());
    _lazyPutIfAbsent(() => DashboardController());
    _lazyPutIfAbsent(() => ProfileController());
  }

  void _lazyPutIfAbsent<T extends GetxController>(T Function() builder) {
    if (!Get.isRegistered<T>()) {
      Get.lazyPut<T>(builder);
    }
  }
}
