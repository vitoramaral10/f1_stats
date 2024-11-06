import 'package:get/get.dart';

import '../../../../../presentation/presenters/presenters.dart';
import '../../../factories.dart';

Bindings? makeSessionBinding() => _SessionBinding();

class _SessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetxSessionPresenter(
      loadWeather: makeRemoteLoadWeather(),
    ));
  }
}
