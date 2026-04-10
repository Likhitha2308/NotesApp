class Note {
  String id;
  String title;
  String content;
  DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Note.fromMap(Map map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
