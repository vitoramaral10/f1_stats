import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f1_stats/data/firebase/firebase.dart';

class FirebaseAdapter implements FirebaseClient {
  final FirebaseFirestore firestore;

  FirebaseAdapter({required this.firestore});

  @override
  Future<List<Map<String, dynamic>>> getCollection(String collection) {
    try {
      final result = firestore.collection(collection).get();
      return result.then((value) => value.docs.map((e) {
            Map<String, dynamic> data = e.data();
            data['id'] = e.id;
            return data;
          }).toList());
    } on FirebaseException catch (e) {
      log(e.message!, name: 'FirebaseAdapter.getCollection');
      throw FirebaseError.unexpected;
    } catch (e) {
      log(e.toString(), name: 'FirebaseAdapter.getCollection');
      throw FirebaseError.unexpected;
    }
  }
}
