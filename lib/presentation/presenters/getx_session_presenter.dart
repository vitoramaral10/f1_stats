import 'package:f1_stats/domain/entities/session_entity.dart';
import 'package:f1_stats/ui/pages/pages.dart';
import 'package:get/get.dart';

class GetxSessionPresenter extends GetxController implements SessionPresenter {
  GetxSessionPresenter();

  final _session = Rx<SessionEntity>(SessionEntity.empty());

  @override
  SessionEntity get session => _session.value;

  @override
  void onInit() {
    super.onInit();

    _session.value = Get.arguments['session'];
  }
}
