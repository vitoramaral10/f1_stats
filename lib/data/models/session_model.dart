import '../../domain/entities/entities.dart';

class SessionModel {
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

  SessionModel({
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

  factory SessionModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'circuit_key',
      'circuit_short_name',
      'country_code',
      'country_key',
      'country_name',
      'date_end',
      'date_start',
      'gmt_offset',
      'location',
      'meeting_key',
      'session_key',
      'session_name',
      'session_type',
      'year',
    ])) {
      throw Exception();
    }

    return SessionModel(
      circuitKey: json['circuit_key'],
      circuitShortName: json['circuit_short_name'],
      countryCode: json['country_code'],
      countryKey: json['country_key'],
      countryName: json['country_name'],
      dateEnd: DateTime.parse(json['date_end']),
      dateStart: DateTime.parse(json['date_start']),
      gmtOffset: json['gmt_offset'],
      location: json['location'],
      meetingKey: json['meeting_key'],
      sessionKey: json['session_key'],
      sessionName: json['session_name'],
      sessionType: json['session_type'],
      year: json['year'],
    );
  }

  SessionEntity toEntity() => SessionEntity(
        circuitKey: circuitKey,
        circuitShortName: circuitShortName,
        countryCode: countryCode,
        countryKey: countryKey,
        countryName: countryName,
        dateEnd: dateEnd,
        dateStart: dateStart,
        gmtOffset: gmtOffset,
        location: location,
        meetingKey: meetingKey,
        sessionKey: sessionKey,
        sessionName: sessionName,
        sessionType: sessionType,
        year: year,
      );
}
