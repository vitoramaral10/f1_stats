import '../entities/entities.dart';

abstract class MergeDrivers {
  Future<DriverEntity> call(List<DriverEntity> drivers);
}
