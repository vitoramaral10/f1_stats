class IntervalEntity {
  final DateTime date;
  final int driverNumber;
  final dynamic gapToLeader;
  final dynamic interval;
  final int meetingKey;
  final int sessionKey;

  IntervalEntity({
    required this.date,
    required this.driverNumber,
    this.gapToLeader,
    this.interval,
    required this.meetingKey,
    required this.sessionKey,
  });
}
