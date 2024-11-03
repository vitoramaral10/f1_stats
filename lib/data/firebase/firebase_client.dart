abstract class FirebaseClient {
  Future<List<Map<String, dynamic>>> getCollection(String collection);
}
