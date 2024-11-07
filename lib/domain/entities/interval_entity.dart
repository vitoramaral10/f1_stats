class IntervalEntity {
  final int sessionKey;
  final int meetingKey;
  final DateTime date;
  final int driverNumber;
  final dynamic gapToLeader;
  final dynamic interval;

  IntervalEntity({
    required this.sessionKey,
    required this.meetingKey,
    required this.date,
    required this.driverNumber,
    required this.gapToLeader,
    required this.interval,
  });
}
