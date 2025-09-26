import 'package:hive/hive.dart';

part 'copied_item.g.dart';

@HiveType(typeId: 0)
class CopiedItem {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final DateTime timestamp;

  CopiedItem({required this.text, required this.timestamp});
}
