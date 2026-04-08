import 'package:expense_tracker/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppMonthYearField extends StatefulWidget {
  final String hint;
  final ValueChanged<DateTime>? onChanged;

  const AppMonthYearField({
    super.key,
    this.hint = "Select Month",
    this.onChanged,
  });

  @override
  State<AppMonthYearField> createState() => _AppMonthYearFieldState();
}

class _AppMonthYearFieldState extends State<AppMonthYearField> {
  DateTime? selected;
  final TextEditingController? controller = TextEditingController();

  Future<void> onTap() async {
    final picked = await AppMonthYearPicker.pick(
      context,
      initialDate: selected,
    );

    if (picked != null) {
      setState(() {
        selected = picked;
        controller?.text = selected != null
            ? DateFormat('MMM yyyy').format(selected!)
            : widget.hint;
      });
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      style: AppTextStyles.textField,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.hint,
        hintStyle:  AppTextStyles.textField,
        prefixIcon: const Icon(Icons.calendar_month_outlined, size: 24),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class AppMonthYearPicker {
  static Future<DateTime?> pick(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return showDialog<DateTime>(
      context: context,
      builder: (_) => _MonthYearPickerDialog(
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(2100),
      ),
    );
  }
}

class _MonthYearPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const _MonthYearPickerDialog({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<_MonthYearPickerDialog> createState() => _MonthYearPickerDialogState();
}

class _MonthYearPickerDialogState extends State<_MonthYearPickerDialog> {
  late int selectedYear;
  late int selectedMonth;

  @override
  void initState() {
    super.initState();

    // restore previous selection
    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
  }

  void changeYear(int delta) {
    final newYear = selectedYear + delta;

    if (newYear >= widget.firstDate.year && newYear <= widget.lastDate.year) {
      setState(() => selectedYear = newYear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Month"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Year selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => changeYear(-1),
                icon: const Icon(Icons.chevron_left),
              ),
              Text("$selectedYear"),
              IconButton(
                onPressed: () => changeYear(1),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Month grid
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(12, (index) {
              final month = index + 1;

              final isSelected = month == selectedMonth;

              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, DateTime(selectedYear, month));
                },
                child: Container(
                  width: 70,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    DateFormat('MMM').format(DateTime(selectedYear, month)),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
