import '../entities/entities.dart';

abstract class SaveDriver {
  Future<void> call(DriverEntity driver);
}
