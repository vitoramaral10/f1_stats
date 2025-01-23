class StandingEntity {
  int position;
  final String driverAcronym;
  final int driverNumber;
  final Duration? gap;
  final Duration interval;
  final Duration lastLap;
  final bool drs;
  final String driverLastName;
  final Duration firstSector;
  final Duration secondSector;
  final Duration thirdSector;

  StandingEntity({
    required this.position,
    required this.driverAcronym,
    required this.driverNumber,
    this.gap,
    required this.interval,
    required this.lastLap,
    required this.drs,
    required this.driverLastName,
    required this.firstSector,
    required this.secondSector,
    required this.thirdSector,
  });
}
