import 'package:get/get.dart';

import '../../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings makeSessionsBindings() => _SessionsBinding();

class _SessionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxSessionsPresenter(
        loadSessions: makeRemoteLoadSessions(),
      ),
    );
  }
}
