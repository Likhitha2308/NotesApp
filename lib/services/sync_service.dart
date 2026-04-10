import 'package:notesapp/data_models/local/hive_boxes.dart';
import 'package:notesapp/data_models/sync_item_model.dart';
import 'package:notesapp/services/api_services.dart';
import 'package:notesapp/services/network_checker.dart';

class SyncService {
  final ApiService apiService = ApiService();

  Future<void> processQueue() async {
    final box = HiveBoxes.queueBox;

    print("Queue size: ${box.length}");

    final keys = box.keys.toList();

    for (var key in keys) {
      final item = SyncItem.fromMap(Map<String, dynamic>.from(box.get(key)));

      try {
        bool online = await NetworkChecker.isOnline();
        if (!online) return;

        if (item.type == "add_note") {
          await apiService.addNote(item.data);
        } else if (item.type == "delete_note") {
          await apiService.deleteNote(item.data['id']);
        }

        print("Sync success: ${item.id}");

        await box.delete(key);
      } catch (e) {
        print("Sync failed: ${item.id}");

        if (item.retryCount < 1) {
          item.retryCount++;

          await Future.delayed(Duration(seconds: 2));
          await box.put(key, item.toMap());
        } else {
          print("Retry limit reached for ${item.id}");
        }
      }
    }
  }
}
