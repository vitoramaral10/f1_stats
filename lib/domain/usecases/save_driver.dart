import 'package:f1_stats/domain/entities/entities.dart';

abstract class SaveDriver {
  Future<void> call(DriverEntity driver);
}
