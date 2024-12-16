import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firebase/firebase.dart';
import '../../models/models.dart';

class FirebaseLoadDrivers implements LoadDrivers {
  final FirebaseClient firebase;

  FirebaseLoadDrivers({
    required this.firebase,
  });

  @override
  Future<List<DriverEntity>> call() async {
    try {
      final data = await firebase.readAll('drivers');
      return data
          .map<DriverEntity>(
              (json) => FirebaseDriverModel.fromJson(json).toEntity())
          .toList();
    } on FirebaseError {
      log('FirebaseError', name: 'FirebaseLoadDrivers.call');
      throw DomainError.unexpected;
    }
  }
}
