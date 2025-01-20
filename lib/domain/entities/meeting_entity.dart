class MeetingEntity {
  final int circuitKey;
  final String circuitShortName;
  final String countryCode;
  final int countryKey;
  final String countryName;
  final DateTime dateStart;
  final String gmtOffset;
  final String location;
  final int meetingKey;
  final String meetingName;
  final String meetingOfficialName;
  final int year;

  MeetingEntity({
    required this.circuitKey,
    required this.circuitShortName,
    required this.countryCode,
    required this.countryKey,
    required this.countryName,
    required this.dateStart,
    required this.gmtOffset,
    required this.location,
    required this.meetingKey,
    required this.meetingName,
    required this.meetingOfficialName,
    required this.year,
  });

  factory MeetingEntity.empty() => MeetingEntity(
        circuitKey: 0,
        circuitShortName: '',
        countryCode: '',
        countryKey: 0,
        countryName: '',
        dateStart: DateTime.now(),
        gmtOffset: '',
        location: '',
        meetingKey: 0,
        meetingName: '',
        meetingOfficialName: '',
        year: 0,
      );
}
