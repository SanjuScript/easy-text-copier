import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ClipboardService {
  static Future<void> copyText(
    BuildContext context,
    String text, {
    bool showSnackbar = true,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (showSnackbar && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Text copied to clipboard!")),
      );
    }
  }
}
