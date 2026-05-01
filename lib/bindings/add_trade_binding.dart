import 'package:expense_tracker/controller/add_trade_controller.dart';
import 'package:get/get.dart';

class AddTradeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTradeController());
  }
}
