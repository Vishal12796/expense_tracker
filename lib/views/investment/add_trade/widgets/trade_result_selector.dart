import 'package:expense_tracker/core/extension/context_extension.dart';
import 'package:expense_tracker/views/investment/add_trade/controller/add_trade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TradeResultSelector extends StatelessWidget {
  final AddTradeController controller;

  const TradeResultSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          _TradeResultOption(
            title: "Profit",
            icon: Icons.trending_up_rounded,
            color: const Color(0xFF0F766E),
            isSelected: controller.tradeResult.value == TradeResult.profit,
            onTap: () => controller.updateTradeResult(TradeResult.profit),
          ),
          const SizedBox(width: 10),
          _TradeResultOption(
            title: "Loss",
            icon: Icons.trending_down_rounded,
            color: const Color(0xFFB42318),
            isSelected: controller.tradeResult.value == TradeResult.loss,
            onTap: () => controller.updateTradeResult(TradeResult.loss),
          ),
        ],
      );
    });
  }
}

class _TradeResultOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _TradeResultOption({
    required this.title,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.12)
                : Colors.white.withValues(alpha: 0.64),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? color.withValues(alpha: 0.38)
                  : Colors.black.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: context.text.labelMedium?.copyWith(
                    color: isSelected ? color : context.color.onSurfaceVariant,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
