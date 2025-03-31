import 'package:get/get.dart';

import '../../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings makeSessionBindings() => _SessionBinding();

class _SessionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxSessionPresenter(
        loadRaceControl: makeRemoteLoadRaceControl(),
        loadWeather: makeRemoteLoadWeather(),
        loadDrivers: makeRemoteLoadDrivers(),
        loadPositions: makeRemoteLoadPositions(),
        loadIntervals: makeRemoteLoadIntervals(),
      ),
    );
  }
}
