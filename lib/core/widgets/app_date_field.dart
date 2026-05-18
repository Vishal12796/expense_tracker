import 'package:expense_tracker/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final String? Function(String?)? validator;

  const AppDateField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.validator,
  });

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
    );

    if (pickedDate != null) {
      final formatted = DateFormat('dd/MM/yyyy').format(pickedDate);
      controller?.text = formatted;
      if (onDateSelected != null) {
        onDateSelected!(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context),
      validator: validator,
      style: AppTextStyles.textField,
      decoration: InputDecoration(
        hintText: hintText ?? "Select date",
        labelText: labelText,
        hintStyle: AppTextStyles.textField,
        prefixIcon: const Icon(Icons.calendar_month_outlined, size: 24),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
