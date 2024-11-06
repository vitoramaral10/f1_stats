import '../../../domain/entities/entities.dart';

abstract class SessionPresenter {
  SessionEntity? get session;
  WeatherEntity? get weather;

  Future<void> getWeather();
}
