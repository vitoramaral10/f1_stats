import 'package:get/get.dart';

import '../../../../../presentation/presenters/presenters.dart';

Bindings? makeSessionBinding() => _SessionBinding();

class _SessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetxSessionPresenter());
  }
}
