import 'package:get/get.dart';

import '../../../../../presentation/presenters/presenters.dart';

Bindings makeSessionBindings() => _SessionBinding();

class _SessionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxSessionPresenter(),
    );
  }
}
