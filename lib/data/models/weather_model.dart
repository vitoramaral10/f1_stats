import '../../domain/entities/entities.dart';

class WeatherModel {
  final double airTemperature;
  final DateTime date;
  final double humidity;
  final int meetingKey;
  final double pressure;
  final int rainfall;
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
    return WeatherModel(
      airTemperature: json['air_temperature'].toDouble(),
      date: DateTime.parse(json['date']),
      humidity: json['humidity'],
      meetingKey: json['meeting_key'],
      pressure: json['pressure'].toDouble(),
      rainfall: json['rainfall'],
      sessionKey: json['session_key'],
      trackTemperature: json['track_temperature'].toDouble(),
      windDirection: json['wind_direction'],
      windSpeed: json['wind_speed'].toDouble(),
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
