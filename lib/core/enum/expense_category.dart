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
        return Colors.orange;
      case ExpenseCategory.petrol:
        return Colors.blue;
      case ExpenseCategory.recharge:
        return Colors.purple;
      case ExpenseCategory.rent:
        return Colors.red;
      case ExpenseCategory.shopping:
        return Colors.pink;
      case ExpenseCategory.movie:
        return Colors.green;
      case ExpenseCategory.medicine:
        return Colors.teal;
      case ExpenseCategory.bills:
        return Colors.indigo;
      case ExpenseCategory.others:
        return Colors.grey;
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
