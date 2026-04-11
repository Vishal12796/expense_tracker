import 'package:expense_tracker/core/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';

class HeaderNumbers extends StatelessWidget {
  const HeaderNumbers({super.key});

  @override
  Widget build(BuildContext context) {
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
                    "${Utils.moneySymbol}12150",
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
                    "${Utils.moneySymbol}3409",
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
  }
}
