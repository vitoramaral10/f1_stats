import 'package:firebase_vertexai/firebase_vertexai.dart';

import '../../domain/entities/entities.dart';

class VertexAiDriverModel {
  final int driverNumber;
  final String fullName;
  final String countryCode;
  final String headshotUrl;
  final String nameAcronym;
  final String team;
  final List<int> seasons;

  VertexAiDriverModel({
    required this.driverNumber,
    required this.fullName,
    required this.countryCode,
    required this.headshotUrl,
    required this.nameAcronym,
    required this.team,
    required this.seasons,
  });

  factory VertexAiDriverModel.fromJson(Map json) => VertexAiDriverModel(
        driverNumber: json['driverNumber'],
        fullName: json['fullName'],
        countryCode: json['countryCode'],
        headshotUrl: json['headshotUrl'],
        nameAcronym: json['nameAcronym'],
        team: json['team'],
        seasons: List<int>.from(json['seasons']),
      );

  DriverEntity toEntity() => DriverEntity(
        driverNumber: driverNumber,
        fullName: fullName,
        countryCode: countryCode,
        headshotUrl: headshotUrl,
        nameAcronym: nameAcronym,
        team: team,
        seasons: seasons,
      );

  static Schema schema = Schema.object(properties: {
    'driverNumber': Schema.integer(),
    'fullName': Schema.string(),
    'countryCode': Schema.string(),
    'headshotUrl': Schema.string(),
    'nameAcronym': Schema.string(),
    'team': Schema.string(),
    'seasons': Schema.array(items: Schema.integer()),
  });
}
