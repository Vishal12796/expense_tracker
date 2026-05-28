import 'package:flutter/material.dart';

enum ExpenseCategory {
  food,
  petrol,
  recharge,
  rent,
  shopping,
  movie,
  medicine,
  bills,
  others,
}

extension ExpenseCategoryX on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.food:
        return "Food";
      case ExpenseCategory.petrol:
        return "Petrol";
      case ExpenseCategory.recharge:
        return "Recharge";
      case ExpenseCategory.rent:
        return "Rent";
      case ExpenseCategory.shopping:
        return "Shopping";
      case ExpenseCategory.movie:
        return "Movie";
      case ExpenseCategory.medicine:
        return "Medicine";
      case ExpenseCategory.bills:
        return "Bills";
      case ExpenseCategory.others:
        return "Others";
    }
  }

  IconData get icon {
    switch (this) {
      case ExpenseCategory.food:
        return Icons.restaurant;
      case ExpenseCategory.petrol:
        return Icons.local_gas_station;
      case ExpenseCategory.recharge:
        return Icons.phone_android;
      case ExpenseCategory.rent:
        return Icons.home;
      case ExpenseCategory.shopping:
        return Icons.shopping_bag;
      case ExpenseCategory.movie:
        return Icons.movie_creation_outlined;
      case ExpenseCategory.medicine:
        return Icons.medical_services;
      case ExpenseCategory.bills:
        return Icons.receipt_long;
      case ExpenseCategory.others:
        return Icons.category;
    }
  }

  Color get color {
    switch (this) {
      case ExpenseCategory.food:
        return const Color(0xFFFF5722); // Vibrant Orange
      case ExpenseCategory.petrol:
        return const Color(0xFF2196F3); // Bright Blue
      case ExpenseCategory.recharge:
        return const Color(0xFF9C27B0); // Vibrant Purple
      case ExpenseCategory.rent:
        return const Color(0xFFE91E63); // Bright Pink/Red
      case ExpenseCategory.shopping:
        return const Color(0xFF00BCD4); // Cyan
      case ExpenseCategory.movie:
        return const Color(0xFF4CAF50); // Bright Green
      case ExpenseCategory.medicine:
        return const Color(0xFF009688); // Teal
      case ExpenseCategory.bills:
        return const Color(0xFF3F51B5); // Indigo
      case ExpenseCategory.others:
        return const Color(0xFF607D8B); // Blue Grey
    }
  }

  /// String -> Enum (very useful for API / DB)
  static ExpenseCategory fromString(String value) {
    return ExpenseCategory.values.firstWhere(
      (e) => e.label == value,
      orElse: () => ExpenseCategory.others,
    );
  }
}
