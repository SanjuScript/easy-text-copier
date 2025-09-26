import 'package:easy_text_copier/model/copied_item.dart';
import 'package:hive/hive.dart';

class StorageService {
  static const String boxName = 'copied_items';

  Future<void> init() async {
    await Hive.openBox<CopiedItem>(boxName);
  }

  Future<void> saveCopiedText(String text) async {
    final box = Hive.box<CopiedItem>(boxName);
    final item = CopiedItem(text: text, timestamp: DateTime.now());
    await box.put('last_copied', item);
  }

  CopiedItem? getLastCopied() {
    final box = Hive.box<CopiedItem>(boxName);
    return box.get('last_copied');
  }
}
