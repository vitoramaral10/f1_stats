class LapEntity {
  final DateTime? date;
  final int driverNumber;
  final dynamic durationSector1;
  final dynamic durationSector2;
  final dynamic durationSector3;
  final int i1Speed;
  final int i2Speed;
  final bool isPitOutLap;
  final dynamic lapDuration;
  final int lapNumber;
  final int meetingKey;
  final int sessionKey;
  final int stSpeed;
  final List<int?> segmentsSector1;
  final List<int?> segmentsSector2;
  final List<int?> segmentsSector3;

  LapEntity({
    required this.date,
    required this.driverNumber,
    required this.durationSector1,
    required this.durationSector2,
    required this.durationSector3,
    required this.i1Speed,
    required this.i2Speed,
    required this.isPitOutLap,
    required this.lapDuration,
    required this.lapNumber,
    required this.meetingKey,
    required this.sessionKey,
    required this.stSpeed,
    required this.segmentsSector1,
    required this.segmentsSector2,
    required this.segmentsSector3,
  });
}
