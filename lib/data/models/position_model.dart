import '../../domain/entities/entities.dart';

class PositionModel {
  final DateTime date;
  final int driverNumber;
  final int meetingKey;
  final int position;
  final int sessionKey;

  PositionModel({
    required this.date,
    required this.driverNumber,
    required this.meetingKey,
    required this.position,
    required this.sessionKey,
  });

  factory PositionModel.fromJson(Map json) {
    return PositionModel(
      date: DateTime.parse(json['date']),
      driverNumber: json['driver_number'],
      meetingKey: json['meeting_key'],
      position: json['position'],
      sessionKey: json['session_key'],
    );
  }

  PositionEntity toEntity() => PositionEntity(
        date: date,
        driverNumber: driverNumber,
        meetingKey: meetingKey,
        position: position,
        sessionKey: sessionKey,
      );
}
