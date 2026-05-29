import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../extension/context_extension.dart';

enum MonthFiledVariant { big, small }

extension MonthFiledVariantX on MonthFiledVariant {
  double get fontSize {
    switch (this) {
      case MonthFiledVariant.big:
        return 16;
      case MonthFiledVariant.small:
        return 13;
    }
  }

  double get iconSize {
    switch (this) {
      case MonthFiledVariant.big:
        return 20;
      case MonthFiledVariant.small:
        return 16;
    }
  }

  double get padding {
    switch (this) {
      case MonthFiledVariant.big:
        return 12;
      case MonthFiledVariant.small:
        return 8;
    }
  }
}

class AppMonthYearField extends StatefulWidget {
  final String hint;
  final MonthFiledVariant variant;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? initialDate;
  final bool inverted;

  const AppMonthYearField({
    super.key,
    this.hint = "Select Month",
    this.variant = MonthFiledVariant.big,
    this.onChanged,
    this.initialDate,
    this.inverted = false,
  });

  @override
  State<AppMonthYearField> createState() => _AppMonthYearFieldState();
}

class _AppMonthYearFieldState extends State<AppMonthYearField> {
  DateTime? selected;
  String selectedMonth = "";

  @override
  void initState() {
    super.initState();
    selected = widget.initialDate;
    if (selected != null) {
      selectedMonth = DateFormat('MMM yyyy').format(selected!);
    }
  }

  @override
  void didUpdateWidget(covariant AppMonthYearField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      setState(() {
        selected = widget.initialDate;
        if (selected != null) {
          selectedMonth = DateFormat('MMM yyyy').format(selected!);
        } else {
          selectedMonth = "";
        }
      });
    }
  }

  Future<void> onTap() async {
    final picked = await AppMonthYearPicker.pick(
      context,
      initialDate: selected,
    );

    if (picked != null) {
      setState(() {
        selected = picked;
        selectedMonth = selected != null
            ? DateFormat('MMM yyyy').format(selected!)
            : widget.hint;
      });
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool useWhite = widget.inverted || widget.variant == MonthFiledVariant.small;
    // Overriding the automatic white for small variant if it's explicitly not inverted? 
    // Actually, let's just use the 'inverted' flag to control the color.
    // If inverted is true, it's for dark backgrounds (white text).
    // If inverted is false, it's for light backgrounds (themed text).

    final Color contentColor = widget.inverted ? Colors.white : context.color.onSurface;
    final Color iconColor = widget.inverted ? Colors.white : context.color.primary;
    final Color bgColor = widget.inverted 
        ? Colors.white.withValues(alpha: 0.2) 
        : context.color.surfaceContainerHighest.withValues(alpha: 0.5);
    final Color borderColor = widget.inverted 
        ? Colors.white.withValues(alpha: 0.3) 
        : context.color.outlineVariant;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.variant.padding + 4,
          vertical: widget.variant.padding - 2,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: widget.variant.iconSize,
              color: iconColor,
            ),
            Text(
              selectedMonth.trim().isNotEmpty ? selectedMonth : widget.hint,
              style: context.text.labelLarge?.copyWith(
                color: contentColor,
                fontWeight: FontWeight.w600,
                fontSize: widget.variant.fontSize,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: widget.variant.iconSize,
              color: widget.inverted ? Colors.white70 : context.color.onSurfaceVariant,
            ),
          ],
        ),
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
    return showGeneralDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) => _MonthYearPickerDialog(
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(2100),
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.color.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Month & Year",
              style: context.text.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // Year selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: context.color.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.color.outlineVariant),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => changeYear(-1),
                    icon: const Icon(Icons.chevron_left_rounded),
                    color: context.color.primary,
                  ),
                  Text(
                    "$selectedYear",
                    style: context.text.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.color.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => changeYear(1),
                    icon: const Icon(Icons.chevron_right_rounded),
                    color: context.color.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Month grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final month = index + 1;
                final isCurrentSelection = month == selectedMonth;

                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, DateTime(selectedYear, month));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isCurrentSelection
                          ? context.color.primary
                          : context.color.surfaceContainerHighest
                              .withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: isCurrentSelection
                          ? null
                          : Border.all(color: context.color.outlineVariant),
                    ),
                    child: Text(
                      DateFormat('MMM').format(DateTime(selectedYear, month)),
                      style: context.text.labelMedium?.copyWith(
                        color: isCurrentSelection
                            ? context.color.onPrimary
                            : context.color.onSurfaceVariant,
                        fontWeight: isCurrentSelection
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
