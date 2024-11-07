import '../entities/entities.dart';

abstract class LoadIntervals {
  Future<List<IntervalEntity>> call({
    required String meetingKey,
    required String sessionKey,
  });
}
