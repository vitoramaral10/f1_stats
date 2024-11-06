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
    return MeetingModel(
      circuitKey: json['circuit_key'],
      circuitShortName: json['circuit_short_name'],
      countryCode: json['country_code'],
      countryKey: json['country_key'],
      countryName: json['country_name'],
      dateStart: DateTime.parse(json['date_start']),
      gmtOffset: json['gmt_offset'],
      location: json['location'],
      meetingKey: json['meeting_key'],
      meetingName: utf8.decode(json['meeting_name'].runes.toList()),
      meetingOfficialName: json['meeting_official_name'],
      year: json['year'],
    );
  }

  MeetingEntity toEntity() => MeetingEntity(
        id: meetingKey,
        name: meetingName,
        dateStart: dateStart,
      );
}
