class DriverEntity {
  final String? id;
  final int driverNumber;
  final String fullName;
  final String nameAcronym;
  final String? headshotUrl;
  final String? countryCode;
  final String? team;
  final List<int> seasons;

  DriverEntity({
    this.id,
    required this.driverNumber,
    required this.fullName,
    required this.nameAcronym,
    this.headshotUrl,
    this.countryCode,
    this.team,
    required this.seasons,
  });

  Map<String, dynamic> toJson() => {
        'driverNumber': driverNumber,
        'fullName': fullName,
        'nameAcronym': nameAcronym,
        'headshotUrl': headshotUrl,
        'countryCode': countryCode,
        'team': team,
        'seasons': seasons,
      };
}
