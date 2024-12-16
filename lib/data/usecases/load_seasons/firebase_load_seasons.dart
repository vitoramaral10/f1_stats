import 'dart:developer';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firebase/firebase.dart';

class FirebaseLoadSeasons implements LoadSeasons {
  final FirebaseClient firebase;

  FirebaseLoadSeasons({
    required this.firebase,
  });

  @override
  Future<List<int>> call() async {
    try {
      final data = await firebase.readAll('seasons');

      return data.map<int>((json) => json['year']).toList();
    } on FirebaseError {
      log('FirebaseError', name: 'FirebaseLoadSeasons.call');
      throw DomainError.unexpected;
    }
  }
}
