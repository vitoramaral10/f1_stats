import '../entities/entities.dart';

abstract class LoadSeasons {
  Future<List<SeasonEntity>> call();
}
