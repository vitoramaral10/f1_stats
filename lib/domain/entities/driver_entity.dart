class DriverEntity {
  final int driverNumber;
  final String fullName;
  final String nameAcronym;
  final String? headshotUrl;
  final String? countryCode;
  final String? team;

  DriverEntity({
    required this.driverNumber,
    required this.fullName,
    required this.nameAcronym,
    this.headshotUrl,
    this.countryCode,
    this.team,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DriverEntity &&
            runtimeType == other.runtimeType &&
            fullName == other.fullName;
  }
  
  @override
  int get hashCode => fullName.hashCode;
  
}
