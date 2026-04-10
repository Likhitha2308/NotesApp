import 'package:hive/hive.dart';

class HiveBoxes {
  static Box get notesBox => Hive.box('notes');
  static Box get queueBox => Hive.box('queue');
}
