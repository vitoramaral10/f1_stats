import '../entities/entities.dart';

abstract class LoadIntervals {
  Future<List<IntervalEntity>> call({required int sessionKey});
}
