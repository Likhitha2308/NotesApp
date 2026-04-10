import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/providers/note_provider.dart';
import 'package:notesapp/screens/note_screen.dart';
import 'package:notesapp/services/sync_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('notes');
  await Hive.openBox('queue');

  // 🔥 Load notes BEFORE UI
  final noteProvider = NoteProvider();
  noteProvider.loadNotes();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => noteProvider)],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 🔥 Run sync in background (non-blocking)
    Future.delayed(Duration(seconds: 1), () {
      SyncService().processQueue();
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      home: NotesScreen(),
    );
  }
}
