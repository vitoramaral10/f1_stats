class DriverEntity {
  final String? id;
  final int driverNumber;
  final String fullName;
  final String nameAcronym;
  final String? headshotUrl;
  final String? countryCode;
  final String? team;

  DriverEntity({
    this.id,
    required this.driverNumber,
    required this.fullName,
    required this.nameAcronym,
    this.headshotUrl,
    this.countryCode,
    this.team,
  });

  Map<String, dynamic> toJson() => {
        'driverNumber': driverNumber,
        'fullName': fullName,
        'nameAcronym': nameAcronym,
        'headshotUrl': headshotUrl,
        'countryCode': countryCode,
        'team': team,
      };
}
