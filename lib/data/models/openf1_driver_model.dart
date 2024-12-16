import '../../domain/entities/entities.dart';

class Openf1DriverModel {
  final int driverNumber;
  final String broadcastName;
  final String fullName;
  final String nameAcronym;
  final String? teamName;
  final String? teamColour;
  final String? firstName;
  final String? lastName;
  final String? headshotUrl;
  final String? countryCode;
  final int sessionKey;
  final int meetingKey;

  Openf1DriverModel({
    required this.driverNumber,
    required this.broadcastName,
    required this.fullName,
    required this.nameAcronym,
    required this.teamName,
    required this.teamColour,
    required this.firstName,
    required this.lastName,
    required this.headshotUrl,
    required this.countryCode,
    required this.sessionKey,
    required this.meetingKey,
  });

  factory Openf1DriverModel.fromJson(Map json) => Openf1DriverModel(
        driverNumber: json['driver_number'],
        broadcastName: json['broadcast_name'],
        fullName: json['full_name'],
        nameAcronym: json['name_acronym'],
        teamName: json['team_name'],
        teamColour: json['team_colour'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        headshotUrl: json['headshot_url'],
        countryCode: json['country_code'],
        sessionKey: json['session_key'],
        meetingKey: json['meeting_key'],
      );

  DriverEntity toEntity() => DriverEntity(
        driverNumber: driverNumber,
        fullName: fullName,
        nameAcronym: nameAcronym,
        headshotUrl: headshotUrl,
        countryCode: countryCode,
        
      );
}
