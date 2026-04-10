import 'package:flutter/material.dart';
import 'package:notesapp/data_models/note_model.dart';
import 'package:notesapp/repository/note_repository.dart';
import 'package:notesapp/data_models/local/hive_boxes.dart';

class NoteProvider extends ChangeNotifier {
  final repo = NoteRepository();

  List<Note> notes = [];

  int queueSize = 0;
  int retryCount = 0;

  NoteProvider() {
    _updateQueueState();
    HiveBoxes.queueBox.watch().listen((_) => _updateQueueState());
  }

  void _updateQueueState() {
    final box = HiveBoxes.queueBox;
    queueSize = box.length;
    retryCount = box.values.where((v) {
      if (v is Map) return (v['retryCount'] ?? 0) > 0;
      return false;
    }).length;
    notifyListeners();
  }

  void loadNotes() {
    notes = repo.getNotes(); // 🔥 instant
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    await repo.addNote(title, content);
    loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await repo.deleteNote(id);
    loadNotes();
  }
}
