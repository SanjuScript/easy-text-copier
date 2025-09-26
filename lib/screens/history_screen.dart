import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/copied_text_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final copiedProvider = context.watch<CopiedTextProvider>();
    final lastCopied = copiedProvider.lastCopied;

    return Scaffold(
      appBar: AppBar(title: const Text("Copied History")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: lastCopied == null
            ? const Center(child: Text("No copied text yet"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Last Copied Text:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SelectableText(lastCopied.text),
                  const SizedBox(height: 16),
                  Text("Copied on: ${lastCopied.timestamp}"),
                ],
              ),
      ),
    );
  }
}
