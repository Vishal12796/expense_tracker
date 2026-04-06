import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget screenPadding() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: this);
  }

  Widget scrollPadding() {
    return Padding(padding: EdgeInsets.symmetric(vertical: 16), child: this);
  }

  Widget screenBottomPadding({double bottom = 18}) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: this,
    );
  }

  Widget paddingOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }
}
