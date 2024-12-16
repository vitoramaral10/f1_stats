import 'dart:developer';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firebase/firebase.dart';

class FirebaseRemoveDriver implements RemoveDriver {
  final FirebaseClient firebase;

  FirebaseRemoveDriver({
    required this.firebase,
  });

  @override
  Future<void> call(String id) async {
    try {
      await firebase.delete(
        'drivers',
        id,
      );
    } on FirebaseError {
      log('FirebaseError', name: 'FirebaseLoadDrivers.call');
      throw DomainError.unexpected;
    }
  }
}
