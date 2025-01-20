import '../../domain/entities/entities.dart';

class RaceControlModel {
  final String category;
  final DateTime date;
  final int? driverNumber;
  final String? flag;
  final int? lapNumber;
  final int meetingKey;
  final String message;
  final String? scope;
  final int? sector;
  final int sessionKey;

  RaceControlModel({
    required this.category,
    required this.date,
    this.driverNumber,
    this.flag,
    this.lapNumber,
    required this.meetingKey,
    required this.message,
    this.scope,
    required this.sector,
    required this.sessionKey,
  });

  factory RaceControlModel.fromJson(Map json) {
    return RaceControlModel(
      category: json['category'],
      date: DateTime.parse(json['date']),
      driverNumber: json['driver_number'],
      flag: json['flag'],
      lapNumber: json['lap_number'],
      meetingKey: json['meeting_key'],
      message: json['message'],
      scope: json['scope'],
      sector: json['sector'],
      sessionKey: json['session_key'],
    );
  }

  RaceControlEntity toEntity() => RaceControlEntity(
        category: category,
        date: date,
        driverNumber: driverNumber,
        flag: flag,
        lapNumber: lapNumber,
        meetingKey: meetingKey,
        message: message,
        scope: scope,
        sector: sector,
        sessionKey: sessionKey,
      );
}
