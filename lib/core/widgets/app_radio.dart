import 'package:flutter/material.dart';

class AppRadioItem<T> {
  final T value;
  final String title;

  const AppRadioItem({required this.value, required this.title});
}

class AppRadioGroup<T> extends StatelessWidget {
  final List<AppRadioItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  final Widget? title;
  final Axis direction;

  const AppRadioGroup({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.title,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return RadioGroup<T>(
      groupValue: value,
      onChanged: onChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (title != null) ...[title!, const SizedBox(height: 8)],

          direction == Axis.vertical
              ? Column(children: _buildItems())
              : Wrap(spacing: 6, children: _buildItems()),
        ],
      ),
    );
  }

  List<Widget> _buildItems() {
    return items.map((item) {
      return GestureDetector(
        onTap: () => onChanged(item.value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<T>(value: item.value),
            Text(item.title),
          ],
        ),
      );
    }).toList();
  }
}
