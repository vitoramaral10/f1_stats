import '../entities/entities.dart';

abstract class LoadRaceControl {
  Future<List<RaceControlEntity>> call({required int sessionKey});
}
