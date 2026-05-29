import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../extension/context_extension.dart';

class AppYearField extends StatefulWidget {
  final String hint;
  final MonthFiledVariant variant;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? initialDate;
  final bool inverted;

  const AppYearField({
    super.key,
    this.hint = "Select Year",
    this.variant = MonthFiledVariant.big,
    this.onChanged,
    this.initialDate,
    this.inverted = false,
  });

  @override
  State<AppYearField> createState() => _AppYearFieldState();
}

class _AppYearFieldState extends State<AppYearField> {
  DateTime? selected;
  String selectedYearStr = "";

  @override
  void initState() {
    super.initState();
    selected = widget.initialDate;
    if (selected != null) {
      selectedYearStr = DateFormat('yyyy').format(selected!);
    }
  }

  @override
  void didUpdateWidget(covariant AppYearField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      setState(() {
        selected = widget.initialDate;
        if (selected != null) {
          selectedYearStr = DateFormat('yyyy').format(selected!);
        } else {
          selectedYearStr = "";
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
        selectedYearStr = DateFormat('yyyy').format(selected!);
      });
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              selectedYearStr.trim().isNotEmpty ? selectedYearStr : widget.hint,
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

class AppYearPicker {
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
      pageBuilder: (context, anim1, anim2) => _YearPickerDialog(
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
    ).reversed.toList();

    final selectedIndex = years.indexOf(selectedYear);
    final row = selectedIndex < 0 ? 0 : selectedIndex ~/ 3;

    _scrollController = ScrollController(initialScrollOffset: row * 50.0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              "Select Year",
              style: context.text.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.maxFinite,
              height: 300,
              child: GridView.builder(
                controller: _scrollController,
                itemCount: years.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  final year = years[index];
                  final isSelected = year == selectedYear;

                  return GestureDetector(
                    onTap: () => Navigator.pop(context, DateTime(year)),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.color.primary
                            : context.color.surfaceContainerHighest
                                .withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? null
                            : Border.all(color: context.color.outlineVariant),
                      ),
                      child: Text(
                        "$year",
                        style: context.text.labelMedium?.copyWith(
                          color: isSelected
                              ? context.color.onPrimary
                              : context.color.onSurfaceVariant,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
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
