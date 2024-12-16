import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';

Bindings? makeGetxDriverDetailsBindings() => _DriverDetailsBindings();

class _DriverDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(GetxDriverDetailsPresenter());
  }
}
