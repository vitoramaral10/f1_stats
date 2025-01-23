import '../../../domain/entities/entities.dart';

abstract class SessionPresenter {
  SessionEntity get session;
  List<RaceControlEntity> get raceControl;
  List<WeatherEntity> get weather;
  List<DriverEntity> get drivers;
  List<PositionEntity> get positions;
  List<StandingEntity> get standings;

  Future<void> getRaceControl();
  Future<void> getWeather();
  Future<void> getDrivers();
  Future<void> getPositions();
}
