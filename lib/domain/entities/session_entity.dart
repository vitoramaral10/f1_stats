class SessionEntity {
  final int circuitKey;
  final String circuitShortName;
  final String countryCode;
  final int countryKey;
  final String countryName;
  final DateTime dateEnd;
  final DateTime dateStart;
  final String gmtOffset;
  final String location;
  final int meetingKey;
  final int sessionKey;
  final String sessionName;
  final String sessionType;
  final int year;

  SessionEntity({
    required this.circuitKey,
    required this.circuitShortName,
    required this.countryCode,
    required this.countryKey,
    required this.countryName,
    required this.dateEnd,
    required this.dateStart,
    required this.gmtOffset,
    required this.location,
    required this.meetingKey,
    required this.sessionKey,
    required this.sessionName,
    required this.sessionType,
    required this.year,
  });

  factory SessionEntity.empty() => SessionEntity(
        circuitKey: 0,
        circuitShortName: '',
        countryCode: '',
        countryKey: 0,
        countryName: '',
        dateEnd: DateTime.now(),
        dateStart: DateTime.now(),
        gmtOffset: '',
        location: '',
        meetingKey: 0,
        sessionKey: 0,
        sessionName: '',
        sessionType: '',
        year: 0,
      );
}
