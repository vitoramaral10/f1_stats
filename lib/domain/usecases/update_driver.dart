import '../entities/entities.dart';

abstract class UpdateDriver {
  Future<void> call(DriverEntity driver);
}
