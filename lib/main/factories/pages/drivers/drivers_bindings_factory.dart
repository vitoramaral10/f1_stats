import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings? makeGetxDriversBindings() => _DriversBindings();

class _DriversBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(GetxDriversController(
      openf1LoadDrivers: makeOpenF1LoadDrivers(),
      firebaseLoadDrivers: makeFirebaseLoadDrivers(),
      firebaseSaveDriver: makeFirebaseSaveDriver(),
      firebaseUpdateDriver: makeFirebaseUpdateDriver(),
      firebaseRemoveDriver: makeFirebaseRemoveDriver(),
      vertexAiMergeDrivers: makeVertexAiMergeDrivers(),
    ));
  }
}
