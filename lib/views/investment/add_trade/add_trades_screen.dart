import 'package:expense_tracker/views/investment/add_trade/controller/add_trade_controller.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/widgets/app_date_field.dart';
import 'package:expense_tracker/core/widgets/app_form_group.dart';
import 'package:expense_tracker/core/widgets/app_submit_bar.dart';
import 'package:expense_tracker/core/widgets/app_textfield.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:expense_tracker/views/investment/add_trade/widgets/trade_result_selector.dart';
import 'package:expense_tracker/views/investment/add_trade/widgets/trade_summary_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 18,
                  children: [
                    TradeSummaryHeader(controller: controller),
                    AppFormGroup(
                      title: "Trade Result",
                      children: [TradeResultSelector(controller: controller)],
                    ),
                    AppFormGroup(
                      title: "Trade Details",
                      children: [
                        AppTextField(
                          controller: controller.amountController,
                          hintText: "100",
                          labelText: "Amount",
                          keyboardType: TextInputType.number,
                          validator: controller.validateAmount,
                          prefixIcon: const Icon(
                            Icons.currency_rupee,
                            size: 22,
                          ),
                        ),
                        AppDateField(
                          controller: controller.dateController,
                          labelText: "Select Date",
                          lastDate: DateTime.now(),
                          validator: controller.validateDate,
                          onDateSelected: controller.updateSelectedDate,
                        ),
                      ],
                    ),
                    AppFormGroup(
                      title: "Notes",
                      children: [
                        AppTextField(
                          controller: controller.notesController,
                          hintText: "Notes...",
                          labelText: "Notes",
                          validator: controller.validateNotes,
                          prefixIcon: const Icon(Icons.note_outlined, size: 22),
                          lines: 4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).scrollPadding(),
          ),
          AppSubmitBar(
            title: controller.isEditing ? "Update Trade" : "Save Trade",
            onTap: controller.submit,
          ),
        ],
      ).screenPadding().screenBottomPadding(),
    );
  }
}
