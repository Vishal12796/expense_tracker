import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/widgets/app_button.dart';
import 'package:expense_tracker/core/widgets/app_date_field.dart';
import 'package:expense_tracker/core/widgets/app_radio.dart';
import 'package:expense_tracker/core/widgets/app_textfield.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/utils/app_text_styles.dart';

enum TradeResult { profit, loss }

class AddTradesScreen extends StatefulWidget {
  const AddTradesScreen({super.key});

  @override
  State<AddTradesScreen> createState() => _AddTradesScreenState();
}

class _AddTradesScreenState extends State<AddTradesScreen> {
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  final dateController = TextEditingController();
  TradeResult? tradeResult = TradeResult.profit;

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    notesController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ApplicationBar(title: "Add Trades", isShowBack: true),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 24,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppRadioGroup<TradeResult>(
                    title: const Text(
                      "Trade  Result",
                      style: AppTextStyles.textField,
                    ),
                    value: tradeResult,
                    direction: Axis.horizontal,
                    onChanged: (val) {
                      setState(() => tradeResult = val);
                    },
                    items: const [
                      AppRadioItem(value: TradeResult.profit, title: "Profit"),
                      AppRadioItem(value: TradeResult.loss, title: "Loss"),
                    ],
                  ),
                  AppTextField(
                    controller: amountController,
                    hintText: "100",
                    labelText: "Amount",
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.currency_rupee, size: 24),
                  ),
                  AppDateField(
                    controller: dateController,
                    labelText: "Select Date",
                    lastDate: DateTime.now(),
                    onDateSelected: (date) {
                      print(date);
                    },
                  ),
                  AppTextField(
                    controller: notesController,
                    hintText: "Notes...",
                    labelText: "Notes",
                    prefixIcon: Icon(Icons.note_outlined, size: 24),
                    lines: 4,
                  ),
                  AppButton(title: "Submit", onTap: () {}),
                ],
              ),
            ).scrollPadding(),
          ),
        ],
      ).screenPadding().screenBottomPadding(),
    );
  }
}
