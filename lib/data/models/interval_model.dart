import 'package:f1_stats/domain/entities/entities.dart';

class IntervalModel {
  final DateTime date;
  final int driverNumber;
  final dynamic gapToLeader;
  final dynamic interval;
  final int meetingKey;
  final int sessionKey;

  IntervalModel({
    required this.date,
    required this.driverNumber,
    this.gapToLeader,
    this.interval,
    required this.meetingKey,
    required this.sessionKey,
  });

  factory IntervalModel.fromJson(Map json) => IntervalModel(
        date: DateTime.parse(json['date']),
        driverNumber: json['driver_number'],
        gapToLeader: json['gap_to_leader'],
        interval: json['interval'],
        meetingKey: json['meeting_key'],
        sessionKey: json['session_key'],
      );

  IntervalEntity toEntity() => IntervalEntity(
        date: date,
        driverNumber: driverNumber,
        gapToLeader: gapToLeader,
        interval: interval,
        meetingKey: meetingKey,
        sessionKey: sessionKey,
      );
}
