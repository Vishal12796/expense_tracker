import 'dart:convert';

import 'package:expense_tracker/core/enum/expense_category.dart';

class ExpenseModel {
  final double amount;
  final DateTime date;
  final String name;
  final String description;
  final String id;
  final ExpenseCategory category;

  const ExpenseModel({
    required this.amount,
    required this.date,
    required this.name,
    required this.description,
    required this.id,
    required this.category,
  });

  /// 🔁 CopyWith (very important)
  ExpenseModel copyWith({
    double? amount,
    DateTime? date,
    String? name,
    String? description,
    String? id,
    ExpenseCategory? category,
  }) {
    return ExpenseModel(
      amount: amount ?? this.amount,
      date: date ?? this.date,
      name: name ?? this.name,
      description: description ?? this.description,
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }

  /// 📦 Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'date': date.toIso8601String(),
      'name': name,
      'description': description,
      'id': id,
      'category': category.label,
    };
  }

  /// 📥 From Map
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      amount: (map['amount'] ?? 0).toDouble(),
      date: DateTime.parse(map['date']),
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      id: map['id'] ?? '',
      category: ExpenseCategoryX.fromString(map['category']),
    );
  }

  /// 🔄 JSON helpers
  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  /// 🧠 Equality (very useful)
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.amount == amount &&
        other.date == date &&
        other.name == name &&
        other.description == description &&
        other.id == id &&
        other.category == category;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        date.hashCode ^
        name.hashCode ^
        description.hashCode ^
        id.hashCode ^
        category.hashCode;
  }

  @override
  String toString() {
    return 'ExpenseModel(amount: $amount, date: $date, name: $name, description: $description, id: $id, category: $category)';
  }
}
