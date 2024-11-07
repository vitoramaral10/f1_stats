import '../entities/entities.dart';

abstract class LoadPositions {
  Future<List<PositionEntity>> call({
    required String meetingKey,
    required String sessionKey,
  });
}
