class PositionEntity {
  final int sessionKey;
  final int meetingKey;
  final int driverNumber;
  final DateTime date;
  final int position;

  PositionEntity({
    required this.sessionKey,
    required this.meetingKey,
    required this.driverNumber,
    required this.date,
    required this.position,
  });
}
