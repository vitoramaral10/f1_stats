import 'dart:developer';

import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxDriversController extends GetxController
    with LoadingManager, UIErrorManager
    implements DriversPresenter {
  final LoadDrivers openf1LoadDrivers;
  final LoadDrivers firebaseLoadDrivers;
  final SaveDriver firebaseSaveDriver;
  final UpdateDriver firebaseUpdateDriver;
  final RemoveDriver firebaseRemoveDriver;
  final MergeDrivers vertexAiMergeDrivers;

  GetxDriversController({
    required this.openf1LoadDrivers,
    required this.firebaseLoadDrivers,
    required this.firebaseSaveDriver,
    required this.firebaseUpdateDriver,
    required this.firebaseRemoveDriver,
    required this.vertexAiMergeDrivers,
  });

  final _drivers = <DriverEntity>[].obs;
  final _driversSelected = <String>[].obs;

  @override
  List<DriverEntity> get drivers => _drivers;
  @override
  List<String> get driversSelected => _driversSelected;

  @override
  Future<void> onInit() async {
    super.onInit();

    await loadDrivers();
  }

  @override
  Future<void> loadDrivers() async {
    try {
      _drivers.value = await firebaseLoadDrivers.call();

      _drivers.sort((a, b) =>
          a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
    } on Exception catch (e) {
      log(e.toString(), name: 'GetxDriversController.loadDrivers');
      mainError = UiError.unexpected;
    }
  }

  @override
  Future<void> importDrivers() async {
    try {
      isLoading = true;

      List<DriverEntity> driversOpenf1 = await openf1LoadDrivers.call();

      for (var element in driversOpenf1) {
        if (_drivers.any((d) =>
            d.fullName.toLowerCase() == element.fullName.toLowerCase())) {
          continue;
        }
        await firebaseSaveDriver.call(element);
      }

      await loadDrivers();

      isLoading = false;
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxDriversController.importDrivers');

      isLoading = false;
      mainError = UiError.unexpected;
    }
  }

  @override
  void selectDriver(DriverEntity driver) {
    if (_driversSelected.contains(driver.id)) {
      _driversSelected.remove(driver.id);
    } else {
      _driversSelected.add(driver.id ?? '');
    }
  }

  @override
  Future<void> mergeDrivers() async {
    // Faz um merge dos drivers selecionados usando o Gemini
    try {
      isLoading = true;

      final drivers = _driversSelected.map((id) {
        return _drivers.firstWhere((element) => element.id == id);
      }).toList();

      final driverMerged = await vertexAiMergeDrivers.call(drivers);

      await firebaseSaveDriver.call(driverMerged);

      for (var element in drivers) {
        await firebaseRemoveDriver.call(element.id ?? '');
      }

      _driversSelected.clear();

      await loadDrivers();

      isLoading = false;
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxDriversController.mergeDrivers');

      isLoading = false;
      mainError = UiError.unexpected;
    }
  }

  @override
  Future<void> deleteSelectedDrivers() async {
    try {
      isLoading = true;

      for (var id in _driversSelected) {
        firebaseRemoveDriver.call(id);
      }

      _driversSelected.clear();

      await loadDrivers();

      isLoading = false;
    } on DomainError catch (error) {
      log(error.toString(),
          name: 'GetxDriversController.deleteSelectedDrivers');

      isLoading = false;
      mainError = UiError.unexpected;
    }
  }
}
