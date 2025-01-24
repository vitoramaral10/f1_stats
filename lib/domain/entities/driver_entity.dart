class DriverEntity {
  final String broadcastName;
  final String? countryCode;
  final int driverNumber;
  final String? firstName;
  final String fullName;
  final String? headshotUrl;
  final String? lastName;
  final int meetingKey;
  final String nameAcronym;
  final int sessionKey;
  final String? teamColour;
  final String? teamName;

  DriverEntity({
    required this.broadcastName,
    this.countryCode,
    required this.driverNumber,
    this.firstName,
    required this.fullName,
    this.headshotUrl,
    this.lastName,
    required this.meetingKey,
    required this.nameAcronym,
    required this.sessionKey,
    this.teamColour,
    this.teamName,
  });
}
