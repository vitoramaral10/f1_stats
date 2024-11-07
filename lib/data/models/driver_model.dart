import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

class DriverModel {
  final int sessionKey;
  final int meetingKey;
  final String broadcastName;
  final String countryCode;
  final String firstName;
  final String fullName;
  final String? headshotUrl;
  final String lastName;
  final int driverNumber;
  final String teamColor;
  final String teamName;
  final String nameAcronym;

  DriverModel({
    required this.sessionKey,
    required this.meetingKey,
    required this.broadcastName,
    required this.countryCode,
    required this.firstName,
    required this.fullName,
    this.headshotUrl,
    required this.lastName,
    required this.driverNumber,
    required this.teamColor,
    required this.teamName,
    required this.nameAcronym,
  });

  factory DriverModel.fromJson(Map json) {
    return DriverModel(
      sessionKey: json['session_key'],
      meetingKey: json['meeting_key'],
      broadcastName: utf8.decode(json['broadcast_name'].runes.toList()),
      countryCode: json['country_code'],
      firstName: utf8.decode(json['first_name'].runes.toList()),
      fullName: utf8.decode(json['full_name'].runes.toList()),
      headshotUrl: json['headshot_url'],
      lastName: utf8.decode(json['last_name'].runes.toList()),
      driverNumber: json['driver_number'],
      teamColor: json['team_colour'],
      teamName: utf8.decode(json['team_name'].runes.toList()),
      nameAcronym: utf8.decode(json['name_acronym'].runes.toList()),
    );
  }

  DriverEntity toEntity() => DriverEntity(
        sessionKey: sessionKey,
        meetingKey: meetingKey,
        broadcastName: broadcastName,
        countryCode: countryCode,
        firstName: firstName,
        fullName: fullName,
        headshotUrl: headshotUrl,
        lastName: lastName,
        driverNumber: driverNumber,
        teamColor: Color(int.parse('0xFF$teamColor')),
        teamName: teamName,
        nameAcronym: nameAcronym,
      );
}
