import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../ui/pages/pages.dart';

class GetxSessionPresenter extends GetxController implements SessionPresenter {
  final _session = Rxn<SessionEntity>();
  final _weather = Rxn<WeatherEntity>();

  @override
  SessionEntity? get session => _session.value;
  @override
  WeatherEntity? get weather => _weather.value;

  @override
  void onInit() {
    super.onInit();
    _session.value = Get.arguments as SessionEntity;

    _weather.value = WeatherEntity(
      airTemperature: 27.8,
      date: DateTime.now(),
      humidity: 58,
      meetingKey: 1,
      pressure: 1018.7,
      rainfall: 0,
      sessionKey: 1,
      trackTemperature: 52.5,
      windDirection: 136,
      windSpeed: 2.4,
    );
  }
}
