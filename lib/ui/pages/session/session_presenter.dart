import '../../../domain/entities/entities.dart';

abstract class SessionPresenter {
  SessionEntity get session;
  List<RaceControlEntity> get raceControl;
  List<WeatherEntity> get weather;
  List<PositionEntity> get positions;
  List<DriverEntity> get drivers;

  Future<void> getRaceControl();
  Future<void> getWeather();
  Future<void> getPositions();
  Future<void> getDrivers();
}
