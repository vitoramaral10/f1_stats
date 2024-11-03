import '../../domain/entities/entities.dart';

class SeasonModel {
  final String id;
  final int year;

  SeasonModel({
    required this.id,
    required this.year,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      id: json['id'],
      year: json['year'],
    );
  }

  SeasonEntity toEntity() => SeasonEntity(
        id: id,
        year: year,
      );
}
