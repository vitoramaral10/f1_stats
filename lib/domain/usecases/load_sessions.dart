import '../entities/entities.dart';

abstract class LoadSessions {
  Future<List<SessionEntity>> call({
    required int meetingKey,
  });
}
