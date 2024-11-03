import 'dart:developer';

import 'package:f1_stats/domain/entities/driver_entity.dart';
import 'package:get/get.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxDriversPresenter extends GetxController implements DriversPresenter {
  final LoadDrivers loadDrivers;

  GetxDriversPresenter({required this.loadDrivers});

  final _drivers = Rx<List<DriverEntity>>(<DriverEntity>[]);

  @override
  List<DriverEntity> get drivers => _drivers.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAllDrivers();
  }

  @override
  Future<void> getAllDrivers() async {
    try {
      _drivers.value = await loadDrivers.call();
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxDriversPresenter.getAllDrivers');
      _drivers.value = <DriverEntity>[];
    }
  }
}
