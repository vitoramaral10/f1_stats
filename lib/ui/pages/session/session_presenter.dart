import '../../../domain/entities/entities.dart';

abstract class SessionPresenter {
  SessionEntity get session;
  List<RaceControlEntity> get raceControl;
  List<WeatherEntity> get weather;
  List<DriverEntity> get drivers;
  List<IntervalEntity> get intervals;
  List<LapEntity> get laps;

  Future<void> getRaceControl();
  Future<void> getWeather();
  Future<void> getDrivers();
  Future<void> getPositions();
  Future<void> getIntervals();
  Future<void> getLaps();
}
