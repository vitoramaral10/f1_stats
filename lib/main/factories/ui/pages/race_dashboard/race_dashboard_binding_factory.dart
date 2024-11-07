import 'package:get/get.dart';

import '../../../../../presentation/presenters/presenters.dart';
import '../../../factories.dart';

Bindings? makeRaceDashboardBinding() => _RaceDashboardBinding();

class _RaceDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxRaceDashboardPresenter(
        loadMeetings: makeRemoteLoadMeetings(),
      ),
    );
  }
}
