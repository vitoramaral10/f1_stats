class LapEntity {
  final DateTime? dateStart;
  final int driverNumber;
  final double? durationSector1;
  final double? durationSector2;
  final double? durationSector3;
  final int? i1Speed;
  final int? i2Speed;
  final bool isPitOutLap;
  final double? lapDuration;
  final int lapNumber;
  final int meetingKey;
  final List<int> segmentsSector1;
  final List<int> segmentsSector2;
  final List<int> segmentsSector3;
  final int sessionKey;
  final int? stSpeed;

  LapEntity({
    this.dateStart,
    required this.driverNumber,
    this.durationSector1,
    this.durationSector2,
    this.durationSector3,
    this.i1Speed,
    this.i2Speed,
    required this.isPitOutLap,
    this.lapDuration,
    required this.lapNumber,
    required this.meetingKey,
    required this.segmentsSector1,
    required this.segmentsSector2,
    required this.segmentsSector3,
    required this.sessionKey,
    this.stSpeed,
  });
}
