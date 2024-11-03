import '../../domain/entities/entities.dart';

class DriverModel {
  final String id;
  final String name;

  DriverModel({
    required this.id,
    required this.name,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      name: json['name'],
    );
  }

  DriverEntity toEntity() => DriverEntity(
        id: id,
        name: name,
      );
}
