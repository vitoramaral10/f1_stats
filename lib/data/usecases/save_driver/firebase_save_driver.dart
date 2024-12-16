import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firebase/firebase.dart';

class FirebaseSaveDriver implements SaveDriver {
  final FirebaseClient firebase;

  FirebaseSaveDriver({
    required this.firebase,
  });

  @override
  Future<void> call(DriverEntity driver) async {
    try {
      await firebase.create('drivers', driver.toJson());
    } on FirebaseError {
      log('FirebaseError', name: 'FirebaseLoadDrivers.call');
      throw DomainError.unexpected;
    }
  }
}
