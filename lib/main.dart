import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:easy_text_copier/core/di.dart';
import 'package:easy_text_copier/core/services/storage_service.dart';
import 'package:easy_text_copier/model/copied_item.dart';
import 'package:easy_text_copier/providers/copied_text_provider.dart';
import 'package:easy_text_copier/screens/history_screen.dart';
import 'package:easy_text_copier/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CopiedItemAdapter().typeId)) {
    Hive.registerAdapter(CopiedItemAdapter());
  }
  await Hive.openBox<CopiedItem>(StorageService.boxName);
  setupDI();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CopiedTextProvider>(
          create: (_) => getIt<CopiedTextProvider>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _intentSub;
  File? _sharedFile;

  @override
  void initState() {
    super.initState();

    // Listen while app is running
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((files) {
      if (files.isNotEmpty) {
        log(
          "📩 Received file from share: ${files.first.path}",
          name: "ReceiveSharingIntent",
        );
        setState(() {
          _sharedFile = File(files.first.path);
        });
      } else {
        log("⚠️ No files received in stream.", name: "ReceiveSharingIntent");
      }
    });

    // Check if app opened via share
    ReceiveSharingIntent.instance.getInitialMedia().then((files) {
      if (files.isNotEmpty) {
        final path = files.first.path;
        log("📂 Received file path: $path");
        log("📂 File exists? ${File(path).existsSync()}");
        setState(() {
          _sharedFile = File(path);
        });
      } else {
        log("⚠️ No files received on app open.");
      }
    });
  }

  @override
  void dispose() {
    _intentSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_sharedFile != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CopiedTextProvider>().setSharedFilePath(_sharedFile!.path);
      });
    }

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
      routes: {'/history': (_) => const HistoryScreen()},
    );
  }
}
