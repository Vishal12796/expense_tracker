import 'package:flutter/material.dart';
import '../../../../core/extension/context_extension.dart';

class TradeListItem extends StatelessWidget {
  final int index;

  const TradeListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    Color color = index % 2 == 0 ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: () {},
      child: Card.filled(
        color: Colors.white,
        elevation: 1,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withValues(alpha: 0.2),
                child: Icon(Icons.show_chart, size: 20, color: color),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "08 Apr",
                      style: context.text.labelMedium?.copyWith(
                        color: context.color.onPrimaryFixed,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "market moment high",
                      style: context.text.labelSmall?.copyWith(
                        color: context.color.secondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    index % 2 == 0 ? "+200" : "-100",
                    style: context.text.titleLarge?.copyWith(color: color),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
