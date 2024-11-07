import 'package:flutter/material.dart';

class DriverEntity {
  final int sessionKey;
  final int meetingKey;
  final String broadcastName;
  final String countryCode;
  final String firstName;
  final String fullName;
  final String? headshotUrl;
  final String lastName;
  final int driverNumber;
  final Color teamColor;
  final String teamName;
  final String teamLogo;
  final String nameAcronym;

  DriverEntity({
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
    required this.teamLogo,
    required this.nameAcronym,
  });
}
