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
  final LoadPosition loadPosition;

  GetxSessionPresenter({
    required this.loadRaceControl,
    required this.loadWeather,
    required this.loadDrivers,
    required this.loadPosition,
  });

  Timer _weatherTimer = Timer(Duration(minutes: 1), () {});
  Timer _raceControlTimer = Timer(Duration(seconds: 1), () {});

  final _session = Rx<SessionEntity>(SessionEntity.empty());
  final _raceControl = RxList<RaceControlEntity>([]);
  final _weather = RxList<WeatherEntity>([]);
  final _drivers = RxList<DriverEntity>([]);
  final _positions = RxList<PositionEntity>([]);
  final _standings = RxList<StandingEntity>([]);

  @override
  SessionEntity get session => _session.value;
  @override
  List<RaceControlEntity> get raceControl => _raceControl;
  @override
  List<WeatherEntity> get weather => _weather;
  @override
  List<DriverEntity> get drivers => _drivers;
  @override
  List<PositionEntity> get positions => _positions;
  @override
  List<StandingEntity> get standings => _standings;

  @override
  void onInit() {
    super.onInit();

    _session.value = Get.arguments['session'];

    getRaceControl();
    getWeather();
    getDrivers();
    getPositions();

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
      var result = await loadRaceControl.call(sessionKey: session.sessionKey);

      result.sort((a, b) => b.date.compareTo(a.date));
      _raceControl.value = result;
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
      _weather.value = await loadWeather.call(sessionKey: session.sessionKey);
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
      _drivers.value = await loadDrivers.call(sessionKey: session.sessionKey);
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
  Future<void> getPositions() async {
    try {
      List<PositionEntity> result =
          await loadPosition.call(sessionKey: session.sessionKey);

      result.sort((a, b) => b.date.compareTo(a.date));

      for (var i = 1; i <= 20; i++) {
        var position = result.firstWhere(
          (element) => element.position == i,
        );

        _standings.add(StandingEntity(
          position: i,
          driverAcronym: _drivers
              .firstWhere(
                (element) => element.driverNumber == position.driverNumber,
              )
              .nameAcronym,
        ));
      }
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getPositions');
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
