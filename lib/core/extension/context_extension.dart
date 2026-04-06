import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // 🎨 Theme
  ThemeData get theme => Theme.of(this);

  // 🎨 ColorScheme (your shortcut)
  ColorScheme get color => Theme.of(this).colorScheme;

  // 📝 TextTheme
  TextTheme get text => Theme.of(this).textTheme;
}
