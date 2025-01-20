import 'package:get/get.dart';

import '../../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings makeMeetingsBindings() => _MeetingsBinding();

class _MeetingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxMeetingsPresenter(
        loadMeetings: makeRemoteLoadMeetings(),
      ),
    );
  }
}
