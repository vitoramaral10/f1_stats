import '../entities/entities.dart';

abstract class LoadMeetings {
  Future<List<MeetingEntity>> call({
    int? year,
    String? meetingKey,
  });
}
