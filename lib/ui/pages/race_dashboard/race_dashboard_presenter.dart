import '../../../domain/entities/entities.dart';

abstract class RaceDashboardPresenter {
  MeetingEntity? get meeting;
  List<DriverEntity> get drivers;
  List<PositionEntity> get latestPositions;
  List<PositionEntity> get firstPositions;
  List<IntervalEntity> get intervals;

  Future<void> loadLatestMeeting();
  Future<void> getDrivers();
  Future<void> startLiveUpdates();
  Future<void> getLatestPosition();
  Future<void> getLatestInterval();
}
