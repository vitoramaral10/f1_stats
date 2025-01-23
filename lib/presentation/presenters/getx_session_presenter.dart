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

  Timer _standingsTimer = Timer(Duration(seconds: 1), () {});
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

    _standingsTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      getRaceControl();
    });

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

      _standings.value = _drivers
          .map((driver) => StandingEntity(
                position: 0,
                driverAcronym: driver.nameAcronym,
                driverNumber: driver.driverNumber,
                gap: Duration(
                  seconds: 32,
                  milliseconds: 123,
                ),
                interval: Duration(seconds: 0),
                lastLap: Duration(seconds: 0),
                drs: false,
                driverLastName: driver.lastName ?? '',
                firstSector: Duration(seconds: 0),
                secondSector: Duration(seconds: 0),
                thirdSector: Duration(seconds: 0),
              ))
          .toList();
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

      for (var pos in result) {
        //atualiza a posição do piloto na lista de standings
        var index = _standings
            .indexWhere((element) => element.driverNumber == pos.driverNumber);

        if (index != -1) {
          _standings[index].position = pos.position;

          _standings.sort((a, b) => a.position.compareTo(b.position));
        }
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
    _standingsTimer.cancel();
    _raceControlTimer.cancel();
    _weatherTimer.cancel();
    super.onClose();
  }
}
