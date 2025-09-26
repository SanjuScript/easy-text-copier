import 'package:get_it/get_it.dart';
import 'services/storage_service.dart';
import '../providers/copied_text_provider.dart';

final getIt = GetIt.instance;

void setupDI() {
  final storageService = StorageService();
  getIt.registerSingleton<StorageService>(storageService);

  getIt.registerSingleton<CopiedTextProvider>(
      CopiedTextProvider(storageService: storageService));
}
