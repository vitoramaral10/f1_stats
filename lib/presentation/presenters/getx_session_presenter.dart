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
  final LoadIntervals loadIntervals;
  final LoadLaps loadLaps;

  GetxSessionPresenter({
    required this.loadRaceControl,
    required this.loadWeather,
    required this.loadDrivers,
    required this.loadPosition,
    required this.loadIntervals,
    required this.loadLaps,
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
  final _intervals = RxList<IntervalEntity>([]);
  final _laps = RxList<LapEntity>([]);

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
  List<IntervalEntity> get intervals => _intervals;
  @override
  List<LapEntity> get laps => _laps;

  @override
  void onInit() {
    super.onInit();

    _session.value = Get.arguments['session'];

    getRaceControl();
    getWeather();
    getDrivers();
    getPositions();
    getIntervals();
    getLaps();

    // _standingsTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   getRaceControl();
    // });

    // _raceControlTimer = Timer.periodic(Duration(seconds: 5), (timer) {
    //   getRaceControl();
    //   getIntervals();
    // });

    // _weatherTimer = Timer.periodic(Duration(minutes: 1), (timer) {
    //   getWeather();
    // });
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
                drs: false,
                driverLastName: driver.lastName ?? '',
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
  Future<void> getIntervals() async {
    try {
      _intervals.value =
          await loadIntervals.call(sessionKey: session.sessionKey);

      _intervals.sort((a, b) => a.date.compareTo(b.date));

      for (var interval in _intervals) {
        var index = _standings.indexWhere(
            (element) => element.driverNumber == interval.driverNumber);

        if (index != -1) {
          _standings[index].interval = interval.interval;
          _standings[index].gap = interval.gapToLeader;
        }
      }
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getIntervals');
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Future<void> getLaps() async {
    try {
      _laps.value = await loadLaps.call(sessionKey: session.sessionKey);

      _laps.sort((a, b) =>
          (a.dateStart ?? DateTime(0)).compareTo(b.dateStart ?? DateTime(0)));

      for (var lap in _laps) {
        var index = _standings
            .indexWhere((element) => element.driverNumber == lap.driverNumber);

        if (index != -1) {
          _standings[index].lastLap = lap.lapDuration;
          _standings[index].firstSector = lap.durationSector1;
          _standings[index].secondSector = lap.durationSector2;
          _standings[index].thirdSector = lap.durationSector3;
        }
      }
    } on DomainError catch (error) {
      log(error.toString(), name: 'GetxSessionPresenter.getLaps');
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
