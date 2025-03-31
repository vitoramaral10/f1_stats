import '../../domain/entities/entities.dart';

class IntervalModel {
  final DateTime date;
  final int driverNumber;
  final double? gapToLeader;
  final double? interval;
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
      gapToLeader: double.tryParse(json['gap_to_leader'].toString()),
      interval: double.tryParse(json['interval'].toString()),
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
