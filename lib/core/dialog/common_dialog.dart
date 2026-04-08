import 'package:flutter/material.dart';

class CommonDialog {
  static Future<bool> showConfirmDialog({
    required BuildContext context,
    String title = "Confirm",
    String message = "Are you sure?",
    String confirmText = "Yes",
    String cancelText = "Cancel",
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}
