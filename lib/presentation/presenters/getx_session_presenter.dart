import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxSessionPresenter extends GetxController implements SessionPresenter {
  final LoadWeather loadWeather;

  GetxSessionPresenter({
    required this.loadWeather,
  });

  final _session = Rxn<SessionEntity>();
  final _weather = Rxn<WeatherEntity>();

  @override
  SessionEntity? get session => _session.value;
  @override
  WeatherEntity? get weather => _weather.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    _session.value = Get.arguments as SessionEntity;

    getWeather();

    Timer.periodic(const Duration(minutes: 1), (_) => getWeather());
  }

  @override
  Future<void> getWeather() async {
    try {
      final result = await loadWeather.call(sessionKey: session!.sessionKey);

      _weather.value = result.last;
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxHomePresenter.loadData');
      throw UiError.unexpected;
    }
  }
}
