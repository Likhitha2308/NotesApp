class ApiService {
  Future<void> addNote(Map<String, dynamic> note) async {
    await Future.delayed(Duration(seconds: 1));

    if (DateTime.now().second % 2 == 0) {
      throw Exception("Random API Failure");
    }

    print("API SUCCESS: Note added");
  }

  Future<void> deleteNote(String id) async {
    await Future.delayed(Duration(seconds: 1));

    if (DateTime.now().second % 2 == 0) {
      throw Exception("Random API Failure");
    }

    print("API SUCCESS: Note deleted");
  }
}
