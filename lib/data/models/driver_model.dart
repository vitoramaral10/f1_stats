import 'package:f1_stats/domain/entities/entities.dart';

class DriverModel {
  final String broadcastName;
  final String countryCode;
  final int driverNumber;
  final String firstName;
  final String fullName;
  final String? headshotUrl;
  final String lastName;
  final int meetingKey;
  final String nameAcronym;
  final int sessionKey;
  final String teamColour;
  final String teamName;

  DriverModel({
    required this.broadcastName,
    required this.countryCode,
    required this.driverNumber,
    required this.firstName,
    required this.fullName,
     this.headshotUrl,
    required this.lastName,
    required this.meetingKey,
    required this.nameAcronym,
    required this.sessionKey,
    required this.teamColour,
    required this.teamName,
  });

  factory DriverModel.fromJson(Map json) {
    return DriverModel(
      broadcastName: json['broadcast_name'],
      countryCode: json['country_code'],
      driverNumber: json['driver_number'],
      firstName: json['first_name'],
      fullName: json['full_name'],
      headshotUrl: json['headshot_url'],
      lastName: json['last_name'],
      meetingKey: json['meeting_key'],
      nameAcronym: json['name_acronym'],
      sessionKey: json['session_key'],
      teamColour: json['team_colour'],
      teamName: json['team_name'],
    );
  }

  DriverEntity toEntity() => DriverEntity(
        broadcastName: broadcastName,
        countryCode: countryCode,
        driverNumber: driverNumber,
        firstName: firstName,
        fullName: fullName,
        headshotUrl: headshotUrl,
        lastName: lastName,
        meetingKey: meetingKey,
        nameAcronym: nameAcronym,
        sessionKey: sessionKey,
        teamColour: teamColour,
        teamName: teamName,
      );
}
