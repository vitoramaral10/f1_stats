import 'package:f1_stats/presentation/presenters/getx_seasons_presenter.dart';
import 'package:get/get.dart';

import '../../../factories.dart';

Bindings? makeSeasonsBindings() => _SeasonsBindings();

class _SeasonsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxSeasonsPresenter(
        loadSeasons: makeFirebaseLoadSeasons(),
      ),
    );
  }
}
