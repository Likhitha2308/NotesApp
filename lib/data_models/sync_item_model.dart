class SyncItem {
  String id;
  String type; // add_note / delete_note
  Map<String, dynamic> data;
  int retryCount;

  SyncItem({
    required this.id,
    required this.type,
    required this.data,
    this.retryCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'type': type, 'data': data, 'retryCount': retryCount};
  }

  factory SyncItem.fromMap(Map map) {
    return SyncItem(
      id: map['id'],
      type: map['type'],
      data: Map<String, dynamic>.from(map['data']),
      retryCount: map['retryCount'] ?? 0,
    );
  }
}
