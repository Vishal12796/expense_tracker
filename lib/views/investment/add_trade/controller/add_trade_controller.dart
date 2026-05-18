import 'package:expense_tracker/views/investment/trade_list/controller/trade_list_controller.dart';
import 'package:expense_tracker/data/models/trade_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum TradeResult { profit, loss }

class AddTradeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  final dateController = TextEditingController();

  final tradeResult = TradeResult.profit.obs;
  final selectedDate = Rxn<DateTime>();
  TradeListModel? editingTrade;

  bool get isEditing => editingTrade != null;

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments;

    if (argument is TradeListModel) {
      _fillForm(argument);
    }
  }

  void updateTradeResult(TradeResult? value) {
    if (value != null) {
      tradeResult.value = value;
    }
  }

  void updateSelectedDate(DateTime value) {
    selectedDate.value = value;
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

    final trade = _createTrade();
    final tradeListController = Get.find<TradeListController>();

    if (isEditing) {
      tradeListController.updateTrade(trade);
    } else {
      tradeListController.addTrade(trade);
    }

    Get.back();
    Get.snackbar(
      isEditing ? 'Trade updated' : 'Trade saved',
      '${tradeResult.value.name.capitalizeFirst}: ${trade.amount.toStringAsFixed(0)}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  TradeListModel _createTrade() {
    return TradeListModel(
      id: editingTrade?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      amount: double.parse(amountController.text.trim()),
      date: selectedDate.value!,
      notes: notesController.text.trim(),
      isProfit: tradeResult.value == TradeResult.profit,
    );
  }

  void _fillForm(TradeListModel trade) {
    editingTrade = trade;
    amountController.text = trade.amount.toStringAsFixed(0);
    notesController.text = trade.notes;
    selectedDate.value = trade.date;
    dateController.text = DateFormat('dd/MM/yyyy').format(trade.date);
    tradeResult.value = trade.isProfit ? TradeResult.profit : TradeResult.loss;
  }

  @override
  void onClose() {
    amountController.dispose();
    notesController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
