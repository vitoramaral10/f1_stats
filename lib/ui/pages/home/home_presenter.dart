import '../../../domain/entities/entities.dart';

abstract class HomePresenter {
  int get year;
  List<MeetingEntity> get meetings;
  List<SessionEntity> get sessions;
  int get selectedMeeting;

  Future<void> loadData();
  Future<void> getSessions(int meetingId);
}
