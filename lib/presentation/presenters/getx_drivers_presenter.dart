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

  GetxDriversController({
    required this.openf1LoadDrivers,
    required this.firebaseLoadDrivers,
    required this.firebaseSaveDriver,
  });

  final _drivers = <DriverEntity>[].obs;

  @override
  List<DriverEntity> get drivers => _drivers;

  @override
  Future<void> onInit() async {
    super.onInit();
    _drivers.value = await firebaseLoadDrivers.call();

    _drivers.sort(
        (a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
  }

  @override
  Future<void> importDrivers() async {
    try {
      isLoading = true;

      List<DriverEntity> driversOpenf1 = await openf1LoadDrivers.call();

      for (var driver in driversOpenf1) {
        await firebaseSaveDriver.call(driver);
      }

      _drivers.value = await firebaseLoadDrivers.call();

      _drivers.sort((a, b) =>
          a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));

      isLoading = false;
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxDriversController.importDrivers');

      isLoading = false;
      mainError = UiError.unexpected;
    }
  }
}
