class SessionEntity {
  final int sessionKey;
  final String sessionName;
  final DateTime dateEnd;
  final DateTime dateStart;
  final String location;
  final String countryName;
  final String sessionType;
  final String gmtOffset;
  final String circuitShortName;

  SessionEntity({
    required this.sessionKey,
    required this.sessionName,
    required this.dateEnd,
    required this.dateStart,
    required this.location,
    required this.countryName,
    required this.sessionType,
    required this.gmtOffset,
    required this.circuitShortName,
  });
}
