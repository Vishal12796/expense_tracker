import 'package:expense_tracker/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class AppSubmitBar extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AppSubmitBar({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Colors.black.withValues(alpha: 0.06)),
        ),
      ),
      child: AppButton(title: title, onTap: onTap),
    );
  }
}
