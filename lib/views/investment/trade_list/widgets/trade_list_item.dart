import 'package:expense_tracker/data/models/trade_list_model.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:flutter/material.dart';
import '../../../../core/extension/context_extension.dart';

class TradeListItem extends StatelessWidget {
  final TradeListModel trade;
  final VoidCallback? onTap;

  const TradeListItem({super.key, required this.trade, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = trade.isProfit ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: context.color.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withValues(alpha: 0.1),
                child: Icon(
                  trade.isProfit ? Icons.trending_up : Icons.trending_down,
                  size: 24,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trade.notes.isEmpty ? "Trade" : trade.notes,
                      style: context.text.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatDate(trade.date),
                      style: context.text.bodySmall?.copyWith(
                        color: context.color.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                trade.amountText,
                style: context.text.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
