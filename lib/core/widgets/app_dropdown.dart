import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AppDropdownField extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final ValueNotifier<String?>? controller; // external OR internal
  final String? Function(String?)? validator;

  const AppDropdownField({
    super.key,
    required this.items,
    required this.hintText,
    this.controller,
    this.validator,
  });

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  late ValueNotifier<String?> _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = widget.controller ?? ValueNotifier<String?>(null);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _notifier.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,

      valueListenable: _notifier,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),

      hint: Text(
        widget.hintText,
        style: Theme.of(context).textTheme.titleMedium,
      ),

      items: widget.items.map((item) {
        return DropdownItem<String>(value: item, child: Text(item));
      }).toList(),

      validator: widget.validator,

      onChanged: (value) {
        _notifier.value = value; // ✅ handled internally
      },

      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
      ),

      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      ),

      menuItemStyleData: const MenuItemStyleData(
        useDecorationHorizontalPadding: true,
      ),
    );
  }
}
