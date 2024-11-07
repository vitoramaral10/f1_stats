import '../entities/entities.dart';

abstract class LoadDrivers {
  Future<List<DriverEntity>> call({
    required String meetingKey,
    String? sessionKey,
  });
}
