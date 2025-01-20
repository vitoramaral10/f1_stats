import '../entities/entities.dart';

abstract class LoadWeather {
  Future<List<WeatherEntity>> call({required int sessionKey});
}
