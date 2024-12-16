abstract class FirebaseClient {
  Future<void> create(String path, Map<String, dynamic> data);
  Future<void> update(String path, Map<String, dynamic> data);
  Future<void> delete(String path, String id);
  Future<Map<String, dynamic>> read(String path);
  Future<List<Map<String, dynamic>>> readAll(String path);
}
