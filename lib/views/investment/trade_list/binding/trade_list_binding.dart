import 'package:expense_tracker/views/investment/trade_list/controller/trade_list_controller.dart';
import 'package:get/get.dart';

class TradeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TradeListController());
  }
}
