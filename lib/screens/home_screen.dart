import 'dart:io';
import 'package:easy_text_copier/core/services/clipboard_service.dart';
import 'package:easy_text_copier/core/services/ocr_service.dart';
import 'package:easy_text_copier/providers/copied_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageFile;
  List<TextBlock> _textBlocks = [];
  bool _isLoading = false;
  late OCRService _ocrService;

  @override
  void initState() {
    super.initState();
    _ocrService = OCRService();
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }

  Future<void> _runOCR(File file) async {
    setState(() => _isLoading = true);

    final blocks = await _ocrService.extractText(file);

    setState(() {
      _textBlocks = blocks;
      _isLoading = false;
    });
  }

  String get _recognizedText =>
      _textBlocks.map((block) => block.text).join("\n\n");

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sharedPath = context.watch<CopiedTextProvider>().sharedFilePath;

    if (sharedPath != null && sharedPath.isNotEmpty) {
      final file = File(sharedPath);
      if (imageFile?.path != file.path) {
        imageFile = file;
        _runOCR(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageFile == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            " Share a screenshot to this app",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Quick Copier"), centerTitle: false),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  children: [
                    ListTile(
                      leading: Image.file(imageFile!, fit: BoxFit.contain),
                      title: Text(imageFile!.path),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: _textBlocks.isEmpty
                          ? const Center(
                              child: Text(
                                "No text detected 😔",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 80),
                              child: SelectableText(
                                _recognizedText,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                                showCursor: true,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),

      floatingActionButton: _textBlocks.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                ClipboardService.copyText(context, _recognizedText);
              },
              icon: const Icon(Icons.copy),
              label: const Text("Copy All"),
            )
          : null,
    );
  }
}
