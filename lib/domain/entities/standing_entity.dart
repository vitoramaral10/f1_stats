class StandingEntity {
  int position;
  String driverAcronym;
  int driverNumber;
  dynamic gap;
  dynamic interval;
  double? lastLap;
  bool drs;
  String driverLastName;
  double? firstSector;
  double? secondSector;
  double? thirdSector;

  StandingEntity({
    required this.position,
    required this.driverAcronym,
    required this.driverNumber,
    this.gap,
    this.interval,
    this.lastLap,
    required this.drs,
    required this.driverLastName,
    this.firstSector,
    this.secondSector,
    this.thirdSector,
  });
}
