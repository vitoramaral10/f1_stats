import 'dart:developer';

import 'package:f1_stats/domain/entities/driver_entity.dart';
import 'package:f1_stats/domain/usecases/load_drivers.dart';

import '../../../domain/helpers/helpers.dart';
import '../../firebase/firebase.dart';
import '../../models/models.dart';

class FirebaseLoadDrivers implements LoadDrivers {
  final FirebaseClient firebaseClient;

  FirebaseLoadDrivers({required this.firebaseClient});

  @override
  Future<List<DriverEntity>> call() async {
    try {
      final result = await firebaseClient.getCollection('drivers');

      return result
          .map<DriverEntity>((json) => DriverModel.fromJson(json).toEntity())
          .toList();
    } on FirebaseError catch (e) {
      log(e.toString(), name: 'FirebaseLoadDrivers.call');
      throw DomainError.unexpected;
    }
  }
}
