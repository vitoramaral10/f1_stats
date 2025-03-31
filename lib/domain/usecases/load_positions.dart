import '../entities/entities.dart';

abstract class LoadPositions {
  Future<List<PositionEntity>> call({
    required int sessionKey,
    DateTime? lastUpdate,
  });
}
