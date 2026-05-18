class TradeListModel {
  final String id;
  final double amount;
  final DateTime date;
  final String notes;
  final bool isProfit;

  const TradeListModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.notes,
    required this.isProfit,
  });

  TradeListModel copyWith({
    String? id,
    double? amount,
    DateTime? date,
    String? notes,
    bool? isProfit,
  }) {
    return TradeListModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      isProfit: isProfit ?? this.isProfit,
    );
  }

  double get signedAmount => isProfit ? amount : -amount;

  String get amountText {
    final sign = isProfit ? '+' : '-';
    return '$sign${amount.toStringAsFixed(0)}';
  }
}
