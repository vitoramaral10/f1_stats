import 'dart:async';
import 'dart:developer';

import 'package:f1_stats/domain/helpers/helpers.dart';
import 'package:f1_stats/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

class GetxSessionPresenter extends GetxController implements SessionPresenter {
  final LoadRaceControl loadRaceControl;
  final LoadWeather loadWeather;
  final LoadDrivers loadDrivers;

  GetxSessionPresenter({
    required this.loadRaceControl,
    required this.loadWeather,
    required this.loadDrivers,
  });

  Timer _weatherTimer = Timer(Duration(minutes: 1), () {});
  Timer _raceControlTimer = Timer(Duration(seconds: 1), () {});

  final _session = Rx<SessionEntity>(SessionEntity.empty());
  final _raceControl = RxList<RaceControlEntity>([]);
  final _weather = RxList<WeatherEntity>([]);
  final _drivers = RxList<DriverEntity>([]);

  @override
  SessionEntity get session => _session.value;
  @override
  List<RaceControlEntity> get raceControl => _raceControl;
  @override
  List<WeatherEntity> get weather => _weather;
  @override
  List<DriverEntity> get drivers => _drivers;

  @override
  void onInit() {
    super.onInit();

    _session.value = Get.arguments['session'];

    getRaceControl();
    getWeather();
    getDrivers();

    _raceControlTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      getRaceControl();
    });

    _weatherTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      getWeather();
    });
  }

  @override
  Future<void> getRaceControl() async {
    try {
      List<RaceControlEntity> result =
          await loadRaceControl.call(sessionKey: session.sessionKey);

      result.sort((a, b) => b.date.compareTo(a.date));

      _raceControl.assignAll(result);
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getRaceControl');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Future<void> getWeather() async {
    try {
      List<WeatherEntity> result =
          await loadWeather.call(sessionKey: session.sessionKey);

      result.sort((a, b) => a.date.compareTo(b.date));

      _weather.assignAll(result);
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getWeather');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Future<void> getDrivers() async {
    try {
      List<DriverEntity> result =
          await loadDrivers.call(sessionKey: session.sessionKey);

      _drivers.assignAll(result);
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getDrivers');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    _raceControlTimer.cancel();
    _weatherTimer.cancel();
    super.onClose();
  }
}
