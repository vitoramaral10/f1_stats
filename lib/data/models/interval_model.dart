import '../../domain/entities/entities.dart';

class IntervalModel {
  final int sessionKey;
  final int meetingKey;
  final DateTime date;
  final int driverNumber;
  final dynamic gapToLeader;
  final dynamic interval;

  IntervalModel({
    required this.sessionKey,
    required this.meetingKey,
    required this.date,
    required this.driverNumber,
    this.gapToLeader,
    this.interval,
  });

  factory IntervalModel.fromJson(Map json) {
    return IntervalModel(
      sessionKey: json['session_key'],
      meetingKey: json['meeting_key'],
      date: DateTime.parse(json['date']),
      driverNumber: json['driver_number'],
      gapToLeader: json['gap_to_leader'],
      interval: json['interval'],
    );
  }

  IntervalEntity toEntity() => IntervalEntity(
        sessionKey: sessionKey,
        meetingKey: meetingKey,
        date: date,
        driverNumber: driverNumber,
        gapToLeader: gapToLeader,
        interval: interval,
      );
}
