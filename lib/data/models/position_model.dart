import '../../domain/entities/entities.dart';

class PositionModel {
  final int sessionKey;
  final int meetingKey;
  final int driverNumber;
  final DateTime date;
  final int position;

  PositionModel({
    required this.sessionKey,
    required this.meetingKey,
    required this.driverNumber,
    required this.date,
    required this.position,
  });

  factory PositionModel.fromJson(Map json) {
    return PositionModel(
      sessionKey: json['session_key'],
      meetingKey: json['meeting_key'],
      driverNumber: json['driver_number'],
      date: DateTime.parse(json['date']),
      position: json['position'],
    );
  }

  PositionEntity toEntity() => PositionEntity(
        sessionKey: sessionKey,
        meetingKey: meetingKey,
        driverNumber: driverNumber,
        date: date,
        position: position,
      );
}
