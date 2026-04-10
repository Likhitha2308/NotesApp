import 'package:notesapp/data_models/local/hive_boxes.dart';
import 'package:notesapp/data_models/note_model.dart';
import 'package:notesapp/data_models/sync_item_model.dart';
import 'package:notesapp/services/sync_service.dart';
import 'package:uuid/uuid.dart';

class NoteRepository {
  final syncService = SyncService();
  final uuid = Uuid();

  Future<void> addNote(String title, String content) async {
    final id = uuid.v4();

    final note = Note(
      id: id,
      title: title,
      content: content,
      updatedAt: DateTime.now(),
    );

    // ✅ Save locally (instant UI)
    HiveBoxes.notesBox.put(id, note.toMap());

    // ✅ Add to queue
    final syncItem = SyncItem(
      id: uuid.v4(),
      type: "add_note",
      data: note.toMap(),
    );

    HiveBoxes.queueBox.put(syncItem.id, syncItem.toMap());

    // 🔥 Background sync (no await)
    syncService.processQueue();
  }

  Future<void> deleteNote(String id) async {
    // ✅ Delete locally (instant UI)
    HiveBoxes.notesBox.delete(id);

    // ✅ Add to queue
    final syncItem = SyncItem(
      id: uuid.v4(),
      type: "delete_note",
      data: {"id": id},
    );

    HiveBoxes.queueBox.put(syncItem.id, syncItem.toMap());

    // 🔥 Background sync (no await)
    syncService.processQueue();
  }

  List<Note> getNotes() {
    return HiveBoxes.notesBox.values
        .map((e) => Note.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}
