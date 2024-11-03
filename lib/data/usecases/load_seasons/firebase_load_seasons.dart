import 'dart:developer';

import 'package:f1_stats/domain/entities/season_entity.dart';
import 'package:f1_stats/domain/usecases/load_seasons.dart';

import '../../../domain/helpers/helpers.dart';
import '../../firebase/firebase.dart';
import '../../models/models.dart';

class FirebaseLoadSeasons implements LoadSeasons {
  final FirebaseClient firebaseClient;

  FirebaseLoadSeasons({required this.firebaseClient});

  @override
  Future<List<SeasonEntity>> call() async {
    try {
      final result = await firebaseClient.getCollection('seasons');

      return result
          .map<SeasonEntity>((json) => SeasonModel.fromJson(json).toEntity())
          .toList();
    } on FirebaseError catch (e) {
      log(e.toString(), name: 'FirebaseLoadSeasons.call');
      throw DomainError.unexpected;
    }
  }
}
