import 'package:get/get.dart';

import '../../../../../presentation/presenters/presenters.dart';
import '../../../factories.dart';


Bindings? makeDriversBindings() => _DriversBindings();

class _DriversBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxDriversPresenter(
        loadDrivers: makeFirebaseLoadDrivers(),
      ),
    );
  }
}
