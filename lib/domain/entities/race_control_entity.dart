class RaceControlEntity {
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

  RaceControlEntity({
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
}
