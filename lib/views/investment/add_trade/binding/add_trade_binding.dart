import 'package:expense_tracker/views/investment/add_trade/controller/add_trade_controller.dart';
import 'package:expense_tracker/views/investment/trade_list/controller/trade_list_controller.dart';
import 'package:get/get.dart';

class AddTradeBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<TradeListController>()) {
      Get.lazyPut(() => TradeListController());
    }
    Get.lazyPut(() => AddTradeController());
  }
}
