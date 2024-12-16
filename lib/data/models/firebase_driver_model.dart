import '../../domain/entities/entities.dart';

class FirebaseDriverModel {
  final String id;
  final int driverNumber;
  final String fullName;
  final String nameAcronym;
  final String? headshotUrl;
  final String? countryCode;
  final String? team;

  FirebaseDriverModel({
    required this.id,
    required this.driverNumber,
    required this.fullName,
    required this.nameAcronym,
    required this.headshotUrl,
    required this.countryCode,
    required this.team,
  });

  factory FirebaseDriverModel.fromJson(Map json) => FirebaseDriverModel(
        id: json['id'],
        driverNumber: json['driverNumber'],
        fullName: json['fullName'],
        nameAcronym: json['nameAcronym'],
        headshotUrl: json['headshotUrl'],
        countryCode: json['countryCode'],
        team: json['team'],
      );

  DriverEntity toEntity() => DriverEntity(
        id: id,
        driverNumber: driverNumber,
        fullName: fullName,
        nameAcronym: nameAcronym,
        headshotUrl: headshotUrl,
        countryCode: countryCode,
      );
}
