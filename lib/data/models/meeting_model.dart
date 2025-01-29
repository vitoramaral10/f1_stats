import 'dart:convert';

import '../../domain/entities/entities.dart';

class MeetingModel {
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

  MeetingModel({
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

  factory MeetingModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'circuit_key',
      'circuit_short_name',
      'country_code',
      'country_key',
      'country_name',
      'date_start',
      'gmt_offset',
      'location',
      'meeting_key',
      'meeting_name',
      'meeting_official_name',
      'year',
    ])) {
      throw Exception();
    }

    return MeetingModel(
      circuitKey: json['circuit_key'],
      circuitShortName: json['circuit_short_name'],
      countryCode: json['country_code'],
      countryKey: json['country_key'],
      countryName: json['country_name'],
      dateStart: DateTime.parse(json['date_start']),
      gmtOffset: json['gmt_offset'],
      location: utf8.decode(json['location'].toString().codeUnits),
      meetingKey: json['meeting_key'],
      meetingName: utf8.decode(json['meeting_name'].toString().codeUnits),
      meetingOfficialName:
          utf8.decode(json['meeting_official_name'].toString().codeUnits),
      year: json['year'],
    );
  }

  MeetingEntity toEntity() => MeetingEntity(
        circuitKey: circuitKey,
        circuitShortName: circuitShortName,
        countryCode: countryCode,
        countryKey: countryKey,
        countryName: countryName,
        dateStart: dateStart,
        gmtOffset: gmtOffset,
        location: location,
        meetingKey: meetingKey,
        meetingName: meetingName,
        meetingOfficialName: meetingOfficialName,
        year: year,
      );
}
