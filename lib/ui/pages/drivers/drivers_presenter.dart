import '../../../domain/entities/entities.dart';

abstract class DriversPresenter {
  List<DriverEntity> get drivers;

  Future<void> importDrivers();
}
