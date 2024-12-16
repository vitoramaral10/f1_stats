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

  GetxDriversController({
    required this.openf1LoadDrivers,
  });

  final _drivers = <DriverEntity>[].obs;

  @override
  List<DriverEntity> get drivers => _drivers;

  @override
  Future<void> importDrivers() async {
    try {
      isLoading = true;

      List<DriverEntity> drivers = await openf1LoadDrivers.call();

      drivers = drivers.toSet().toList();

      drivers.sort((a, b) => a.fullName.compareTo(b.fullName));

      _drivers.assignAll(drivers);

      isLoading = false;
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxDriversController.importDrivers');

      isLoading = false;
      mainError = UiError.unexpected;
    }
  }
}
