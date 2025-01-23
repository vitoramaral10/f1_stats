import '../entities/entities.dart';

abstract class LoadPosition {
  Future<List<PositionEntity>> call({required int sessionKey});
}
