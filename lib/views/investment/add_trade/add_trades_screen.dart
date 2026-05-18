import 'package:expense_tracker/views/investment/add_trade/controller/add_trade_controller.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/widgets/app_button.dart';
import 'package:expense_tracker/core/widgets/app_date_field.dart';
import 'package:expense_tracker/core/widgets/app_radio.dart';
import 'package:expense_tracker/core/widgets/app_textfield.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_text_styles.dart';

class AddTradesScreen extends StatefulWidget {
  const AddTradesScreen({super.key});

  @override
  State<AddTradesScreen> createState() => _AddTradesScreenState();
}

class _AddTradesScreenState extends State<AddTradesScreen> {
  final AddTradeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ApplicationBar(
          title: controller.isEditing ? "Edit Trade" : "Add Trades",
          isShowBack: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  spacing: 24,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => AppRadioGroup<TradeResult>(
                        title: const Text(
                          "Trade  Result",
                          style: AppTextStyles.textField,
                        ),
                        value: controller.tradeResult.value,
                        direction: Axis.horizontal,
                        onChanged: controller.updateTradeResult,
                        items: const [
                          AppRadioItem(
                            value: TradeResult.profit,
                            title: "Profit",
                          ),
                          AppRadioItem(value: TradeResult.loss, title: "Loss"),
                        ],
                      ),
                    ),
                    AppTextField(
                      controller: controller.amountController,
                      hintText: "100",
                      labelText: "Amount",
                      keyboardType: TextInputType.number,
                      validator: controller.validateAmount,
                      prefixIcon: Icon(Icons.currency_rupee, size: 24),
                    ),
                    AppDateField(
                      controller: controller.dateController,
                      labelText: "Select Date",
                      lastDate: DateTime.now(),
                      validator: controller.validateDate,
                      onDateSelected: controller.updateSelectedDate,
                    ),
                    AppTextField(
                      controller: controller.notesController,
                      hintText: "Notes...",
                      labelText: "Notes",
                      validator: controller.validateNotes,
                      prefixIcon: Icon(Icons.note_outlined, size: 24),
                      lines: 4,
                    ),
                    AppButton(
                      title: controller.isEditing ? "Update" : "Submit",
                      onTap: controller.submit,
                    ),
                  ],
                ),
              ),
            ).scrollPadding(),
          ),
        ],
      ).screenPadding().screenBottomPadding(),
    );
  }
}
