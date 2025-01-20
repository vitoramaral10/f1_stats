import '../entities/entities.dart';

abstract class LoadMeetings {
  Future<List<MeetingEntity>> call({required int year});
}
