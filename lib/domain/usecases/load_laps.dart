import '../entities/entities.dart';

abstract class LoadLaps {
  Future<List<LapEntity>> call({
    required int sessionKey,
    DateTime? lastUpdate,
  });
}
