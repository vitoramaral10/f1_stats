class WeatherEntity {
  final DateTime date;
  final int meetingKey;
  final int sessionKey;
  final double airTemperature;
  final double humidity;
  final double pressure;
  final double rainfall;
  final double trackTemperature;
  final int windDirection;
  final double windSpeed;

  WeatherEntity({
    required this.airTemperature,
    required this.date,
    required this.humidity,
    required this.meetingKey,
    required this.pressure,
    required this.rainfall,
    required this.sessionKey,
    required this.trackTemperature,
    required this.windDirection,
    required this.windSpeed,
  });
}
