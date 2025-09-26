import 'package:easy_text_copier/model/copied_item.dart';
import 'package:flutter/material.dart';
import '../core/services/storage_service.dart';

class CopiedTextProvider extends ChangeNotifier {
  final StorageService storageService;
  CopiedItem? _lastCopied;
  String? _sharedFilePath;

  CopiedItem? get lastCopied => _lastCopied;
  String? get sharedFilePath => _sharedFilePath;

  CopiedTextProvider({required this.storageService}) {
    _lastCopied = storageService.getLastCopied();
  }

  Future<void> updateCopiedText(String text) async {
    await storageService.saveCopiedText(text);
    _lastCopied = storageService.getLastCopied();
    notifyListeners();
  }

  void setSharedFilePath(String? path) {
    _sharedFilePath = path;
    notifyListeners();
  }
}
