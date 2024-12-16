import '../../../domain/entities/entities.dart';

abstract class DriversPresenter {
  List<DriverEntity> get drivers;
  List<String> get driversSelected;

  Future<void> loadDrivers();
  Future<void> importDrivers();
  void selectDriver(DriverEntity driver);
  Future<void> mergeDrivers();
  Future<void> deleteSelectedDrivers();
}
