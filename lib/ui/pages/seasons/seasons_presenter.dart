import '../../../domain/entities/entities.dart';

abstract class SeasonsPresenter {
  List<SeasonEntity> get seasons;

  Future<void> getAllSeasons();
}
