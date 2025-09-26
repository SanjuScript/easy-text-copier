import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  final TextRecognizer _textRecognizer;

  OCRService()
    : _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<List<TextBlock>> extractText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final result = await _textRecognizer.processImage(inputImage);
    return result.blocks;
  }

  Future<void> dispose() async {
    await _textRecognizer.close();
  }
}
