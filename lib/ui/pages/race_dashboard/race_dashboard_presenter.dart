import '../../../domain/entities/entities.dart';

abstract class RaceDashboardPresenter {
  MeetingEntity? get meeting;

  Future<void> loadLatestMeeting();
}
