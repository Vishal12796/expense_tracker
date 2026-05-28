import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../extension/context_extension.dart';

class AppYearField extends StatefulWidget {
  final String hint;
  final MonthFiledVariant variant;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? initialDate;

  const AppYearField({
    super.key,
    this.hint = "Select Year",
    this.variant = MonthFiledVariant.big,
    this.onChanged,
    this.initialDate,
  });

  @override
  State<AppYearField> createState() => _AppMonthYearFieldState();
}

class _AppMonthYearFieldState extends State<AppYearField> {
  DateTime? selected;
  String selectedMonth = "";

  @override
  void initState() {
    super.initState();
    selected = widget.initialDate;
    if (selected != null) {
      selectedMonth = DateFormat('yyyy').format(selected!);
    }
  }

  @override
  void didUpdateWidget(covariant AppYearField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      setState(() {
        selected = widget.initialDate;
        if (selected != null) {
          selectedMonth = DateFormat('yyyy').format(selected!);
        } else {
          selectedMonth = "";
        }
      });
    }
  }

  Future<void> onTap() async {
    final picked = await AppYearPicker.pick(context, initialDate: selected);

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        selected = picked;
        selectedMonth = DateFormat('yyyy').format(selected!);
      });
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.variant.padding + 4,
          vertical: widget.variant.padding,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 0.5, color: Colors.grey.shade600),
        ),
        child: Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: widget.variant.iconSize,
              color: context.color.onPrimaryFixedVariant,
            ),
            Text(
              selectedMonth.trim().isNotEmpty ? selectedMonth : widget.hint,
              style: context.text.labelLarge?.copyWith(
                color: context.color.onPrimaryFixedVariant,
                fontWeight: FontWeight.w600,
                fontSize: widget.variant.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppYearPicker {
  static Future<DateTime?> pick(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return showDialog<DateTime>(
      context: context,
      builder: (_) => _YearPickerDialog(
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(2100),
      ),
    );
  }
}

class _YearPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const _YearPickerDialog({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<_YearPickerDialog> createState() => _YearPickerDialogState();
}

class _YearPickerDialogState extends State<_YearPickerDialog> {
  late int selectedYear;
  late ScrollController _scrollController;

  late List<int> years;

  @override
  void initState() {
    super.initState();

    selectedYear = widget.initialDate.year;

    final currentYear = DateTime.now().year;

    final lastYear = widget.lastDate.year > currentYear
        ? currentYear
        : widget.lastDate.year;

    years = List.generate(
      lastYear - widget.firstDate.year + 1,
      (index) => widget.firstDate.year + index,
    );

    final selectedIndex = years.indexOf(selectedYear);
    final row = selectedIndex < 0 ? 0 : selectedIndex ~/ 3;

    _scrollController = ScrollController(initialScrollOffset: row * 60.0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _selectYear(int year) {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.pixels);
    }
    Navigator.pop(context, DateTime(year));
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return AlertDialog(
      title: const Text("Select Year"),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: GridView.builder(
          controller: _scrollController,
          itemCount: years.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            final year = years[index];
            final isSelected = year == selectedYear;
            final isFuture = year > currentYear;

            return GestureDetector(
              onTap: isFuture
                  ? null
                  : () {
                      _selectYear(year);
                    },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$year",
                  style: TextStyle(
                    color: isFuture
                        ? Colors.grey
                        : isSelected
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
