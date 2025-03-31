import '../../domain/entities/entities.dart';

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

  factory IntervalModel.fromJson(Map<String, dynamic> json) {
    return IntervalModel(
      date: DateTime.parse(json['date']),
      driverNumber: json['driver_number'],
      gapToLeader: json['gap_to_leader'] == null
          ? null
          : json['gap_to_leader'] is String
              ? json['gap_to_leader']
              : Duration(
                  milliseconds: (json['gap_to_leader'] * 1000).round(),
                ),
      interval: json['interval'] == null
          ? null
          : json['interval'] is String
              ? json['interval']
              : Duration(
                  milliseconds: (json['interval'] * 1000).round(),
                ),
      meetingKey: json['meeting_key'],
      sessionKey: json['session_key'],
    );
  }

  IntervalEntity toEntity() {
    return IntervalEntity(
      date: date,
      driverNumber: driverNumber,
      gapToLeader: gapToLeader,
      interval: interval,
      meetingKey: meetingKey,
      sessionKey: sessionKey,
    );
  }
}
