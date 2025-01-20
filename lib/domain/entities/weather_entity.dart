class WeatherEntity {
  final double airTemperature;
  final DateTime date;
  final double humidity;
  final int meetingKey;
  final double pressure;
  final double rainfall;
  final int sessionKey;
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
