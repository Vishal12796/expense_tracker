import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/extension/context_extension.dart';

class HeaderNumbers extends GetView<DashboardController> {
  const HeaderNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        spacing: 8,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Card.filled(
              color: Colors.deepOrangeAccent,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${Utils.moneySymbol}${controller.totalExpenses.toInt()}",
                      style: context.text.headlineLarge?.copyWith(
                        color: context.color.onPrimary,
                      ),
                    ),
                    Text(
                      "Expenses",
                      style: context.text.labelSmall?.copyWith(
                        color: context.color.onSecondaryFixed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Card.filled(
              color: Colors.blueAccent,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${Utils.moneySymbol}3409", // Still hardcoded as Trades logic isn't fully clear yet
                      style: context.text.headlineLarge?.copyWith(
                        color: context.color.onPrimary,
                      ),
                    ),
                    Text(
                      "Profit/Loss",
                      style: context.text.labelSmall?.copyWith(
                        color: context.color.onSecondaryFixed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
