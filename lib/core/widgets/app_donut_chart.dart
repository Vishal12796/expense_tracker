import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutChartData {
  final String label;
  final double value;
  final Color color;

  DonutChartData({
    required this.label,
    required this.value,
    required this.color,
  });
}

class AppDonutChart extends StatefulWidget {
  final List<DonutChartData> data;
  final double totalAmount;
  final String centerLabel;

  const AppDonutChart({
    super.key,
    required this.data,
    required this.totalAmount,
    this.centerLabel = "Amount",
  });

  @override
  State<AppDonutChart> createState() => _AppDonutChartState();
}

class _AppDonutChartState extends State<AppDonutChart> {
  int touchedIndex = -1;

  // 16 distinct bright colors for future-proofing custom categories
  final List<Color> extendedPalette = [
    const Color(0xFF2196F3), // Blue
    const Color(0xFF4CAF50), // Green
    const Color(0xFFFFC107), // Amber
    const Color(0xFFFF5722), // Deep Orange
    const Color(0xFF9C27B0), // Purple
    const Color(0xFFE91E63), // Pink
    const Color(0xFF00BCD4), // Cyan
    const Color(0xFF009688), // Teal
    const Color(0xFF3F51B5), // Indigo
    const Color(0xFF8BC34A), // Light Green
    const Color(0xFFFF9800), // Orange
    const Color(0xFF673AB7), // Deep Purple
    const Color(0xFFCDDC39), // Lime
    const Color(0xFFFF4081), // Accent Pink
    const Color(0xFF448AFF), // Accent Blue
    const Color(0xFF00E676), // Accent Green
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        // 1. Chart Section
        AspectRatio(
          aspectRatio: 1.5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  sectionsSpace: 4,
                  centerSpaceRadius: 70,
                  startDegreeOffset: -90,
                  sections: widget.data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isTouched = index == touchedIndex;

                    // Fallback to extended palette for custom categories
                    final Color color = (item.color == Colors.grey ||
                            item.color == const Color(0xFF607D8B))
                        ? extendedPalette[index % extendedPalette.length]
                        : item.color;

                    return PieChartSectionData(
                      color: color,
                      value: item.value,
                      title: isTouched
                          ? '${(item.value / widget.totalAmount * 100).toStringAsFixed(0)}%'
                          : "",
                      radius: isTouched ? 38.0 : 30.0,
                      titleStyle: context.text.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Dynamic Central Label - Displays category info on touch, or total amount by default
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  key: ValueKey(touchedIndex),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      touchedIndex == -1
                          ? widget.centerLabel
                          : widget.data[touchedIndex].label,
                      textAlign: TextAlign.center,
                      style: context.text.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${Utils.moneySymbol}${touchedIndex == -1 ? widget.totalAmount.toStringAsFixed(0) : widget.data[touchedIndex].value.toStringAsFixed(0)}",
                      style: context.text.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: context.color.onSurface,
                      ),
                    ),
                    if (touchedIndex != -1)
                      Text(
                        "${(widget.data[touchedIndex].value / widget.totalAmount * 100).toStringAsFixed(1)}%",
                        style: context.text.labelSmall?.copyWith(
                          color: context.color.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // 2. Legend
        Wrap(
          spacing: 16,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: widget.data.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final color = (item.color == Colors.grey ||
                    item.color == const Color(0xFF607D8B))
                ? extendedPalette[index % extendedPalette.length]
                : item.color;

            return _LegendItem(
              label: item.label,
              color: color,
              isTouched: index == touchedIndex,
              isAnyTouched: touchedIndex != -1,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final bool isTouched;
  final bool isAnyTouched;

  const _LegendItem({
    required this.label,
    required this.color,
    required this.isTouched,
    required this.isAnyTouched,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isTouched || !isAnyTouched ? 1.0 : 0.4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: context.text.labelMedium?.copyWith(
              fontWeight: isTouched ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
