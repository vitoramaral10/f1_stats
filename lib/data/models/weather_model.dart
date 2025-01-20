import 'package:f1_stats/domain/entities/entities.dart';

class WeatherModel {
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

  WeatherModel({
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

  factory WeatherModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'air_temperature',
      'date',
      'humidity',
      'meeting_key',
      'pressure',
      'rainfall',
      'session_key',
      'track_temperature',
      'wind_direction',
      'wind_speed',
    ])) {
      throw Exception();
    }

    return WeatherModel(
      airTemperature: json['air_temperature'],
      date: DateTime.parse(json['date']),
      humidity: json['humidity'] + 0.0,
      meetingKey: json['meeting_key'],
      pressure: json['pressure'],
      rainfall: json['rainfall'] + 0.0,
      sessionKey: json['session_key'],
      trackTemperature: json['track_temperature'],
      windDirection: json['wind_direction'],
      windSpeed: json['wind_speed'],
    );
  }

  WeatherEntity toEntity() => WeatherEntity(
        airTemperature: airTemperature,
        date: date,
        humidity: humidity,
        meetingKey: meetingKey,
        pressure: pressure,
        rainfall: rainfall,
        sessionKey: sessionKey,
        trackTemperature: trackTemperature,
        windDirection: windDirection,
        windSpeed: windSpeed,
      );
}
