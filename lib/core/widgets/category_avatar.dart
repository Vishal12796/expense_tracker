import 'package:expense_tracker/core/enum/expense_category.dart';
import 'package:flutter/material.dart';

class CategoryAvatar extends StatelessWidget {
  final ExpenseCategory category;
  final double radius;
  final double iconSize;
  final double opacity;

  const CategoryAvatar({
    super.key,
    required this.category,
    this.radius = 20,
    this.iconSize = 20,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    final color = category.color;

    return CircleAvatar(
      radius: radius,
      backgroundColor: color.withOpacity(opacity),
      child: Icon(category.icon, size: iconSize, color: color),
    );
  }
}
