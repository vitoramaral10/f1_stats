import '../entities/entities.dart';

abstract class LoadDrivers {
  Future<List<DriverEntity>> call({required int sessionKey});
}
