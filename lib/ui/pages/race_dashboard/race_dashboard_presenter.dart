import '../../../domain/entities/entities.dart';

abstract class RaceDashboardPresenter {
  MeetingEntity? get meeting;
  List<DriverEntity> get drivers;
  List<PositionEntity> get positions;

  Future<void> loadLatestMeeting();
  Future<void> getDrivers();
  Future<void> getLatestPosition();
}
