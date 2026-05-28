import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AppMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double iconSize;

  const AppMetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.color,
    this.padding = const EdgeInsets.all(14),
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card.filled(
        color: color.withValues(alpha: 0.1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withValues(alpha: 0.2)),
        ),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: iconSize),
              const SizedBox(height: 10),
              Text(
                title,
                style: context.text.labelMedium?.copyWith(
                  color: context.color.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: context.text.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.color.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle ?? '',
                style: context.text.bodySmall?.copyWith(
                  color: context.color.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
