import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AddExpenseFormGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AddExpenseFormGroup({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          title,
          style: context.text.labelLarge?.copyWith(
            color: context.color.onPrimaryFixedVariant,
          ),
        ),
        ...children,
      ],
    );
  }
}
