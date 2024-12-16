import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/firebase/firebase.dart';

class FirebaseAdapter implements FirebaseClient {
  @override
  Future<void> create(String path, Map<String, dynamic> data) async {
    try {
      final db = FirebaseFirestore.instance;

      await db.collection(path).add(data);
    } catch (error) {
      throw FirebaseError.unexpected;
    }
  }

  @override
  Future<void> delete(String path, String id) async {
    try {
      final db = FirebaseFirestore.instance;

      db.collection(path).doc(id).delete();
    } catch (error) {
      throw FirebaseError.unexpected;
    }
  }

  @override
  Future<Map<String, dynamic>> read(String path) {
    try {
      final db = FirebaseFirestore.instance;

      return db.collection(path).doc().get().then((value) => value.data()!);
    } catch (error) {
      throw FirebaseError.unexpected;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> readAll(String path) {
    try {
      final db = FirebaseFirestore.instance;

      return db.collection(path).get().then((value) {
        return value.docs.map((e) {
          final data = e.data();
          data['id'] = e.id;
          return data;
        }).toList();
      });
    } catch (error) {
      throw FirebaseError.unexpected;
    }
  }

  @override
  Future<void> update(String path, Map<String, dynamic> data) async {
    try {
      final db = FirebaseFirestore.instance;

      db.collection(path).doc(data['id']).update(data);
    } catch (error) {
      throw FirebaseError.unexpected;
    }
  }
}
